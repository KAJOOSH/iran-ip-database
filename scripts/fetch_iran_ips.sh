#!/bin/bash

# دریافت داده‌ها از لینک RIPE
curl -s 'https://stat.ripe.net/data/country-resource-list/data.json?resource=IR' -o data.json

# بررسی موفقیت‌آمیز بودن دریافت داده‌ها
if [ $? -ne 0 ]; then
  echo "خطا در دریافت داده‌ها"
  exit 1
fi

mkdir -p output

# استخراج رنج‌های IPv4 و ذخیره در فایل
jq -r '.data.resources.ipv4[]' data.json > output/ipv4_ranges.txt

# استخراج رنج‌های IPv6 و ذخیره در فایل
jq -r '.data.resources.ipv6[]' data.json > output/ipv6_ranges.txt

# نمایش پیام موفقیت‌آمیز بودن عملیات
echo "رنج‌های IPv4 در فایل ipv4_ranges.txt و رنج‌های IPv6 در فایل ipv6_ranges.txt ذخیره شدند."
