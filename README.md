# 🇮🇷 Iran IP Master List / مرجع آی پی های ایران

## فارسی

**مرجع همه IPهای ایران** یک ریپازیتوری است که تمام رنج‌های IP مربوط به ایران را در قالب به‌روز ارائه می‌دهد. داده‌ها مستقیماً از **RIPE NCC** گرفته شده و به دو دسته اصلی تقسیم شده‌اند:

‏- **IPهای Routed (اعلام شده در اینترنت)**: رنج‌های IP که در جدول مسیریابی اینترنت فعال هستند.
  فایل‌ها: `iran_routed_ipv4.txt`، `iran_routed_ipv6.txt`
‏- **IPهای Registered (ثبت شده)**: رنج‌های IP که به طور رسمی به ایران اختصاص داده شده‌اند، صرف‌نظر از اینکه در حال حاضر در اینترنت اعلام شده باشند یا نه.
  فایل‌ها: `iran_registered_ipv4.txt`، `iran_registered_ipv6.txt`

### ویژگی‌ها:
- **همیشه به‌روز**: ریپازیتوری به طور منظم با آخرین داده‌های RIPE به‌روزرسانی می‌شود.  
- **فرمت ساده TXT**: قابل استفاده آسان در اسکریپت‌ها، فایروال‌ها و تنظیمات شبکه.  

### نحوه استفاده:
- از فایل‌های TXT برای قوانین فایروال یا اسکریپت‌های اتوماسیون استفاده کنید.  
- هر خط در فایل‌ها نشان‌دهنده یک رنج IP در فرمت CIDR است.

---

## English

**Iran IP Masterlist** is a centralized repository providing all the current IP ranges assigned to Iran. The data is fetched directly from **RIPE NCC** and categorized into two main types:

1. **Routed IPs**: IP ranges that are actively announced in the Internet routing tables.  
   - `iran_routed_ipv4.txt`  
   - `iran_routed_ipv6.txt`

2. **Registered IPs**: IP ranges officially registered for Iran, regardless of whether they are currently routed.  
   - `iran_registered_ipv4.txt`  
   - `iran_registered_ipv6.txt`

### Features:
- **Always up-to-date**: The repository is updated regularly to reflect the latest data from RIPE.  
- **Simple TXT format**: Easy to use in scripts, firewalls, or network configurations.  

### Usage:
- Use the TXT files in your firewall rules or automation scripts.  
- Each line in the files represents a single IP range in CIDR notation.
