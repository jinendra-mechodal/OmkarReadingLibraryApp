import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../res/colors/app_color.dart';
import '../../../../res/fonts/text_style.dart';
import '../../../../res/routes/app_routes.dart';
import '../../../../utils/logger.dart';
import '../../../../utils/shared_preferences_helper.dart';
import '../../../registration/presentation/widgets/registration_form.dart';
import '../../../registration/presentation/widgets/submit_button.dart';
import '../../data/PrintStudentRecordRepository.dart';
import '../widgets/custom_dropdown_student.dart';
import '../widgets/custom_dropdown_subscription.dart';

class PrintPaymentScreen extends StatefulWidget {
  const PrintPaymentScreen({super.key});

  @override
  State<PrintPaymentScreen> createState() => _PrintPaymentScreenState();
}

class _PrintPaymentScreenState extends State<PrintPaymentScreen> {
  final PrintStudentRecordRepository _repository =
      PrintStudentRecordRepository();

  List<String> _studentNames = [];
  Map<String, String> _studentMap = {};
  String? _selectedStudentId;
  List<Map<String, String>> _studentsubscription = [];
  String? _selectedStudent;
  String? _selectedSubscription;

  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _searchSubscriptionController =
      TextEditingController();
  List<String> _filteredStudentNames = [];
  List<Map<String, String>> _filteredSubscriptions = [];

  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _feesController = TextEditingController();
  final FocusNode _startDateFocusNode = FocusNode();
  final FocusNode _endDateFocusNode = FocusNode();
  final FocusNode _feesFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _fetchStudentRecords();

    _searchController.addListener(() {
      setState(() {
        _filteredStudentNames = _studentNames
            .where((name) => name
                .toLowerCase()
                .contains(_searchController.text.toLowerCase()))
            .toList();
      });
    });

    _searchSubscriptionController.addListener(() {
      setState(() {
        _filteredSubscriptions = _studentsubscription
            .where((subscription) =>
                subscription['subscriptionPeriod']?.toLowerCase().contains(
                    _searchSubscriptionController.text.toLowerCase()) ??
                false)
            .toList();
      });
    });
  }

  Future<void> _fetchStudentRecords() async {
    try {
      final userIdString = await SharedPreferencesHelper.getUserId();
      final userId = userIdString != null ? int.tryParse(userIdString) : null;

      if (userId != null) {
        print('Fetching student records for User ID: $userId');
        final records = await _repository.fetchStudentRecord(userId);
        print('Fetched student records: $records');

        setState(() {
          _studentMap = {
            for (var record in records) record.name: record.studentId
          };
          _studentNames = _studentMap.keys.toList();
          _filteredStudentNames = _studentNames;
        });
      } else {
        print('User ID is null or invalid');
      }
    } catch (e) {
      print('Error fetching student records: $e');
    }
  }

  Future<void> _fetchSubscriptions() async {
    // Ensure we have a selected student ID
    if (_selectedStudentId != null) {
      // Attempt to parse the selected student ID to an integer
      final selectedStudentId = int.tryParse(_selectedStudentId!);

      if (selectedStudentId != null) {
        // Log the start of the fetch process
        logDebug(
            'Fetching subscription details for Student ID: $selectedStudentId');

        try {
          // Fetch subscription details from the repository
          final records =
              await _repository.fetchSubscriptionDetails(selectedStudentId);

          // Log the fetched records
          logDebug('Fetched subscription records: \n$records');

          if (records.isNotEmpty) {
            // Process and log the records if not empty
            final processedRecords = records.map((record) {
              return {
                'start_date': record.startDate ?? 'N/A',
                'end_date': record.endDate ?? 'N/A',
                'fee': record.fee ?? 'N/A',
                'created_at': record.createdAt ?? 'N/A',
              };
            }).toList();

            // Update state and log the processed records
            setState(() {
              _studentsubscription = processedRecords;
              _filteredSubscriptions = _studentsubscription;
            });
            logDebug('Processed subscription records: $_studentsubscription');
          } else {
            // Log when no records are found
            logDebug(
                'No subscription records found for Student ID: $selectedStudentId');
            setState(() {
              _studentsubscription = [];
              _filteredSubscriptions = [];
            });
          }
        } catch (e) {
          // Log any exceptions encountered during the fetch process
          logDebug('Error fetching subscription details: $e');
          setState(() {
            _studentsubscription = [];
            _filteredSubscriptions = [];
          });
        }
      } else {
        // Log when the selected student ID is invalid
        logDebug(
            'Selected Student ID ($selectedStudentId) is not a valid integer.');
      }
    } else {
      // Log when no student ID is selected
      logDebug('Selected Student ID is null.');
    }
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
                child: _filteredStudentNames.isNotEmpty
                    ? ListView(
                        padding: EdgeInsets.zero,
                        children: _filteredStudentNames.map((studentName) {
                          return ListTile(
                            title: Text(studentName),
                            onTap: () {
                              setState(() {
                                _selectedStudent = studentName;
                                _selectedStudentId = _studentMap[studentName];
                                print(
                                    'Selected Student: $_selectedStudent, ID: $_selectedStudentId');
                              });

                              // Fetch subscriptions based on selected student
                              _fetchSubscriptions();

                              Navigator.pop(context); // Close the bottom sheet
                            },
                          );
                        }).toList(),
                      )
                    : Center(child: Text('No students found')),
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
              SizedBox(height: 24.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Text(
                  "Select Subscription",
                  style: LexendtextFont500.copyWith(
                    color: AppColor.textcolor_blue,
                    fontSize: 14.sp,
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Expanded(
                child: _filteredSubscriptions.isNotEmpty
                    ? ListView(
                        padding: EdgeInsets.zero,
                        children: _filteredSubscriptions.map((subscription) {
                          return ListTile(
                            title: Container(
                              padding: EdgeInsets.all(16.w),
                              decoration: BoxDecoration(
                                color: AppColor.bglightgray,
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              width: double.infinity,
                              height: 70.h,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            subscription[
                                                    'start_date'] ??
                                                '',
                                            // '22-12-2024 To 22-01-2025',
                                            style: LexendtextFont500.copyWith(
                                              color: AppColor.textcolorBlack,
                                              fontSize: 14.sp,
                                            ),
                                          ),
                                          Text(
                                            'TO',
                                            // '22-12-2024 To 22-01-2025',
                                            style: LexendtextFont500.copyWith(
                                              color: AppColor.textcolorBlack,
                                              fontSize: 14.sp,
                                            ),
                                          ),
                                          Text(
                                            subscription[
                                                    'end_date'] ??
                                                '',
                                            // '22-12-2024 To 22-01-2025',
                                            style: LexendtextFont500.copyWith(
                                              color: AppColor.textcolorBlack,
                                              fontSize: 14.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                       // subscription['created_at'] ?? '',
                                        'Upgraded At ${subscription['created_at']}',
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
                                    '₹${subscription['fee']}',
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
                                _selectedSubscription =
                                '${subscription['start_date']} TO ${subscription['end_date']}';
                              });
                              Navigator.pop(context); // Close the bottom sheet
                            },
                          );
                        }).toList(),
                      )
                    : Center(child: Text('No subscriptions found')),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _selectDate(TextEditingController controller) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.blue,
            hintColor: AppColor.btncolor,
            buttonTheme: ButtonThemeData(
              textTheme: ButtonTextTheme.primary,
            ),
            dialogBackgroundColor: Colors.white,
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColor.btncolor,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (selectedDate != null) {
      setState(() {
        final DateFormat formatter = DateFormat('dd-MM-yyyy');
        final String formattedDate = formatter.format(selectedDate);
        controller.text = formattedDate;
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
                onPressed: () {
                 // Navigator.pushNamed(context, AppRoutes.home);
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
