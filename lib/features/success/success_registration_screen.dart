import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart'; // For printing the PDF
import 'dart:io'; // For File operations
import 'dart:convert'; // For JSON encoding/decoding
import '../../res/colors/app_color.dart';
import '../../res/fonts/text_style.dart';
import '../../res/routes/app_routes.dart';
import '../../utils/logger.dart';
import '../../res/app_url/app_url.dart';

import '../payment/data/payment_slip_pdf_service.dart';
import '../records/student_record/data/student_record_model.dart';
import 'pdf/pdf_service_registration.dart';

class SuccessRegistrationScreen extends StatefulWidget {
  final String? studentId;

  const SuccessRegistrationScreen({super.key, this.studentId});

  @override
  _SuccessRegistrationScreenState createState() => _SuccessRegistrationScreenState();
}


class _SuccessRegistrationScreenState extends State<SuccessRegistrationScreen> {
  StudentRecord? _studentRecord;

  @override
  void initState() {
    super.initState();
    //_fetchStudentDetails(int.parse(widget.studentId));
    // Provide a default value if studentId is null
    final studentId = widget.studentId ?? '';
    _fetchStudentDetails(int.parse(studentId));
  }

  void _fetchStudentDetails(int studentId) async {
    try {
      final url = '${AppUrl.recordApi}';
      final requestBody = {'user_id': studentId.toString()};

      final response = await http.post(
        Uri.parse(url),
        body: requestBody,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['status'] == 'success') {
          List<dynamic> data = responseData['data'];
          if (data.isNotEmpty) {
            final filteredData = data.where((json) => json['student_id'] == studentId.toString()).toList();
            if (filteredData.isNotEmpty) {
              StudentRecord studentRecord = StudentRecord.fromJson(filteredData[0]);
              logDebug('Filtered Student Name: ${studentRecord.name}');
              logDebug('Filtered Student ID: ${studentRecord.studentId}');
              logDebug('Filtered Student Fee: ${studentRecord.fee}');
              logDebug('Filtered Student Start Date: ${studentRecord.startDate}');
              logDebug('Filtered Student End Date: ${studentRecord.endDate}');
              logDebug('Filtered Student Serial No: ${studentRecord.serialNo}');
              logDebug('Filtered Student Contact: ${studentRecord.contact}');
              logDebug('Filtered Student Aadhar No: ${studentRecord.aadharNo}');
              logDebug('Filtered Student Address: ${studentRecord.address}');

              setState(() {
                _studentRecord = studentRecord;
              });
            } else {
              logDebug('No record found for student ID: $studentId');
            }
          } else {
            logDebug('No data found for student ID: $studentId');
          }
        } else {
          logDebug('Error in fetchStudentDetails: ${responseData['message']}');
        }
      } else {
        logDebug('Failed to fetch student details. Status code: ${response.statusCode}');
      }
    } catch (e) {
      logDebug('Exception occurred while fetching student details: $e');
    }
  }

  Future<void> _printPdf() async {
    if (_studentRecord == null) {
      logDebug('No student record available to generate PDF.'); // Log if no record is available
      return;
    }

    logDebug('Starting PDF generation for student: ${_studentRecord!.name}'); // Log start of PDF generation

    try {
      final pdfService = PdfService();
      final pdfBytes = await pdfService.generatePdf(
        studentName: _studentRecord!.name,
        serialNo: _studentRecord!.serialNo,
        contact: _studentRecord!.contact,
        aadharNo: _studentRecord!.aadharNo,
        address: _studentRecord!.address,
        startDate: _studentRecord!.startDate,
        endDate: _studentRecord!.endDate,
        fee: _studentRecord!.fee,
      );

      logDebug('PDF generated successfully for student: ${_studentRecord!.name}'); // Log successful PDF generation

      await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async {
          logDebug('Preparing to print PDF for student: ${_studentRecord!.name}'); // Log before printing
          return pdfBytes;
        },
      );

      logDebug('Print job sent successfully for student: ${_studentRecord!.name}'); // Log successful print job
    } catch (e) {
      logDebug('Error occurred during PDF generation or printing: $e'); // Log any errors
    }
  }

  Future<void> _generatePaymentSlipPdf() async {
    if (_studentRecord == null) {
      logDebug('No student record available to generate payment slip PDF.'); // Log if no record is available
      return;
    }

    logDebug('Starting Payment Slip PDF generation for student: ${_studentRecord!.name}'); // Log start of PDF generation

    try {
      final paymentSlipPdfService = PaymentSlipPdfService(); // Correct service
      final pdfBytes = await paymentSlipPdfService.generatePaymentSlipPdf(
        studentName: _studentRecord!.name,
        startDate: _studentRecord!.startDate,
        endDate: _studentRecord!.endDate,
        fee: _studentRecord!.fee,
      );

      logDebug('Payment Slip PDF generated successfully for student: ${_studentRecord!.name}'); // Log successful PDF generation

      await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async {
          logDebug('Preparing to print Payment Slip PDF for student: ${_studentRecord!.name}'); // Log before printing
          return pdfBytes;
        },
      );

      logDebug('Print job sent successfully for student: ${_studentRecord!.name}'); // Log successful print job
    } catch (e) {
      logDebug('Error occurred during Payment Slip PDF generation or printing: $e'); // Log any errors
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                "assets/icons/success-icon.png",
                height: 84.h,
                width: 84.w,
              ),
              SizedBox(height: 20.h),
              Text(
                'Student Details Submitted\nSuccessfully',
                style: LexendtextFont500.copyWith(
                  fontSize: 20.sp,
                  color: AppColor.textcolorBlack,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.h),

              // if (_studentRecord != null)
              //   Text(
              //     'Student ID: ${_studentRecord!.studentId}',
              //     style: LexendtextFont500.copyWith(
              //       fontSize: 18.sp,
              //       color: AppColor.textcolorBlack,
              //     ),
              //     textAlign: TextAlign.center,
              //   )
              // else
              //   Text(
              //     'Loading...',
              //     style: LexendtextFont500.copyWith(
              //       fontSize: 18.sp,
              //       color: AppColor.textcolorBlack,
              //     ),
              //     textAlign: TextAlign.center,
              //   ),

              SizedBox(height: 20.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: _printPdf,
                    child: Container(
                      width: 160.w,
                      height: 60.h,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        color: AppColor.textcolorBlack,
                      ),
                      child: Center(
                        child: Text(
                          'Print Form',
                          style: LexendtextFont700.copyWith(
                            fontSize: 16.sp,
                            color: AppColor.whiteColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: _generatePaymentSlipPdf,
                    child: Container(
                      width: 160.w,
                      height: 60.h,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        color: AppColor.textcolor_gold,
                      ),
                      child: Center(
                        child: Text(
                          'Payment Slip',
                          style: LexendtextFont700.copyWith(
                            fontSize: 16.sp,
                            color: AppColor.whiteColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),

              InkWell(
                onTap: () {
                  // Navigator.popUntil(context, ModalRoute.withName(AppRoutes.home));

                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: Container(
                  width: double.infinity,
                  height: 60.h,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: AppColor.btncolor,
                  ),
                  child: Center(
                    child: Text(
                      'Go To Dashboard',
                      style: LexendtextFont700.copyWith(
                        fontSize: 16.sp,
                        color: AppColor.whiteColor,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
