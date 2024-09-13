class StudentDetailsResponse {
  final String status;
  final String message;
  final StudentData data;

  StudentDetailsResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory StudentDetailsResponse.fromJson(Map<String, dynamic> json) {
    return StudentDetailsResponse(
      status: json['status'],
      message: json['message'],
      data: StudentData.fromJson(json['data']),
    );
  }
}

class StudentData {
  final String id;
  final String userId;
  final String name;
  final String serialNo;
  final String contact;
  final String aadharNo;
  final String address;

  StudentData({
    required this.id,
    required this.userId,
    required this.name,
    required this.serialNo,
    required this.contact,
    required this.aadharNo,
    required this.address,
  });

  factory StudentData.fromJson(Map<String, dynamic> json) {
    return StudentData(
      id: json['id'],
      userId: json['user_id'],
      name: json['name'],
      serialNo: json['serial_no'],
      contact: json['contact'],
      aadharNo: json['aadhar_no'],
      address: json['address'],
    );
  }
}
