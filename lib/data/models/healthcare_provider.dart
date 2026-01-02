class HealthcareProvider {
  final String? name;
  final String providerName;
  final String specialty;
  final String? licenseNumber;
  final int? yearsOfExperience;
  final String? education;
  final String? email;
  final String? phone;
  final String? address;
  final String? city;
  final List<ProviderSchedule>? schedule;
  final String? bio;
  final String? languagesSpoken;
  final double? consultationFee;
  final String status; // Active, Inactive, On Leave

  HealthcareProvider({
    this.name,
    required this.providerName,
    required this.specialty,
    this.licenseNumber,
    this.yearsOfExperience,
    this.education,
    this.email,
    this.phone,
    this.address,
    this.city,
    this.schedule,
    this.bio,
    this.languagesSpoken,
    this.consultationFee,
    this.status = 'Active',
  });

  factory HealthcareProvider.fromJson(Map<String, dynamic> json) {
    return HealthcareProvider(
      name: json['name'],
      providerName: json['provider_name'],
      specialty: json['specialty'],
      licenseNumber: json['license_number'],
      yearsOfExperience: json['years_of_experience'],
      education: json['education'],
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
      city: json['city'],
      schedule: (json['schedule'] as List?)
          ?.map((s) => ProviderSchedule.fromJson(s))
          .toList(),
      bio: json['bio'],
      languagesSpoken: json['languages_spoken'],
      consultationFee: json['consultation_fee']?.toDouble(),
      status: json['status'] ?? 'Active',
    );
  }
}

class ProviderSchedule {
  final String day;
  final String fromTime;
  final String toTime;
  final bool isAvailable;

  ProviderSchedule({
    required this.day,
    required this.fromTime,
    required this.toTime,
    this.isAvailable = true,
  });

  factory ProviderSchedule.fromJson(Map<String, dynamic> json) {
    return ProviderSchedule(
      day: json['day'],
      fromTime: json['from_time'],
      toTime: json['to_time'],
      isAvailable: json['is_available'] == 1 || json['is_available'] == true,
    );
  }
}