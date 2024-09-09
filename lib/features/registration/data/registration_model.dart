
class RegistrationModel {
  String studentName;
  DateTime startDate;
  DateTime endDate;
  double fees;
  String serialNumber;
  String contactDetails;
  String aadharNumber;
  String address;

  RegistrationModel({
    required this.studentName,
    required this.startDate,
    required this.endDate,
    required this.fees,
    required this.serialNumber,
    required this.contactDetails,
    required this.aadharNumber,
    required this.address,
  });

  Map<String, dynamic> toJson() => {
    'studentName': studentName,
    'startDate': startDate.toIso8601String(),
    'endDate': endDate.toIso8601String(),
    'fees': fees,
    'serialNumber': serialNumber,
    'contactDetails': contactDetails,
    'aadharNumber': aadharNumber,
    'address': address,
  };

  factory RegistrationModel.fromJson(Map<String, dynamic> json) => RegistrationModel(
    studentName: json['studentName'],
    startDate: DateTime.parse(json['startDate']),
    endDate: DateTime.parse(json['endDate']),
    fees: json['fees'],
    serialNumber: json['serialNumber'],
    contactDetails: json['contactDetails'],
    aadharNumber: json['aadharNumber'],
    address: json['address'],
  );
}
