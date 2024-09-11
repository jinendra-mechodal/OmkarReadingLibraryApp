import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../res/colors/app_color.dart';
import '../../../../res/fonts/text_style.dart';
import '../../../../res/routes/app_routes.dart';
import '../../../registration/presentation/widgets/registration_form.dart';
import '../../../registration/presentation/widgets/submit_button.dart';
import '../widgets/custom_dropdown_student.dart';
import '../widgets/custom_dropdown_subscription.dart';

class PrintPaymentScreen extends StatefulWidget {
  const PrintPaymentScreen({super.key});

  @override
  State<PrintPaymentScreen> createState() => _PrintPaymentScreenState();
}

class _PrintPaymentScreenState extends State<PrintPaymentScreen> {
  final List<String> _studentNames = [
    'Chetan Parmar',
    'Riyaz Khokhar',
    'Darshan Vaghani',
    'Divyesh Sonagara',
    'Chetan Parmar',
    'Riyaz Khokhar',
    'Darshan Vaghani',
    'Divyesh Sonagara',
    'Chetan Parmar',
    'Riyaz Khokhar',
    'Darshan Vaghani',
    'Divyesh Sonagara',
    'Chetan Parmar',
    'Riyaz Khokhar',
    'Darshan Vaghani',
    'Divyesh Sonagara',
  ];

  final List<Map<String, String>> _studentsubscription = [
    {
      'subscriptionPeriod': '22-12-2024 To 22-01-2025',
      'upgradedAt': '28-Jul-2023',
      'amount': '₹1200',
    },
    {
      'subscriptionPeriod': '01-01-2024 To 01-02-2024',
      'upgradedAt': '15-Dec-2023',
      'amount': '₹1500',
    },
    {
      'subscriptionPeriod': '05-02-2024 To 05-03-2024',
      'upgradedAt': '25-Jan-2024',
      'amount': '₹1800',
    },
    {
      'subscriptionPeriod': '10-03-2024 To 10-04-2024',
      'upgradedAt': '05-Feb-2024',
      'amount': '₹2000',
    },
    {
      'subscriptionPeriod': '20-04-2024 To 20-05-2024',
      'upgradedAt': '10-Mar-2024',
      'amount': '₹1700',
    },
    {
      'subscriptionPeriod': '01-06-2024 To 01-07-2024',
      'upgradedAt': '01-May-2024',
      'amount': '₹1600',
    },
    {
      'subscriptionPeriod': '15-07-2024 To 15-08-2024',
      'upgradedAt': '15-Jun-2024',
      'amount': '₹1900',
    },
    {
      'subscriptionPeriod': '01-09-2024 To 01-10-2024',
      'upgradedAt': '01-Aug-2024',
      'amount': '₹2000',
    },
    {
      'subscriptionPeriod': '10-10-2024 To 10-11-2024',
      'upgradedAt': '15-Sep-2024',
      'amount': '₹2100',
    },
    {
      'subscriptionPeriod': '20-11-2024 To 20-12-2024',
      'upgradedAt': '01-Nov-2024',
      'amount': '₹2200',
    },
  ];

  String? _selectedStudent;
  String? _selectedSubscription;

  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _searchSubscriptionController = TextEditingController();

  List<String> _filteredStudentNames = [];
  List<Map<String, String>> _filteredSubscriptions = [];

  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _feesController = TextEditingController();

  final FocusNode _startDateFocusNode = FocusNode();
  final FocusNode _endDateFocusNode = FocusNode();
  final FocusNode _feesFocusNode = FocusNode();

  Future<void> _selectDate(TextEditingController controller) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.blue, // Color for the selected date
            hintColor: AppColor.btncolor, // Color for the buttons
            buttonTheme: ButtonThemeData(
              textTheme: ButtonTextTheme.primary,
            ),
            dialogBackgroundColor: Colors.white, // Background color
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColor.btncolor, // Color of the buttons
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (selectedDate != null) {
      setState(() {
        // Format date as DD-MM-YYYY
        final DateFormat formatter = DateFormat('dd-MM-yyyy');
        final String formattedDate = formatter.format(selectedDate);
        controller.text = formattedDate;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _filteredStudentNames = _studentNames;
    _filteredSubscriptions = _studentsubscription;

    _searchController.addListener(() {
      setState(() {
        _filteredStudentNames = _studentNames
            .where((name) => name.toLowerCase().contains(_searchController.text.toLowerCase()))
            .toList();
      });
    });

    _searchSubscriptionController.addListener(() {
      setState(() {
        _filteredSubscriptions = _studentsubscription
            .where((subscription) => subscription['subscriptionPeriod']?.toLowerCase().contains(_searchSubscriptionController.text.toLowerCase()) ?? false)
            .toList();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchSubscriptionController.dispose();
    super.dispose();
  }

  void _openBottomSheetStudent() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          height: 600,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    prefixIcon: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Image.asset(
                        'assets/icons/search-icon.png',
                        color: AppColor.textcolorSilver,
                        height: 24.h,
                        width: 24.w,
                      ),
                    ),
                    hintText: 'Search student...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: _filteredStudentNames.map((studentName) {
                    return ListTile(
                      title: Text(studentName),
                      onTap: () {
                        setState(() {
                          _selectedStudent = studentName;
                        });
                        Navigator.pop(context); // Close the bottom sheet
                      },
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _openBottomSheetSubscription() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          height: 600,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
          ),
          child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 24.h,),
              Padding(
                padding:  EdgeInsets.symmetric(
                  horizontal: 16.w,
                ),
                child: Text("Select Subscription",
                style: LexendtextFont500.copyWith(
                  color: AppColor.textcolor_blue,
                  fontSize: 14.sp,
                ),
                ),
              ),
              SizedBox(height: 10.h,),
              // Padding(
              //   padding: EdgeInsets.all(16.0),
              //   child: TextField(
              //     controller: _searchSubscriptionController,
              //     decoration: InputDecoration(
              //       prefixIcon: Icon(Icons.search),
              //       hintText: 'Search subscription...',
              //       border: OutlineInputBorder(
              //         borderRadius: BorderRadius.circular(8.0),
              //       ),
              //     ),
              //   ),
              // ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: _filteredSubscriptions.map((subscription) {
                    return ListTile(
                      title: Container(
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          color: AppColor.bglightgray,
                          // color: Color(0xffF5F5F5F5).withOpacity(0.80),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        width: double.infinity,
                        height: 70.h,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                        subscription['subscriptionPeriod'] ?? '',
                                 // '22-12-2024 To 22-01-2025',
                                  style: LexendtextFont500.copyWith(
                                    color: AppColor.textcolorBlack,
                                    fontSize: 14.sp,
                                  ),
                                ),
                                Text(
                                  subscription['upgradedAt'] ?? '',

                                  //"Upgraded At At 28-Jul-2023",
                                  // "Subscription End : $endDate",
                                  style: mulishRegularFont300.copyWith(
                                    color: AppColor.textcolor_gray,
                                    fontSize: 10.sp,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                                subscription['amount'] ?? '',
                             // "₹1200",
                              style: LexendtextFont500.copyWith(
                                color: AppColor.textcolorBlack,
                                fontSize: 14.sp,
                              ),
                            ),
                          ],
                        ),
                      ),

                      onTap: () {
                        setState(() {
                          _selectedSubscription = subscription['subscriptionPeriod'];
                        });
                        Navigator.pop(context); // Close the bottom sheet
                      },
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
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
                color: Colors.black12.withOpacity(0.02),
                spreadRadius: 1,
                blurRadius: 4,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: AppBar(
            backgroundColor: AppColor.whiteColor,
            title: Text(
              'Print Payment Slip',
              style: LexendtextFont500.copyWith(
                fontSize: 16.sp,
                color: AppColor.textcolorBlack,
              ),
            ),
            actions: [
              InkWell(
                onTap: () {
                 // Navigator.pushNamed(context, AppRoutes.home);
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
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            CustomDropdownStuden(
              value: _selectedStudent,
              hint: 'Select Student',
              onTap: _openBottomSheetStudent,
            ),
            SizedBox(height: 20.h),
            CustomDropdownSubscription(
              value: _selectedSubscription,
              hint: 'Select Subscription',
              onTap: _openBottomSheetSubscription,
            ),
            SizedBox(height: 20.h),

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
            SizedBox(height: 20.h),
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
            SizedBox(height: 20.h),

            Container(
              height: 56.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7.r),
                color: AppColor.btncolor,
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
                onPressed: (){
                  Navigator.pushNamed(context, AppRoutes.home);
                },
                child: Center(
                  child: Text(
                    'Print Payment Slip',
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
  }
}
