# API Testing Guide - اختبار الـ API Endpoints

دليل شامل لاختبار جميع الـ API endpoints المستخدمة في تطبيق Dawaii مع My_medicinal backend.

---

## 🛠️ أدوات الاختبار

### 1. cURL (Command Line)
```bash
# تثبيت curl (عادة مثبت مسبقاً)
sudo apt-get install curl  # Linux
brew install curl          # macOS
```

### 2. Postman
- حمّل من: https://www.postman.com/downloads/
- أو استخدم Postman Web

### 3. HTTPie (أكثر سهولة)
```bash
pip install httpie
```

---

## 🔐 Authentication Endpoints

### 1. Register (تسجيل مستخدم جديد)

**Endpoint:** `POST /api/method/my_medicinal.api.patient.register`

#### cURL Example:
```bash
curl -X POST https://YOUR_BACKEND_URL/api/method/my_medicinal.api.patient.register \
  -H "Content-Type: application/json" \
  -d '{
    "patient_name": "أحمد محمد",
    "mobile": "0501234567",
    "password": "SecurePass@123",
    "email": "ahmed@example.com",
    "date_of_birth": "1990-05-15",
    "gender": "ذكر"
  }'
```

#### HTTPie Example:
```bash
http POST https://YOUR_BACKEND_URL/api/method/my_medicinal.api.patient.register \
  patient_name="أحمد محمد" \
  mobile="0501234567" \
  password="SecurePass@123" \
  email="ahmed@example.com" \
  date_of_birth="1990-05-15" \
  gender="ذكر"
```

#### Expected Response:
```json
{
  "message": {
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
    "patient_id": "PAT-0001",
    "patient_name": "أحمد محمد",
    "refresh_token": "refresh_token_here"
  }
}
```

#### Postman Collection:
```json
{
  "name": "Register Patient",
  "request": {
    "method": "POST",
    "header": [
      {
        "key": "Content-Type",
        "value": "application/json"
      }
    ],
    "body": {
      "mode": "raw",
      "raw": "{\n  \"patient_name\": \"أحمد محمد\",\n  \"mobile\": \"0501234567\",\n  \"password\": \"SecurePass@123\",\n  \"email\": \"ahmed@example.com\",\n  \"date_of_birth\": \"1990-05-15\",\n  \"gender\": \"ذكر\"\n}"
    },
    "url": {
      "raw": "https://YOUR_BACKEND_URL/api/method/my_medicinal.api.patient.register",
      "protocol": "https",
      "host": ["YOUR_BACKEND_URL"],
      "path": ["api", "method", "my_medicinal.api.patient.register"]
    }
  }
}
```

---

### 2. Login (تسجيل الدخول)

**Endpoint:** `POST /api/method/my_medicinal.api.patient.login`

#### cURL Example:
```bash
curl -X POST https://YOUR_BACKEND_URL/api/method/my_medicinal.api.patient.login \
  -H "Content-Type: application/json" \
  -d '{
    "mobile": "0501234567",
    "password": "SecurePass@123"
  }'
```

#### Expected Response:
```json
{
  "message": {
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
    "patient_id": "PAT-0001",
    "patient_name": "أحمد محمد",
    "refresh_token": "refresh_token_here"
  }
}
```

#### Test Cases:

**✅ Success Case:**
```bash
# رقم جوال وكلمة مرور صحيحة
curl -X POST https://YOUR_BACKEND_URL/api/method/my_medicinal.api.patient.login \
  -H "Content-Type: application/json" \
  -d '{"mobile": "0501234567", "password": "SecurePass@123"}'
```

**❌ Failed Case - Wrong Password:**
```bash
curl -X POST https://YOUR_BACKEND_URL/api/method/my_medicinal.api.patient.login \
  -H "Content-Type: application/json" \
  -d '{"mobile": "0501234567", "password": "WrongPassword"}'
```

Expected Error:
```json
{
  "exc": "Invalid credentials",
  "_server_messages": "[\"بيانات الدخول غير صحيحة\"]"
}
```

**❌ Failed Case - User Not Found:**
```bash
curl -X POST https://YOUR_BACKEND_URL/api/method/my_medicinal.api.patient.login \
  -H "Content-Type: application/json" \
  -d '{"mobile": "0599999999", "password": "SecurePass@123"}'
```

---

### 3. Get Profile (الحصول على بيانات المستخدم)

**Endpoint:** `GET /api/method/my_medicinal.api.patient.get_profile`

#### cURL Example:
```bash
curl -X GET https://YOUR_BACKEND_URL/api/method/my_medicinal.api.patient.get_profile \
  -H "Authorization: Bearer YOUR_TOKEN_HERE"
```

#### Expected Response:
```json
{
  "message": {
    "patient_id": "PAT-0001",
    "patient_name": "أحمد محمد",
    "mobile": "0501234567",
    "email": "ahmed@example.com",
    "date_of_birth": "1990-05-15",
    "gender": "ذكر",
    "blood_group": "O+",
    "chronic_diseases": ["السكري", "ضغط الدم"],
    "allergies": "البنسلين"
  }
}
```

---

### 4. Update Profile (تحديث بيانات المستخدم)

**Endpoint:** `POST /api/method/my_medicinal.api.patient.update_profile`

#### cURL Example:
```bash
curl -X POST https://YOUR_BACKEND_URL/api/method/my_medicinal.api.patient.update_profile \
  -H "Authorization: Bearer YOUR_TOKEN_HERE" \
  -H "Content-Type: application/json" \
  -d '{
    "profile_data": {
      "blood_group": "A+",
      "chronic_diseases": ["السكري"],
      "allergies": "البنسلين",
      "emergency_contact_name": "فاطمة أحمد",
      "emergency_contact_mobile": "0507654321"
    }
  }'
```

---

## 💊 Medication Endpoints

### 1. Get My Medications (قائمة أدويتي)

**Endpoint:** `GET /api/method/my_medicinal.api.medication.get_my_medications`

#### cURL Example:
```bash
curl -X GET https://YOUR_BACKEND_URL/api/method/my_medicinal.api.medication.get_my_medications \
  -H "Authorization: Bearer YOUR_TOKEN_HERE"
```

#### Expected Response:
```json
{
  "message": [
    {
      "name": "MED-SCH-0001",
      "medication_name": "باراسيتامول",
      "dosage": "500mg",
      "frequency": "مرتين يومياً",
      "start_date": "2026-01-10",
      "end_date": "2026-02-10",
      "times": [
        {"time": "08:00"},
        {"time": "20:00"}
      ],
      "instructions": "يؤخذ بعد الأكل",
      "status": "نشط"
    },
    {
      "name": "MED-SCH-0002",
      "medication_name": "أموكسيسيلين",
      "dosage": "250mg",
      "frequency": "ثلاث مرات يومياً",
      "start_date": "2026-01-10",
      "end_date": "2026-01-17",
      "times": [
        {"time": "08:00"},
        {"time": "14:00"},
        {"time": "20:00"}
      ],
      "instructions": "يؤخذ قبل الأكل بساعة",
      "status": "نشط"
    }
  ]
}
```

---

### 2. Add Medication (إضافة دواء)

**Endpoint:** `POST /api/method/my_medicinal.api.medication.add_medication`

#### cURL Example:
```bash
curl -X POST https://YOUR_BACKEND_URL/api/method/my_medicinal.api.medication.add_medication \
  -H "Authorization: Bearer YOUR_TOKEN_HERE" \
  -H "Content-Type: application/json" \
  -d '{
    "medication_name": "ميتفورمين",
    "dosage": "850mg",
    "frequency": "مرتين يومياً",
    "start_date": "2026-01-10",
    "times": [
      {"time": "08:00"},
      {"time": "20:00"}
    ],
    "instructions": "يؤخذ مع الأكل"
  }'
```

---

### 3. Mark Medication Taken (تسجيل تناول الدواء)

**Endpoint:** `POST /api/method/my_medicinal.api.medication.mark_taken`

#### cURL Example:
```bash
curl -X POST https://YOUR_BACKEND_URL/api/method/my_medicinal.api.medication.mark_taken \
  -H "Authorization: Bearer YOUR_TOKEN_HERE" \
  -H "Content-Type: application/json" \
  -d '{
    "medication_schedule": "MED-SCH-0001",
    "taken_at": "2026-01-10 08:15:00",
    "notes": "تم التناول بعد الإفطار"
  }'
```

---

## 🏥 Consultation Endpoints

### 1. Get My Consultations (قائمة استشاراتي)

**Endpoint:** `GET /api/method/my_medicinal.api.consultation.get_my_consultations`

#### cURL Example:
```bash
curl -X GET "https://YOUR_BACKEND_URL/api/method/my_medicinal.api.consultation.get_my_consultations?status=قيد الانتظار" \
  -H "Authorization: Bearer YOUR_TOKEN_HERE"
```

#### Query Parameters:
- `status` (optional): "قيد الانتظار" | "مكتملة" | "ملغية"

#### Expected Response:
```json
{
  "message": [
    {
      "name": "CONS-0001",
      "healthcare_provider": "د. محمد أحمد",
      "specialty": "طب عام",
      "consultation_date": "2026-01-15",
      "consultation_time": "10:00",
      "status": "قيد الانتظار",
      "type": "حجز موعد",
      "notes": "متابعة السكري"
    }
  ]
}
```

---

### 2. Book Consultation (حجز استشارة)

**Endpoint:** `POST /api/method/my_medicinal.api.consultation.book_consultation`

#### cURL Example:
```bash
curl -X POST https://YOUR_BACKEND_URL/api/method/my_medicinal.api.consultation.book_consultation \
  -H "Authorization: Bearer YOUR_TOKEN_HERE" \
  -H "Content-Type: application/json" \
  -d '{
    "healthcare_provider": "PROV-0001",
    "consultation_date": "2026-01-20",
    "consultation_time": "14:00",
    "type": "حجز موعد",
    "notes": "استشارة عن الحساسية"
  }'
```

---

### 3. Cancel Consultation (إلغاء استشارة)

**Endpoint:** `POST /api/method/my_medicinal.api.consultation.cancel_consultation`

#### cURL Example:
```bash
curl -X POST https://YOUR_BACKEND_URL/api/method/my_medicinal.api.consultation.cancel_consultation \
  -H "Authorization: Bearer YOUR_TOKEN_HERE" \
  -H "Content-Type: application/json" \
  -d '{
    "consultation": "CONS-0001",
    "cancellation_reason": "تعارض في المواعيد"
  }'
```

---

## 🛒 Shop & Orders Endpoints

### 1. Get Products (قائمة المنتجات)

**Endpoint:** `GET /api/method/my_medicinal.api.shop.get_products`

#### cURL Example:
```bash
curl -X GET "https://YOUR_BACKEND_URL/api/method/my_medicinal.api.shop.get_products?category=أدوية&search=باراسيتامول" \
  -H "Authorization: Bearer YOUR_TOKEN_HERE"
```

#### Expected Response:
```json
{
  "message": [
    {
      "item_code": "ITEM-0001",
      "item_name": "باراسيتامول 500mg",
      "category": "مسكنات",
      "price": 15.50,
      "stock_quantity": 100,
      "image": "https://example.com/images/paracetamol.jpg",
      "description": "مسكن للألم وخافض للحرارة",
      "requires_prescription": false
    }
  ]
}
```

---

### 2. Create Order (إنشاء طلب)

**Endpoint:** `POST /api/method/my_medicinal.api.order.create_order`

#### cURL Example:
```bash
curl -X POST https://YOUR_BACKEND_URL/api/method/my_medicinal.api.order.create_order \
  -H "Authorization: Bearer YOUR_TOKEN_HERE" \
  -H "Content-Type: application/json" \
  -d '{
    "items": [
      {
        "item_code": "ITEM-0001",
        "quantity": 2,
        "price": 15.50
      },
      {
        "item_code": "ITEM-0002",
        "quantity": 1,
        "price": 25.00
      }
    ],
    "delivery_address": {
      "address_line": "شارع الملك فهد، حي النزهة",
      "city": "الرياض",
      "postal_code": "12345"
    },
    "payment_method": "نقداً عند الاستلام"
  }'
```

#### Expected Response:
```json
{
  "message": {
    "order_id": "ORD-0001",
    "total_amount": 56.00,
    "status": "قيد المعالجة",
    "estimated_delivery": "2026-01-12"
  }
}
```

---

### 3. Get My Orders (طلباتي)

**Endpoint:** `GET /api/method/my_medicinal.api.order.get_my_orders`

#### cURL Example:
```bash
curl -X GET "https://YOUR_BACKEND_URL/api/method/my_medicinal.api.order.get_my_orders?status=قيد التوصيل" \
  -H "Authorization: Bearer YOUR_TOKEN_HERE"
```

---

### 4. Get Order Detail (تفاصيل الطلب)

**Endpoint:** `GET /api/method/my_medicinal.api.order.get_order_detail`

#### cURL Example:
```bash
curl -X GET "https://YOUR_BACKEND_URL/api/method/my_medicinal.api.order.get_order_detail?order_id=ORD-0001" \
  -H "Authorization: Bearer YOUR_TOKEN_HERE"
```

---

### 5. Cancel Order (إلغاء طلب)

**Endpoint:** `POST /api/method/my_medicinal.api.order.cancel_order`

#### cURL Example:
```bash
curl -X POST https://YOUR_BACKEND_URL/api/method/my_medicinal.api.order.cancel_order \
  -H "Authorization: Bearer YOUR_TOKEN_HERE" \
  -H "Content-Type: application/json" \
  -d '{
    "order_id": "ORD-0001",
    "cancellation_reason": "طلبت بالخطأ"
  }'
```

---

### 6. Confirm Delivery (تأكيد الاستلام)

**Endpoint:** `POST /api/method/my_medicinal.api.order.confirm_delivery`

#### cURL Example:
```bash
curl -X POST https://YOUR_BACKEND_URL/api/method/my_medicinal.api.order.confirm_delivery \
  -H "Authorization: Bearer YOUR_TOKEN_HERE" \
  -H "Content-Type: application/json" \
  -d '{
    "order_id": "ORD-0001"
  }'
```

---

### 7. Rate Order (تقييم الطلب)

**Endpoint:** `POST /api/method/my_medicinal.api.order.rate_order`

#### cURL Example:
```bash
curl -X POST https://YOUR_BACKEND_URL/api/method/my_medicinal.api.order.rate_order \
  -H "Authorization: Bearer YOUR_TOKEN_HERE" \
  -H "Content-Type: application/json" \
  -d '{
    "order_id": "ORD-0001",
    "rating": 5,
    "review": "خدمة ممتازة وتوصيل سريع"
  }'
```

---

## 📋 Prescription Endpoints

### 1. Get My Prescriptions (وصفاتي الطبية)

**Endpoint:** `GET /api/method/my_medicinal.api.prescription.get_my_prescriptions`

#### cURL Example:
```bash
curl -X GET https://YOUR_BACKEND_URL/api/method/my_medicinal.api.prescription.get_my_prescriptions \
  -H "Authorization: Bearer YOUR_TOKEN_HERE"
```

#### Expected Response:
```json
{
  "message": [
    {
      "name": "PRESC-0001",
      "healthcare_provider": "د. محمد أحمد",
      "prescription_date": "2026-01-10",
      "medications": [
        {
          "medication_name": "باراسيتامول",
          "dosage": "500mg",
          "frequency": "مرتين يومياً",
          "duration": "7 أيام"
        }
      ],
      "diagnosis": "نزلة برد",
      "notes": "راحة تامة وشرب السوائل"
    }
  ]
}
```

---

## 👨‍⚕️ Healthcare Provider Endpoints

### 1. Get Providers (قائمة مقدمي الخدمة)

**Endpoint:** `GET /api/method/my_medicinal.api.provider.get_providers`

#### cURL Example:
```bash
curl -X GET "https://YOUR_BACKEND_URL/api/method/my_medicinal.api.provider.get_providers?specialty=طب عام" \
  -H "Authorization: Bearer YOUR_TOKEN_HERE"
```

#### Expected Response:
```json
{
  "message": [
    {
      "provider_id": "PROV-0001",
      "provider_name": "د. محمد أحمد",
      "specialty": "طب عام",
      "qualifications": "بكالوريوس طب وجراحة",
      "experience_years": 10,
      "rating": 4.8,
      "consultation_fee": 200,
      "available_times": ["09:00", "10:00", "14:00", "15:00"]
    }
  ]
}
```

---

## 🔔 Notification Endpoints

### 1. Register Device (تسجيل جهاز للإشعارات)

**Endpoint:** `POST /api/method/my_medicinal.api.notification.register_device`

#### cURL Example:
```bash
curl -X POST https://YOUR_BACKEND_URL/api/method/my_medicinal.api.notification.register_device \
  -H "Authorization: Bearer YOUR_TOKEN_HERE" \
  -H "Content-Type: application/json" \
  -d '{
    "fcm_token": "dUzY8xR3QvG...FCM_TOKEN_HERE",
    "platform": "android",
    "device_info": {
      "os": "linux",
      "version": "Android 13"
    }
  }'
```

---

### 2. Get Notifications (قائمة الإشعارات)

**Endpoint:** `GET /api/method/my_medicinal.api.notification.get_notifications`

#### cURL Example:
```bash
curl -X GET https://YOUR_BACKEND_URL/api/method/my_medicinal.api.notification.get_notifications \
  -H "Authorization: Bearer YOUR_TOKEN_HERE"
```

---

## 🧪 Testing Scenarios

### Scenario 1: Complete User Journey

```bash
#!/bin/bash

BASE_URL="https://YOUR_BACKEND_URL"

# 1. Register
echo "1. Registering new user..."
REGISTER_RESPONSE=$(curl -s -X POST "$BASE_URL/api/method/my_medicinal.api.patient.register" \
  -H "Content-Type: application/json" \
  -d '{
    "patient_name": "اختبار المستخدم",
    "mobile": "0501111111",
    "password": "Test@123456",
    "email": "test@example.com",
    "date_of_birth": "1995-01-01",
    "gender": "ذكر"
  }')

TOKEN=$(echo $REGISTER_RESPONSE | jq -r '.message.token')
echo "Token: $TOKEN"

# 2. Get Profile
echo "2. Getting profile..."
curl -s -X GET "$BASE_URL/api/method/my_medicinal.api.patient.get_profile" \
  -H "Authorization: Bearer $TOKEN"

# 3. Get Medications
echo "3. Getting medications..."
curl -s -X GET "$BASE_URL/api/method/my_medicinal.api.medication.get_my_medications" \
  -H "Authorization: Bearer $TOKEN"

# 4. Get Products
echo "4. Getting products..."
curl -s -X GET "$BASE_URL/api/method/my_medicinal.api.shop.get_products" \
  -H "Authorization: Bearer $TOKEN"

# 5. Get Consultations
echo "5. Getting consultations..."
curl -s -X GET "$BASE_URL/api/method/my_medicinal.api.consultation.get_my_consultations" \
  -H "Authorization: Bearer $TOKEN"
```

---

### Scenario 2: Error Handling Test

```bash
#!/bin/bash

BASE_URL="https://YOUR_BACKEND_URL"

# Test 1: Invalid credentials
echo "Test 1: Invalid credentials"
curl -X POST "$BASE_URL/api/method/my_medicinal.api.patient.login" \
  -H "Content-Type: application/json" \
  -d '{"mobile": "0501234567", "password": "WrongPassword"}'

# Test 2: Missing required fields
echo "Test 2: Missing fields"
curl -X POST "$BASE_URL/api/method/my_medicinal.api.patient.register" \
  -H "Content-Type: application/json" \
  -d '{"patient_name": "اختبار"}'

# Test 3: Unauthorized access
echo "Test 3: No token"
curl -X GET "$BASE_URL/api/method/my_medicinal.api.patient.get_profile"

# Test 4: Invalid token
echo "Test 4: Invalid token"
curl -X GET "$BASE_URL/api/method/my_medicinal.api.patient.get_profile" \
  -H "Authorization: Bearer INVALID_TOKEN"
```

---

## 📊 Performance Testing

### Using Apache Bench (ab)

```bash
# Test login endpoint - 100 requests, 10 concurrent
ab -n 100 -c 10 -p login.json -T application/json \
  https://YOUR_BACKEND_URL/api/method/my_medicinal.api.patient.login

# login.json content:
# {"mobile": "0501234567", "password": "SecurePass@123"}
```

### Using wrk

```bash
# Install wrk
git clone https://github.com/wg/wrk.git
cd wrk && make

# Run test
wrk -t4 -c100 -d30s \
  -H "Authorization: Bearer YOUR_TOKEN" \
  https://YOUR_BACKEND_URL/api/method/my_medicinal.api.medication.get_my_medications
```

---

## 📝 Notes

### Common Response Codes

- `200 OK` - نجحت العملية
- `400 Bad Request` - بيانات غير صحيحة
- `401 Unauthorized` - غير مصرح (token غير صالح)
- `403 Forbidden` - ممنوع الوصول
- `404 Not Found` - المورد غير موجود
- `422 Unprocessable Entity` - خطأ في التحقق من البيانات
- `500 Internal Server Error` - خطأ في السيرفر

### Authorization Header Format

```
Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
```

### Content-Type

جميع الطلبات POST/PUT تتطلب:
```
Content-Type: application/json
```

---

**تم إعداد هذا الدليل في:** 2026-01-10
**الإصدار:** 1.0
