import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../res/colors/app_color.dart';
import '../../../res/fonts/text_style.dart';
import '../../../res/routes/app_routes.dart';
import '../../registration/presentation/widgets/registration_form.dart';
import '../../registration/presentation/widgets/submit_button.dart';
import 'data/student_service.dart';

class StudentRecordEdit extends StatefulWidget {
  final int? studentId;

  const StudentRecordEdit({Key? key, this.studentId}) : super(key: key);

  @override
  State<StudentRecordEdit> createState() => _StudentRecordEditState();
}

class _StudentRecordEditState extends State<StudentRecordEdit> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for the form fields
  final TextEditingController _studentNameController = TextEditingController();
  final TextEditingController _serialNumberController = TextEditingController();
  final TextEditingController _contactDetailsController = TextEditingController();
  final TextEditingController _aadharNumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  // Focus nodes for the form fields
  final FocusNode _studentNameFocusNode = FocusNode();
  final FocusNode _serialNumberFocusNode = FocusNode();
  final FocusNode _contactDetailsFocusNode = FocusNode();
  final FocusNode _aadharNumberFocusNode = FocusNode();
  final FocusNode _addressFocusNode = FocusNode();

  final StudentService _studentService = StudentService();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    final int? studentId = widget.studentId;
    print('Received student ID on edit page init call: $studentId');

    if (widget.studentId != null) {
      _fetchStudentDetails();
    }
  }

  Future<void> _fetchStudentDetails() async {
    setState(() => _isLoading = true);
    try {
      if (widget.studentId != null) {
        final studentDetailsResponse = await _studentService.getStudentDetails(widget.studentId!);

        if (studentDetailsResponse.status == 'success') {
          final studentData = studentDetailsResponse.data;

          // Print the student details
          print('Student Details: ${studentData.name}, ${studentData.serialNo}, ${studentData.contact}, ${studentData.aadharNo}, ${studentData.address}');

          setState(() {
            _studentNameController.text = studentData.name;
            _serialNumberController.text = studentData.serialNo;
            _contactDetailsController.text = studentData.contact;
            _aadharNumberController.text = studentData.aadharNo;
            _addressController.text = studentData.address;
          });
        } else {
          throw Exception(studentDetailsResponse.message);
        }
      }
    } catch (e) {
      print('Error fetching student details: $e'); // Debugging output
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching student details: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _updateStudentDetails() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _isLoading = true);
      try {
        final response = await _studentService.updateStudentDetails(
          studentId: widget.studentId ?? 0,
          name: _studentNameController.text,
          serialNo: _serialNumberController.text,
          contact: _contactDetailsController.text,
          aadharNo: _aadharNumberController.text,
          address: _addressController.text,
        );

        print('Update response: ${response.message}'); // Debugging output
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response.message)),
        );

        if (response.status == 'success') {
          Navigator.pushReplacementNamed(
            context,
            AppRoutes.studentsdetails,
            arguments: widget.studentId,
          );
        }
      } catch (e) {
        print('Error updating student details: $e'); // Debugging output
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error updating student details: $e')),
        );
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  void dispose() {
    // Dispose of controllers and focus nodes to prevent memory leaks
    _studentNameController.dispose();
    _serialNumberController.dispose();
    _contactDetailsController.dispose();
    _aadharNumberController.dispose();
    _addressController.dispose();
    _studentNameFocusNode.dispose();
    _serialNumberFocusNode.dispose();
    _contactDetailsFocusNode.dispose();
    _aadharNumberFocusNode.dispose();
    _addressFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: BoxDecoration(
            color: AppColor.whiteColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black12.withOpacity(0.02),
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: AppBar(
            backgroundColor: AppColor.whiteColor,
            title: Text(
              'Edit Details',
              style: LexendtextFont500.copyWith(
                fontSize: 16.sp,
                color: AppColor.textcolorBlack,
              ),
            ),
            actions: [
              InkWell(
                onTap: () {
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
      body: _isLoading
          ? Center(child: CircularProgressIndicator(
        color: AppColor.btncolor,
      ))
          : SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 19.h),
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
              SubmitButton(onPressed: _updateStudentDetails),
            ],
          ),
        ),
      ),
    );
  }
}
