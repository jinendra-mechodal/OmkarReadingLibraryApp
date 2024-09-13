class PrintStudentRecordsDetails {
  final String? startDate;
  final String? endDate;
  final String? fee;
  final String? createdAt;

  PrintStudentRecordsDetails({
    this.startDate,
    this.endDate,
    this.fee,
    this.createdAt,
  });

  factory PrintStudentRecordsDetails.fromJson(Map<String, dynamic> json) {
    return PrintStudentRecordsDetails(
      startDate: json['start_date'] as String?,
      endDate: json['end_date'] as String?,
      fee: json['fee'] as String?,
      createdAt: json['created_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'start_date': startDate,
      'end_date': endDate,
      'fee': fee,
      'created_at': createdAt,
    };
  }
}
