import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:library_app/features/registration/presentation/widgets/submit_button.dart';
import 'package:library_app/res/colors/app_color.dart';
import 'package:library_app/res/fonts/text_style.dart';
import 'package:provider/provider.dart';
import '../../../../res/routes/app_routes.dart';
import '../viewmodels/registration_view_model.dart';
import '../widgets/registration_form.dart'; // Adjust the import path as needed

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _studentNameController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _feesController = TextEditingController();
  final TextEditingController _serialNumberController = TextEditingController();
  final TextEditingController _contactDetailsController =
      TextEditingController();
  final TextEditingController _aadharNumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  final FocusNode _studentNameFocusNode = FocusNode();
  final FocusNode _startDateFocusNode = FocusNode();
  final FocusNode _endDateFocusNode = FocusNode();
  final FocusNode _feesFocusNode = FocusNode();
  final FocusNode _serialNumberFocusNode = FocusNode();
  final FocusNode _contactDetailsFocusNode = FocusNode();
  final FocusNode _aadharNumberFocusNode = FocusNode();
  final FocusNode _addressFocusNode = FocusNode();


  Future<void> _selectDate(TextEditingController controller) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColor.btncolor,
              onPrimary: AppColor.whiteColor,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColor.whiteColor,
                backgroundColor: AppColor.btncolor,
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (selectedDate != null) {
      setState(() {
        // Format date as YYYY-MM-DD
        controller.text = "${selectedDate.toLocal()}".split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: BoxDecoration(
            color: AppColor.whiteColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black12.withOpacity(0.02), // Shadow color
                spreadRadius: 1, // Spread radius
                blurRadius: 4, // Blur radius
                offset: Offset(0, 4), // Shadow offset (bottom side)
              ),
            ],
          ),
          child: AppBar(
            backgroundColor: AppColor.whiteColor,
            title: Text(
              'Student Registration',
              style: LexendtextFont500.copyWith(
                fontSize: 16.sp,
                color: AppColor.textcolorBlack,
              ),
            ),
            actions: [
              InkWell(
                onTap: () {
                //  Navigator.pushNamed(context, AppRoutes.home);
                  Navigator.pop(context);
                },
                child: Row(
                  children: [
                    Text(
                      "Go Back",
                      style: LexendtextFont500.copyWith(
                        fontSize: 14.sp,
                        color: AppColor.btncolor,
                      ),
                    ),
                    SizedBox(width: 5.w),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: AppColor.btncolor,
                      size: 17.sp,
                    ),
                    SizedBox(width: 10.w),
                  ],
                ),
              ),
            ],
            automaticallyImplyLeading: false,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              RegistrationTextFormField(
                controller: _studentNameController,
                hintText: 'Student Name',
                focusNode: _studentNameFocusNode,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the student name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.h),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _selectDate(_startDateController),
                      child: AbsorbPointer(
                        child: RegistrationTextFormField(
                          controller: _startDateController,
                          hintText: 'Start Date',
                          focusNode: _startDateFocusNode,
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
                  SizedBox(width: 16.w),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _selectDate(_endDateController),
                      child: AbsorbPointer(
                        child: RegistrationTextFormField(
                          controller: _endDateController,
                          hintText: 'End Date',
                          focusNode: _endDateFocusNode,
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
              SizedBox(height: 16.h),
              RegistrationTextFormField(
                controller: _feesController,
                hintText: 'Fees',
                focusNode: _feesFocusNode,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the fees';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.h),
              RegistrationTextFormField(
                controller: _serialNumberController,
                hintText: 'Serial Number',
                focusNode: _serialNumberFocusNode,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the serial number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.h),
              RegistrationTextFormField(
                controller: _contactDetailsController,
                hintText: 'Contact Details',
                focusNode: _contactDetailsFocusNode,
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter contact details';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.h),
              RegistrationTextFormField(
                controller: _aadharNumberController,
                hintText: 'Aadhar Number',
                focusNode: _aadharNumberFocusNode,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the Aadhar number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.h),
              RegistrationTextFormField(
                controller: _addressController,
                hintText: 'Address',
                focusNode: _addressFocusNode,
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the address';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.h),
              // SubmitButton(onPressed: () async {
              //   // Validate form and process data here
              //   if (_formKey.currentState?.validate() ?? false) {
              //
              //     // Get the ViewModel from Provider
              //     final registrationViewModel = Provider.of<RegistrationViewModel>(context, listen: false);
              //
              //     await registrationViewModel.registerStudent(
              //       name: _studentNameController.text,
              //       serialNo: _serialNumberController.text,
              //       contact: _contactDetailsController.text,
              //       aadharNo: _aadharNumberController.text,
              //       address: _addressController.text,
              //       startDate: _startDateController.text,
              //       endDate: _endDateController.text,
              //       fee: _feesController.text,
              //
              //     );
              //
              //     print('Form validation successful');
              //     print('Student Name: ${_studentNameController.text}');
              //     print('Start Date: ${_startDateController.text}');
              //     print('End Date: ${_endDateController.text}');
              //     print('Fees: ${_feesController.text}');
              //     print('Serial Number: ${_serialNumberController.text}');
              //     print('Contact Details: ${_contactDetailsController.text}');
              //     print('Aadhar Number: ${_aadharNumberController.text}');
              //     print('Address: ${_addressController.text}');
              //
              //     // // Process data here
              //     // ScaffoldMessenger.of(context).showSnackBar(
              //     //   SnackBar(content: Text('Processing Data')),
              //     // );
              //     //
              //     // // Redirect to Home page
              //     // Navigator.pushNamed(context, AppRoutes.registrationSuccess);
              //
              //     // Check if registration was successful
              //     if (registrationViewModel.registrationResponse?.status == 'success') {
              //       ScaffoldMessenger.of(context).showSnackBar(
              //         SnackBar(content: Text('Student Registered successfully')),
              //       );
              //       Navigator.pushNamed(context, AppRoutes.registrationSuccess);
              //     } else {
              //       ScaffoldMessenger.of(context).showSnackBar(
              //         SnackBar(content: Text(registrationViewModel.errorMessage ?? 'Unknown error')),
              //       );
              //     }
              //
              //   }
              // }),
              SubmitButton(onPressed: () async {
                // Validate form and process data here
                if (_formKey.currentState?.validate() ?? false) {
                  // Show loading indicator while processing
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Processing Data...')),
                  );

                  // Get the ViewModel from Provider
                  final registrationViewModel = Provider.of<RegistrationViewModel>(context, listen: false);

                  try {
                    // Register the student with the provided data
                    await registrationViewModel.registerStudent(
                      name: _studentNameController.text,
                      serialNo: _serialNumberController.text,
                      contact: _contactDetailsController.text,
                      aadharNo: _aadharNumberController.text,
                      address: _addressController.text,
                      startDate: _startDateController.text,
                      endDate: _endDateController.text,
                      fee: _feesController.text,
                    );

                    // Debug print statements (you can remove them in production)
                    print('Form validation successful');
                    print('Student Name: ${_studentNameController.text}');
                    print('Start Date: ${_startDateController.text}');
                    print('End Date: ${_endDateController.text}');
                    print('Fees: ${_feesController.text}');
                    print('Serial Number: ${_serialNumberController.text}');
                    print('Contact Details: ${_contactDetailsController.text}');
                    print('Aadhar Number: ${_aadharNumberController.text}');
                    print('Address: ${_addressController.text}');

                    // Check if registration was successful
                    if (registrationViewModel.registrationResponse?.status == 'success') {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Student Registered successfully')),
                      );
                      // Redirect to Success page
                      Navigator.pushNamed(context, AppRoutes.registrationSuccess);
                    } else {
                      // Show error message if registration failed
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(registrationViewModel.errorMessage ?? 'Unknown error')),
                      );
                    }
                  } catch (e) {
                    // Handle any exceptions that occur during the registration process
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('An error occurred: $e')),
                    );
                  }
                } else {
                  // Show validation error if form is not valid
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please fix the errors in the form')),
                  );
                }
              }),

            ],
          ),
        ),
      ),
    );
  }
}
