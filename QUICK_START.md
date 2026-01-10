# 🚀 Quick Start - البدء السريع

دليل سريع للبدء في استخدام تطبيق Dawaii بعد الدمج مع My_medicinal backend.

---

## ⚡ البدء في 5 دقائق

### 1. تثبيت المتطلبات (دقيقة واحدة)

```bash
# تأكد من تثبيت Flutter
flutter --version

# Clone المشروع (إذا لم تفعل بعد)
git clone https://github.com/Mohamedsulima775/Dawaii_Android.git
cd Dawaii_Android

# التبديل للـ branch الجديد
git checkout claude/fix-security-mk7k0ltyymn2sqaf-LaahW
```

---

### 2. تكوين البيئة (دقيقتان)

#### أ. إنشاء ملف .env

```bash
# انسخ ملف المثال
cp .env.example .env

# عدّل القيم الأساسية في .env
nano .env  # أو استخدم محررك المفضل
```

**القيم الأساسية المطلوبة:**
```env
# في .env
DEV_BASE_URL=https://YOUR_BACKEND_IP:8000
ENVIRONMENT=development
```

#### ب. تحديث API Constants

```bash
# عدّل lib/core/constants/api_constants.dart
nano lib/core/constants/api_constants.dart
```

**غيّر:**
```dart
// من:
static const String devBaseUrl = 'https://localhost:8000';

// إلى:
static const String devBaseUrl = 'https://YOUR_ACTUAL_BACKEND_IP:8000';

// تأكد من:
static const String baseUrl = devBaseUrl;  // للتطوير
```

---

### 3. تثبيت Dependencies (دقيقة واحدة)

```bash
# احصل على جميع الـ packages
flutter pub get

# للتأكد من نجاح التثبيت
flutter doctor
```

---

### 4. إعداد Firebase (اختياري - دقيقة واحدة)

إذا كنت تريد استخدام Push Notifications:

```bash
# حمّل google-services.json من Firebase Console
# ضعه في: android/app/google-services.json

# تأكد من إضافة الملف
ls -la android/app/google-services.json
```

---

### 5. تشغيل التطبيق! 🎉

```bash
# تشغيل على جهاز/محاكي متصل
flutter run

# أو للـ release mode
flutter run --release
```

---

## 🧪 اختبار سريع

### الخطوة 1: تسجيل مستخدم جديد

من التطبيق:
1. افتح شاشة التسجيل
2. أدخل:
   - الاسم: "مستخدم تجريبي"
   - الجوال: "0500000001"
   - البريد: "test@example.com"
   - كلمة المرور: "Test@123456"
3. انقر "تسجيل"

**النتيجة المتوقعة:** ✅ تسجيل ناجح وتحويل للصفحة الرئيسية

---

### الخطوة 2: اختبار API من Terminal

```bash
# اختبر الاتصال بالـ backend
curl -v https://YOUR_BACKEND_URL/api/method/ping

# اختبر تسجيل الدخول
curl -X POST https://YOUR_BACKEND_URL/api/method/my_medicinal.api.patient.login \
  -H "Content-Type: application/json" \
  -d '{
    "mobile": "0500000001",
    "password": "Test@123456"
  }'
```

**النتيجة المتوقعة:**
```json
{
  "message": {
    "token": "eyJhbGc...",
    "patient_id": "PAT-0001",
    "patient_name": "مستخدم تجريبي"
  }
}
```

---

## 🔧 حل المشاكل السريع

### مشكلة: SSL Certificate Error

**الحل السريع للتطوير:**

```dart
// في lib/main.dart - أضف في بداية main()
import 'dart:io';

class DevHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (cert, host, port) => true;
  }
}

void main() {
  // للتطوير فقط!
  HttpOverrides.global = DevHttpOverrides();

  runApp(MyApp());
}
```

⚠️ **تحذير:** احذف هذا الكود قبل الإنتاج!

---

### مشكلة: Connection Refused

**تحقق من:**

```bash
# 1. Backend يعمل؟
curl https://YOUR_BACKEND_URL/api/method/ping

# 2. Firewall يسمح بالاتصال؟
# على Linux/Mac:
sudo ufw allow 8000

# 3. Backend يستمع على جميع الـ interfaces؟
# في frappe:
bench set-config -g serve_default_site 1
bench restart
```

---

### مشكلة: 401 Unauthorized

**السبب الأكثر شيوعاً:** الـ endpoint غير موجود في backend

**الحل:**

```python
# في My_medicinal/api/patient.py
# تأكد من وجود:

@frappe.whitelist(allow_guest=True)
def login(mobile, password):
    # ... الكود
    pass

@frappe.whitelist(allow_guest=True)
def register(patient_name, mobile, email, password, date_of_birth, gender):
    # ... الكود
    pass
```

---

## 📚 الخطوات التالية

بعد التشغيل الناجح:

### 1. اقرأ التوثيق الكامل

- 📖 **INTEGRATION_GUIDE.md** - دليل الدمج الشامل
- 🧪 **API_TESTING.md** - اختبار جميع الـ APIs
- 📊 **INTEGRATION_STATUS.md** - حالة التكامل

### 2. اختبر Features الأساسية

- [ ] تسجيل دخول/خروج
- [ ] عرض الأدوية
- [ ] حجز استشارة
- [ ] طلب من المتجر
- [ ] استقبال إشعارات

### 3. راجع الكود

```bash
# الملفات الأساسية للمراجعة:
lib/core/constants/api_constants.dart      # الـ API endpoints
lib/data/repositories/auth_repository_impl.dart  # Authentication
lib/presentation/providers/auth_provider.dart    # State management
lib/core/network/api_client.dart          # HTTP client
```

### 4. شغّل الاختبارات

```bash
# اختبارات الوحدة (Unit tests)
flutter test

# اختبارات التكامل (Integration tests)
flutter test integration_test/
```

---

## 💡 نصائح للتطوير

### 1. استخدم Hot Reload

```bash
# بعد flutter run، في Terminal:
r  # Hot reload
R  # Hot restart
q  # Quit
```

### 2. راقب الـ Logs

```bash
# Backend logs
tail -f ~/frappe-bench/logs/web.error.log

# Flutter logs
flutter run -v  # Verbose mode
```

### 3. استخدم Debug Tools

```dart
// في الكود
import 'package:flutter/foundation.dart';

if (kDebugMode) {
  print('Debug info: $someVariable');
}
```

### 4. استخدم Postman للـ API Testing

- استورد الـ collection من API_TESTING.md
- احفظ الـ token في environment variable
- اختبر جميع الـ endpoints

---

## 🎯 Checklist للبدء

- [ ] Flutter مثبت ويعمل
- [ ] Project مستنسخ ومحدث
- [ ] .env file تم إنشاؤه وتعديله
- [ ] API Constants محدثة بـ backend URL الصحيح
- [ ] Dependencies مثبتة (flutter pub get)
- [ ] Backend يعمل ويستجيب
- [ ] التطبيق يشتغل بدون أخطاء
- [ ] تسجيل مستخدم جديد ناجح
- [ ] تسجيل دخول ناجح

---

## 🆘 الحصول على المساعدة

### مشاكل تقنية

1. **راجع INTEGRATION_GUIDE.md** - قسم "حل المشاكل الشائعة"
2. **افتح Issue** على GitHub مع:
   - وصف المشكلة
   - خطوات إعادة الإنتاج
   - Logs/Screenshots
   - معلومات البيئة (OS, Flutter version)

### أسئلة عن الـ API

- **راجع API_TESTING.md** للأمثلة الكاملة
- **استخدم curl** لاختبار الـ endpoints مباشرة

### أسئلة عن الكود

- **راقب Comments** في الكود - موثق جيداً
- **راجع INTEGRATION_STATUS.md** لفهم البنية

---

## 🎉 تهانينا!

إذا وصلت هنا والتطبيق يعمل، أنت جاهز للبدء في التطوير! 🚀

**التطبيق الآن:**
- ✅ آمن (HTTPS, Encrypted storage)
- ✅ متصل بـ backend حقيقي
- ✅ جاهز للتطوير والإضافة عليه
- ✅ موثق بالكامل

---

**إعداد:** Claude Code
**التاريخ:** 2026-01-10
**الإصدار:** 1.0
