import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:library_app/features/registration/presentation/widgets/submit_button.dart';
import 'package:library_app/res/colors/app_color.dart';
import 'package:library_app/res/fonts/text_style.dart';
import '../../../../res/routes/app_routes.dart';
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
                  Navigator.pushNamed(context, AppRoutes.home);
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
              SubmitButton(onPressed: () {
                // Validate form and process data here
                if (_formKey.currentState?.validate() ?? false) {
                  // Process data here
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Processing Data')),
                  );

                  // Redirect to Home page
                  Navigator.pushNamed(context, AppRoutes.registrationSuccess);
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
