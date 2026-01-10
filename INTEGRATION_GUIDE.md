# دليل الدمج العملي - Dawaii Android App مع My_medicinal Backend

## 📋 نظرة عامة

هذا الدليل يشرح خطوات الدمج العملي لتطبيق Dawaii Android مع backend My_medicinal بعد إتمام جميع التحسينات الأمنية والتقنية.

---

## 🔧 الإعداد الأولي

### 1. تكوين البيئة

#### أ. إعداد الـ Backend URL

في ملف `lib/core/constants/api_constants.dart`:

```dart
// للبيئة التطويرية (Development)
static const String devBaseUrl = 'https://localhost:8000';  // أو عنوان IP الخاص بك

// للبيئة الإنتاجية (Production)
static const String prodBaseUrl = 'https://dawaii.com';  // غيّر هذا لعنوان السيرفر الحقيقي

// اختر البيئة المناسبة
static const String baseUrl = devBaseUrl;  // للتطوير
// static const String baseUrl = prodBaseUrl;  // للإنتاج
```

#### ب. إعداد HTTPS للتطوير المحلي

إذا كنت تستخدم localhost للتطوير:

**للـ Backend (ERPNext/Frappe):**
```bash
# في مجلد My_medicinal
bench set-ssl-certificate site1.local /path/to/cert.pem
bench set-ssl-private-key site1.local /path/to/key.pem

# أو استخدم أداة mkcert لإنشاء شهادات محلية
mkcert localhost 127.0.0.1 ::1
```

**للـ Android App:**
```bash
# في android/app/src/main/res/xml/network_security_config.xml
# السماح بـ localhost للتطوير فقط (احذف هذا في الإنتاج!)
```

---

## 🧪 الاختبار التدريجي

### المرحلة 1: اختبار الاتصال الأساسي

#### 1.1 اختبار ping للـ Backend

```bash
# من جهاز Android أو المحاكي
curl -v https://YOUR_BACKEND_URL/api/method/ping
```

**النتيجة المتوقعة:**
```json
{
  "message": "pong"
}
```

#### 1.2 تشغيل التطبيق للمرة الأولى

```bash
# في مجلد المشروع
flutter clean
flutter pub get
flutter run
```

**نقاط التحقق:**
- ✅ التطبيق يفتح بدون أخطاء
- ✅ لا توجد رسائل خطأ في console
- ✅ الشاشة الرئيسية تظهر بشكل صحيح

---

### المرحلة 2: اختبار Authentication

#### 2.1 اختبار تسجيل مستخدم جديد

**خطوات الاختبار:**

1. افتح التطبيق
2. اذهب إلى شاشة التسجيل
3. أدخل البيانات التالية:
   - الاسم: "مستخدم تجريبي"
   - رقم الجوال: "0500000001"
   - البريد الإلكتروني: "test@example.com"
   - كلمة المرور: "Test@123456"
   - تاريخ الميلاد: "1990-01-01"
   - الجنس: "ذكر"

**النتيجة المتوقعة:**
- ✅ يتم إنشاء حساب جديد
- ✅ يتم حفظ token في secure storage
- ✅ يتم تحويل المستخدم للشاشة الرئيسية
- ✅ يظهر اسم المستخدم في الواجهة

**في حالة الخطأ - تحقق من:**
```bash
# في backend logs
tail -f ~/frappe-bench/logs/web.error.log

# تأكد من تفعيل API endpoint في My_medicinal
# في ملف my_medicinal/api/patient.py
@frappe.whitelist(allow_guest=True)
def register(...):
    ...
```

#### 2.2 اختبار تسجيل الدخول

**خطوات الاختبار:**

1. سجّل خروج (Logout)
2. اذهب إلى شاشة تسجيل الدخول
3. أدخل:
   - رقم الجوال: "0500000001"
   - كلمة المرور: "Test@123456"

**النتيجة المتوقعة:**
- ✅ تسجيل دخول ناجح
- ✅ استرجاع بيانات المستخدم
- ✅ حفظ session جديد

#### 2.3 اختبار Secure Token Storage

```bash
# استخدم Android Studio Device File Explorer
# أو اختبر من داخل التطبيق

# في كود Flutter
final storage = FlutterSecureStorage();
final token = await storage.read(key: 'auth_token');
print('Token: $token');  // يجب أن يعرض token مشفر
```

**التحقق:**
- ✅ الـ tokens محفوظة بشكل آمن
- ✅ لا يمكن قراءة الـ tokens من ملفات عادية
- ✅ الـ tokens تبقى بعد إغلاق التطبيق

---

### المرحلة 3: اختبار الـ APIs الأساسية

#### 3.1 اختبار Medications API

**إنشاء بيانات تجريبية في Backend:**

```python
# في ERPNext Console
import frappe

# إنشاء medication schedule تجريبي
doc = frappe.get_doc({
    "doctype": "Medication Schedule",
    "patient": "PAT-0001",  # استبدله بـ patient_id من التسجيل
    "medication_name": "باراسيتامول",
    "dosage": "500mg",
    "frequency": "مرتين يومياً",
    "start_date": "2026-01-10",
    "times": [
        {"time": "08:00"},
        {"time": "20:00"}
    ]
})
doc.insert()
frappe.db.commit()
```

**اختبار من التطبيق:**
1. سجّل دخول
2. اذهب إلى شاشة الأدوية
3. تأكد من ظهور القائمة

**النتيجة المتوقعة:**
- ✅ ظهور قائمة الأدوية
- ✅ عرض التفاصيل بشكل صحيح
- ✅ أوقات التناول تظهر بشكل صحيح

#### 3.2 اختبار Orders API

**خطوات الاختبار:**
1. اذهب إلى متجر الأدوية
2. أضف منتج للسلة
3. أكمل الطلب
4. راقب حالة الطلب

**التحقق في Backend:**
```python
# في ERPNext
frappe.get_all('Order',
    filters={'patient': 'PAT-0001'},
    fields=['name', 'status', 'total_amount']
)
```

#### 3.3 اختبار Consultations API

**إنشاء استشارة تجريبية:**

1. من التطبيق، احجز استشارة مع طبيب
2. تحقق من ظهور الاستشارة في قائمتك
3. راقب تحديث الحالة (قيد الانتظار → مكتملة)

---

### المرحلة 4: اختبار Push Notifications

#### 4.1 إعداد FCM

**في Firebase Console:**
1. اذهب إلى Project Settings
2. حمّل `google-services.json`
3. ضعه في `android/app/`

**اختبار إرسال Token للـ Backend:**

```bash
# راقب logs التطبيق
flutter run

# ابحث عن:
✅ FCM token sent to backend successfully
```

**التحقق في Backend:**
```python
# في ERPNext
frappe.get_all('Device Registration',
    filters={'patient': 'PAT-0001'},
    fields=['fcm_token', 'platform', 'creation']
)
```

#### 4.2 اختبار إرسال إشعار

**من Backend:**
```python
import frappe
from my_medicinal.api.notifications import send_push_notification

send_push_notification(
    patient_id='PAT-0001',
    title='اختبار الإشعارات',
    body='هذا إشعار تجريبي',
    data={'type': 'test'}
)
```

**النتيجة المتوقعة:**
- ✅ وصول إشعار للجوال
- ✅ الإشعار يظهر في notification tray
- ✅ النقر على الإشعار يفتح التطبيق

---

## 🔍 حل المشاكل الشائعة

### مشكلة 1: SSL Certificate Error

**الخطأ:**
```
HandshakeException: Handshake error in client
```

**الحل:**
```dart
// للتطوير فقط - لا تستخدم في الإنتاج!
// في lib/core/network/api_client.dart

class DevHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (cert, host, port) => true;
  }
}

// في main.dart
void main() {
  HttpOverrides.global = DevHttpOverrides(); // للتطوير فقط!
  runApp(MyApp());
}
```

### مشكلة 2: CORS Error

**الخطأ:**
```
Cross-Origin Request Blocked
```

**الحل في Backend:**
```python
# في site_config.json
{
    "allow_cors": "*",
    "cors_allowed_origins": [
        "http://localhost",
        "https://localhost"
    ]
}

# أعد تشغيل bench
bench restart
```

### مشكلة 3: Authentication Failed

**الخطأ:**
```
401 Unauthorized
```

**التحقق:**

1. **تأكد من صحة endpoint:**
```python
# في my_medicinal/api/patient.py
@frappe.whitelist(allow_guest=True)
def login(mobile, password):
    # تأكد من وجود الدالة
```

2. **تحقق من صيغة الـ request:**
```dart
// في AuthApi
final response = await _apiClient.post(
  ApiConstants.login,
  body: {
    'mobile': mobile,      // تأكد من اسم الحقل
    'password': password,  // تأكد من اسم الحقل
  },
);
```

3. **راقب backend logs:**
```bash
tail -f ~/frappe-bench/logs/web.error.log
```

### مشكلة 4: Token Expiration

**الأعراض:**
- المستخدم مسجل دخول لكن الـ API تعيد 401

**الحل:**
```dart
// في api_client.dart - تفعيل auto token refresh

@override
Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
  if (err.response?.statusCode == 401) {
    // محاولة refresh token
    final authRepo = AuthRepositoryImpl(...);
    final result = await authRepo.refreshAuthToken();

    result.fold(
      (failure) => handler.reject(err),
      (newToken) async {
        // أعد المحاولة بـ token جديد
        err.requestOptions.headers['Authorization'] = 'Bearer $newToken';
        final response = await dio.fetch(err.requestOptions);
        handler.resolve(response);
      },
    );
  } else {
    handler.next(err);
  }
}
```

---

## 📊 Monitoring & Analytics

### تتبع الأخطاء

#### إعداد Sentry (اختياري)

```yaml
# في pubspec.yaml
dependencies:
  sentry_flutter: ^7.0.0
```

```dart
// في main.dart
import 'package:sentry_flutter/sentry_flutter.dart';

Future<void> main() async {
  await SentryFlutter.init(
    (options) {
      options.dsn = 'YOUR_SENTRY_DSN';
      options.environment = 'production';
    },
    appRunner: () => runApp(MyApp()),
  );
}
```

### Logging Strategy

```dart
// في lib/core/utils/logger.dart

class AppLogger {
  static void logApiCall(String endpoint, Map<String, dynamic>? data) {
    if (kDebugMode) {
      print('🌐 API Call: $endpoint');
      print('📤 Request: $data');
    }
  }

  static void logApiResponse(String endpoint, dynamic response) {
    if (kDebugMode) {
      print('✅ API Response: $endpoint');
      print('📥 Data: $response');
    }
  }

  static void logError(String message, dynamic error, StackTrace? stack) {
    if (kDebugMode) {
      print('❌ Error: $message');
      print('🔥 Exception: $error');
      print('📍 Stack: $stack');
    }
    // أرسل للـ Sentry في الإنتاج
    Sentry.captureException(error, stackTrace: stack);
  }
}
```

---

## ✅ Checklist قبل الإطلاق للإنتاج

### Security

- [ ] تغيير `baseUrl` من `devBaseUrl` إلى `prodBaseUrl`
- [ ] حذف أي `HttpOverrides` للـ SSL bypass
- [ ] التأكد من تشغيل HTTPS فقط
- [ ] مراجعة جميع الـ API keys وحفظها في متغيرات البيئة
- [ ] تفعيل certificate pinning

### Testing

- [ ] اختبار جميع الـ flows الأساسية
- [ ] اختبار على أجهزة مختلفة (Android 8+)
- [ ] اختبار مع اتصال إنترنت ضعيف
- [ ] اختبار offline mode (إن وجد)
- [ ] اختبار logout/login متعدد

### Performance

- [ ] تفعيل ProGuard/R8 للـ obfuscation
- [ ] ضغط الصور والـ assets
- [ ] تحسين حجم الـ APK
- [ ] تفعيل caching للـ API responses

### Compliance

- [ ] إضافة Privacy Policy
- [ ] إضافة Terms of Service
- [ ] التأكد من GDPR compliance (إن لزم)
- [ ] إضافة صفحة الموافقات (Permissions rationale)

---

## 🚀 الإطلاق التدريجي

### المرحلة 1: Closed Beta (1-2 أسابيع)
- اختبار مع 10-20 مستخدم
- جمع feedback
- إصلاح الأخطاء الحرجة

### المرحلة 2: Open Beta (2-4 أسابيع)
- إتاحة للعامة مع توضيح أنها نسخة تجريبية
- مراقبة الأداء
- تحسين based on analytics

### المرحلة 3: Production Release
- إطلاق رسمي على Google Play
- تفعيل كامل الـ features
- دعم فني كامل

---

## 📞 الدعم الفني

### للمطورين

إذا واجهت أي مشاكل:

1. **تحقق من Logs:**
   - App logs: `flutter run -v`
   - Backend logs: `tail -f ~/frappe-bench/logs/web.error.log`

2. **راجع Documentation:**
   - `INTEGRATION_STATUS.md` - حالة التكامل
   - `API_ENDPOINTS.md` - وثائق الـ API (سننشئه بعد قليل)

3. **اختبر الـ endpoints يدوياً:**
   - استخدم Postman أو curl
   - تأكد من صحة الـ response structure

---

## 📝 ملاحظات هامة

### 1. Data Migration

إذا كان لديك مستخدمون حاليون:

```python
# سكريبت نقل البيانات
import frappe

def migrate_old_users():
    old_users = frappe.get_all('Old User Table', fields=['*'])

    for user in old_users:
        # أنشئ patient جديد
        patient = frappe.get_doc({
            'doctype': 'Patient',
            'patient_name': user.name,
            'mobile': user.mobile,
            # ... باقي الحقول
        })
        patient.insert()

        # انقل الـ medications
        # انقل الـ orders
        # إلخ...

    frappe.db.commit()
```

### 2. Backup Strategy

```bash
# Backup يومي للـ database
0 2 * * * cd ~/frappe-bench && bench --site site1.local backup --with-files

# Backup للـ app files
0 3 * * * tar -czf ~/backups/dawaii-$(date +\%Y\%m\%d).tar.gz ~/Dawaii_Android/
```

### 3. Update Strategy

```dart
// في التطبيق - Force update check
class UpdateChecker {
  static Future<void> checkForUpdates() async {
    final response = await http.get('https://api.dawaii.com/version');
    final currentVersion = '1.0.0';
    final latestVersion = response.data['version'];

    if (needsUpdate(currentVersion, latestVersion)) {
      // اعرض dialog للتحديث
      showUpdateDialog();
    }
  }
}
```

---

## 🎯 الخطوات التالية

بعد إتمام الدمج الأساسي:

1. **تحسينات الأداء:**
   - إضافة caching layer
   - تحسين استهلاك البطارية
   - تقليل استخدام البيانات

2. **Features إضافية:**
   - Video consultations
   - Offline mode
   - Health tracking
   - Prescription scanning

3. **Analytics:**
   - تتبع user behavior
   - تحليل conversion rates
   - مراقبة crash reports

---

**تم إعداد هذا الدليل في:** 2026-01-10
**الإصدار:** 1.0
**حالة التكامل:** 100% جاهز للاختبار
