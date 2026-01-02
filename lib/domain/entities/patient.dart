

// domain/entities/patient.dart

class Patient {
  final String id;
  final String name;
  final String mobile;
  final String? email;
  final String? dateOfBirth;
  final String? gender;
  final String? bloodGroup;
  final String? nationalId;
  final String? address;
  final String? city;
  final String? emergencyContactName;
  final String? emergencyContactMobile;
  final List<String>? chronicDiseases;
  final String? allergies;
  final String? medicalNotes;
  final String? profileImage;
  final String status;
  final DateTime? lastLogin;

  const Patient({
    required this.id,
    required this.name,
    required this.mobile,
    this.email,
    this.dateOfBirth,
    this.gender,
    this.bloodGroup,
    this.nationalId,
    this.address,
    this.city,
    this.emergencyContactName,
    this.emergencyContactMobile,
    this.chronicDiseases,
    this.allergies,
    this.medicalNotes,
    this.profileImage,
    this.status = 'نشط',
    this.lastLogin,
  });

  // Create empty patient
  factory Patient.empty() {
    return const Patient(
      id: '',
      name: '',
      mobile: '',
      status: 'نشط',
    );
  }

  // Copy with method for immutability
  Patient copyWith({
    String? id,
    String? name,
    String? mobile,
    String? email,
    String? dateOfBirth,
    String? gender,
    String? bloodGroup,
    String? nationalId,
    String? address,
    String? city,
    String? emergencyContactName,
    String? emergencyContactMobile,
    List<String>? chronicDiseases,
    String? allergies,
    String? medicalNotes,
    String? profileImage,
    String? status,
    DateTime? lastLogin,
  }) {
    return Patient(
      id: id ?? this.id,
      name: name ?? this.name,
      mobile: mobile ?? this.mobile,
      email: email ?? this.email,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      bloodGroup: bloodGroup ?? this.bloodGroup,
      nationalId: nationalId ?? this.nationalId,
      address: address ?? this.address,
      city: city ?? this.city,
      emergencyContactName: emergencyContactName ?? this.emergencyContactName,
      emergencyContactMobile: emergencyContactMobile ?? this.emergencyContactMobile,
      chronicDiseases: chronicDiseases ?? this.chronicDiseases,
      allergies: allergies ?? this.allergies,
      medicalNotes: medicalNotes ?? this.medicalNotes,
      profileImage: profileImage ?? this.profileImage,
      status: status ?? this.status,
      lastLogin: lastLogin ?? this.lastLogin,
    );
  }

  // Get age from date of birth
  int? get age {
    if (dateOfBirth == null) return null;

    try {
      final dob = DateTime.parse(dateOfBirth!);
      final now = DateTime.now();
      int age = now.year - dob.year;

      if (now.month < dob.month ||
          (now.month == dob.month && now.day < dob.day)) {
        age--;
      }

      return age;
    } catch (e) {
      return null;
    }
  }

  // Check if patient is active
  bool get isActive => status == 'نشط';

  // Get display name with age
  String get displayName {
    if (age != null) {
      return '$name ($age سنة)';
    }
    return name;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Patient && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Patient(id: $id, name: $name, mobile: $mobile, status: $status)';
  }
}