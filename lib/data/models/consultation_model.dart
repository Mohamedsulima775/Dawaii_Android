class Consultation {
  final String? name;
  final String patient;
  final String? patientName;
  final String healthcareProvider;
  final String? providerName;
  final String consultationType; // Chat, Video Call, Voice Call, In-Person
  final String consultationDate;
  final String status; // Pending, Scheduled, In Progress, Completed, Cancelled
  final String? priority;
  final List<ConsultationMessage>? messages;
  final double? consultationFee;
  final String? paymentStatus;

  Consultation({
    this.name,
    required this.patient,
    this.patientName,
    required this.healthcareProvider,
    this.providerName,
    required this.consultationType,
    required this.consultationDate,
    required this.status,
    this.priority,
    this.messages,
    this.consultationFee,
    this.paymentStatus,
  });

  factory Consultation.fromJson(Map<String, dynamic> json) {
    return Consultation(
      name: json['name'],
      patient: json['patient'],
      patientName: json['patient_name'],
      healthcareProvider: json['healthcare_provider'],
      providerName: json['provider_name'],
      consultationType: json['consultation_type'],
      consultationDate: json['consultation_date'],
      status: json['status'] ?? 'Pending',
      priority: json['priority'],
      messages: (json['messages'] as List?)
          ?.map((m) => ConsultationMessage.fromJson(m))
          .toList(),
      consultationFee: json['consultation_fee']?.toDouble(),
      paymentStatus: json['payment_status'],
    );
  }
}

class ConsultationMessage {
  final String senderType; // Patient, Provider
  final String message;
  final String timestamp;
  final String? attachment;
  final bool isRead;

  ConsultationMessage({
    required this.senderType,
    required this.message,
    required this.timestamp,
    this.attachment,
    this.isRead = false,
  });

  factory ConsultationMessage.fromJson(Map<String, dynamic> json) {
    return ConsultationMessage(
      senderType: json['sender_type'],
      message: json['message'],
      timestamp: json['timestamp'],
      attachment: json['attachment'],
      isRead: json['is_read'] == 1 || json['is_read'] == true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sender_type': senderType,
      'message': message,
      'timestamp': timestamp,
      'attachment': attachment,
      'is_read': isRead ? 1 : 0,
    };
  }
}