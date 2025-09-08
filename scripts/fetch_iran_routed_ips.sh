#!/usr/bin/env bash
# iran_prefixes_from_ripestat_split.sh
# Extract Iran prefixes and separate IPv4 and IPv6

set -euo pipefail

COUNTRY="${COUNTRY:-ir}"
OUTDIR="output"
mkdir -p "$OUTDIR"

OUTFILE4="${OUTDIR}/${1:-iran_routed_ipv4.txt}"
OUTFILE6="${OUTDIR}/${2:-iran_routed_ipv6.txt}"
API_BASE="https://stat.ripe.net/data"
TMPDIR="$(mktemp -d)"
ASN_JSON="$TMPDIR/asn_list.json"
PREFIX_JSON="$TMPDIR/prefix.json"

cleanup() { rm -rf "$TMPDIR"; }
trap cleanup EXIT

command -v curl >/dev/null 2>&1 || { echo "curl is not installed."; exit 1; }
command -v jq   >/dev/null 2>&1 || { echo "jq is not installed."; exit 1; }

echo "[*] Fetching the list of Iran ASNs (lod=1) ..."
curl -fsSL "${API_BASE}/country-asns/data.json?resource=${COUNTRY}&lod=1" -o "$ASN_JSON"

ROUTED_TYPE="$(jq -r '.data.countries[0].routed | type' "$ASN_JSON" 2>/dev/null || echo "null")"

echo "[*] Extracting ASN numbers from response (${ROUTED_TYPE}) ..."
if [ "$ROUTED_TYPE" = "array" ]; then
  mapfile -t ASNS < <(
    jq -r '
      .data.countries[0].routed[]
      | if type=="object" and has("asn") then
          "AS\(.asn)"
        else
          (tostring | if test("^AS[0-9]+$") then . else "AS"+. end)
        end
    ' "$ASN_JSON" \
    | sed -E 's/^ASAS/AS/' \
    | sort -u
  )
elif [ "$ROUTED_TYPE" = "string" ]; then
  mapfile -t ASNS < <(
    jq -r '.data.countries[0].routed' "$ASN_JSON" \
    | grep -Eo '[0-9]{1,10}' \
    | awk '{print "AS"$0}' \
    | sort -u
  )
else
  echo "[-] Unexpected response structure."
  exit 1
fi

if [ "${#ASNS[@]}" -eq 0 ]; then
  echo "[-] No ASNs were extracted."
  exit 1
fi

echo "[+] Number of extracted ASNs: ${#ASNS[@]}"

# Clear output files
: > "$OUTFILE4"
: > "$OUTFILE6"

COUNT=0
for ASN in "${ASNS[@]}"; do
  COUNT=$((COUNT+1))
  printf "[%4d/%4d] %s ...\n" "$COUNT" "${#ASNS[@]}" "$ASN"

  if curl -fsSL "${API_BASE}/announced-prefixes/data.json?resource=${ASN}" -o "$PREFIX_JSON"; then
    # IPv4
    jq -r '.data.prefixes[] | .prefix | select(test(":")|not)' "$PREFIX_JSON" >> "$OUTFILE4" || true
    # IPv6
    jq -r '.data.prefixes[] | .prefix | select(test(":"))' "$PREFIX_JSON" >> "$OUTFILE6" || true
  else
    echo "    ⚠️ Failed to fetch prefixes for ${ASN}." >&2
  fi

  sleep 0.1
done

sort -u -o "$OUTFILE4" "$OUTFILE4"
sort -u -o "$OUTFILE6" "$OUTFILE6"

echo
echo "[✅] Done."

