import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../res/colors/app_color.dart';
import '../../../../res/fonts/text_style.dart';
import '../../../../res/routes/app_routes.dart';
import '../../../registration/presentation/widgets/registration_form.dart';


class CustomSubscriptionDialog extends StatelessWidget {
  final TextEditingController startDateController;
  final TextEditingController endDateController;
  final TextEditingController feesController;

  final FocusNode startDateFocusNode = FocusNode();
  final FocusNode endDateFocusNode = FocusNode();
  final FocusNode feesFocusNode = FocusNode();

  CustomSubscriptionDialog({
    required this.startDateController,
    required this.endDateController,
    required this.feesController,
  });

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return Dialog(
          backgroundColor: AppColor.whiteColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'New Subscription',
                  style: montserratfont600.copyWith(
                    fontSize: 15.sp,
                    color: AppColor.textcolor_blue,
                  ),
                ),
                SizedBox(height: 25.h),
                // Row for date fields
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => _selectDate(context, startDateController),
                        child: AbsorbPointer(
                          child: RegistrationTextFormField(
                            controller: startDateController,
                            hintText: 'Start Date',
                            focusNode: startDateFocusNode, // Provide the focus node
                            keyboardType: TextInputType.datetime,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter the start date';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => _selectDate(context, endDateController),
                        child: AbsorbPointer(
                          child: RegistrationTextFormField(
                            controller: endDateController,
                            hintText: 'End Date',
                            focusNode: endDateFocusNode, // Provide the focus node
                            keyboardType: TextInputType.datetime,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter the end date';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                // Numeric input field
                RegistrationTextFormField(
                  controller: feesController,
                  hintText: 'Fees',
                  focusNode: feesFocusNode, // Provide the focus node
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the fees';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.h),
                // Submit button
                Align(
                  alignment: Alignment.bottomRight,
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle submission logic here
                        //Navigator.of(context).pop(); // Close the dialog
                        Navigator.pushNamed(context, AppRoutes.studentDetailsSuccess);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.btncolor, // Button background color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 14.h), // Adjust vertical padding
                      ),
                      child: Text(
                        'Submit',
                        style: LexendtextFont700.copyWith(
                          color: AppColor.whiteColor,
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
    final DateTime? selectedDate = await showDatePicker(

      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColor.whiteColor,
              onPrimary: Colors.white,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                backgroundColor: AppColor.btncolor, // Add your custom background color
                // foregroundColor: AppColor.btncolor, // Text color
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0), // Padding
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0), // Border radius
                ),
              ),
            ),
            buttonTheme: ButtonThemeData(
              buttonColor: AppColor.btncolor, // Add button color here if needed
            ),
          ),
          child: child!,
        );
      },
    );

    if (selectedDate != null) {
      // Format the date as YYYY-MM-DD
      final DateFormat formatter = DateFormat('yyyy-MM-dd');
      final String formattedDate = formatter.format(selectedDate);

      // Set the formatted date to the controller
      controller.text = formattedDate;

      // Show a Snackbar with the selected date for feedback
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Selected date: $formattedDate'),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      // Optionally handle the case when no date is selected
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('No date selected'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  // Future<void> _selectEndDate(BuildContext context) async {
  //   final DateTime? picked = await showDatePicker(
  //     context: context,
  //    // initialDate: EndDate,
  //     firstDate: DateTime.now(),
  //     lastDate: DateTime(2101),
  //     builder: (BuildContext context, Widget? child) {
  //       return Theme(
  //         data: ThemeData.light().copyWith(
  //           colorScheme: ColorScheme.light(
  //             primary: AppColor.btncolor,
  //             onPrimary: Colors.white,
  //           ),
  //           textButtonTheme: TextButtonThemeData(
  //             style: TextButton.styleFrom(
  //               backgroundColor: Colors.blue, // Add your custom background color
  //               foregroundColor: AppColor.btncolor, // Text color
  //               padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0), // Padding
  //               shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(8.0), // Border radius
  //               ),
  //             ),
  //           ),
  //           buttonTheme: ButtonThemeData(
  //             buttonColor: Colors.blue, // Add button color here if needed
  //           ),
  //         ),
  //         child: child!,
  //       );
  //     },
  //   );
  //
  //   // if (picked != null && picked != EndDate) {
  //   //   setState(() {
  //   //     EndDate = picked;
  //   //     isEndDate = true;
  //   //     if (StartDate.day == EndDate.day) {
  //   //       EndSessionsList.remove('Session 1');
  //   //     }
  //   //     calculateNumberOfDays();
  //   //   });
  //   // }
  // }
}
