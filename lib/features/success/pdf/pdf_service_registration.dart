import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:intl/intl.dart'; // Add this for date formatting

class PdfService {
  Future<Uint8List> generatePdf({
    required String studentName,
    required String serialNo,
    required String contact,
    required String aadharNo,
    required String address,
    required String startDate,
    required String endDate,
    required String fee,
  }) async {
    final pdf = pw.Document();

    // Load the Poppins font and logo image
    final fontData = await rootBundle.load('assets/fonts/Poppins/Poppins-Regular.ttf');
    final font = pw.Font.ttf(fontData);
    final logoData = await rootBundle.load('assets/images/login-img.png');
    final logoImage = pw.MemoryImage(logoData.buffer.asUint8List());

    // Get current date formatted
    final now = DateTime.now();
    final formattedDate = DateFormat('yyyy-MM-dd').format(now);

    // Define a custom light grey color
    final lightGreyColor = PdfColor.fromInt(0xFFB0B0B0); // Light grey color

    // Add form page
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Center(
                child: pw.Column(
                  mainAxisSize: pw.MainAxisSize.min,
                  children: [
                    pw.Image(logoImage, height: 100),

                    pw.Text(
                      'Student Registration Form',
                      style: pw.TextStyle(fontSize: 30, font: font, fontWeight: pw.FontWeight.bold),
                    ),
                    pw.SizedBox(height: 40),
                    _buildDetailsTable(
                      studentName: studentName,
                      serialNo: serialNo,
                      contact: contact,
                      aadharNo: aadharNo,
                      address: address,
                      startDate: startDate,
                      endDate: endDate,
                      fee: fee,
                      font: font,
                    ),
                    pw.SizedBox(height: 200),
                    // Footer with signature and created date
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text(
                          'Created At: $formattedDate',
                          style: pw.TextStyle(
                            fontSize: 18,
                            font: font,
                            color: lightGreyColor, // Custom lighter color
                          ),
                        ),
                        pw.Text(
                          'Student Signature',
                          style: pw.TextStyle(
                            fontSize: 18,
                            font: font,
                          // color: lightGreyColor, // Custom lighter color
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
              ),
            ],
          );
        },
      ),
    );

    return pdf.save();
  }

  // Utility method to build details table
  pw.Widget _buildDetailsTable({
    required String studentName,
    required String serialNo,
    required String contact,
    required String aadharNo,
    required String address,
    required String startDate,
    required String endDate,
    required String fee,
    required pw.Font font,
  }) {
    return pw.Table(
      border: pw.TableBorder.all(width: 1, color: PdfColors.black),
      columnWidths: {
        0: pw.FractionColumnWidth(0.4),
        1: pw.FractionColumnWidth(0.6),
      },
      children: [
        _buildTableRow('Student Name', studentName, font),
        _buildTableRow('Serial Number', serialNo, font),
        _buildTableRow('Contact Details', contact, font),
        _buildTableRow('Aadhar Number', aadharNo, font),
        _buildTableRow('Address', address, font),
        _buildTableRow('Start Date', startDate, font),
        _buildTableRow('End Date', endDate, font),
        _buildTableRow('Fees', fee, font),
      ],
    );
  }

  // Utility method to build a table row
  pw.TableRow _buildTableRow(String title, String value, pw.Font font) {
    return pw.TableRow(
      children: [
        pw.Padding(
          padding: pw.EdgeInsets.all(8),
          child: pw.Text(title, style: pw.TextStyle(font: font, fontWeight: pw.FontWeight.bold)),
        ),
        pw.Padding(
          padding: pw.EdgeInsets.all(8),
          child: pw.Text(value, style: pw.TextStyle(font: font)),
        ),
      ],
    );
  }
}
