import 'package:chss_noon_meal/core/di/injector.dart';
import 'package:chss_noon_meal/core/theme/app_colors.dart';
import 'package:chss_noon_meal/presentation/student_entry/bloc/daily_entry_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../home/screen/home_screen.dart';
import '../../widgets/app_text_field.dart';

class StudentEntry extends StatelessWidget {
  StudentEntry({super.key});

  static const String route = '/student';
  List<String> classes = [
    "Class 5",
    "Class 6",
    "Class 7",
    "Class 8",
    "Class 9",
    "Class 10"
  ];
  ///tst
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => injector<DailyEntryBloc>(),
      child: Scaffold(
        backgroundColor: AppColors.white,
       /* appBar: AppBar(
          backgroundColor: AppColors.white,
          title: const Text(
            '',
            style: TextStyle(color: AppColors.white),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => GoRouter.of(context).pop() // Go back using GoRouter
          ),
        ),*/
        body: BlocBuilder<DailyEntryBloc, DailyEntryState>(
          builder: (context, state) {
            return SafeArea(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                
                    Padding(
                      padding: const EdgeInsets.only(top:15.0,left: 5),
                      child: IconButton(
                          icon: const Icon(Icons.arrow_back,color: AppColors.black,),
                          onPressed: () => GoRouter.of(context).pop() // Go back using GoRouter
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Gap(10),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                'Daily Entry',
                                style: TextStyle(
                                    fontSize: 19,
                                    color: AppColors.app_color,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.start,
                              ),
                            ),
                            Gap(5),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                'Enter daily counts of boys and girls\nreceiving noon meals by class and division',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: AppColors.commentTextColor,
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ),
                            const Gap(30),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                'Class *',
                                style: TextStyle(
                                    fontSize: 13,
                                    color: AppColors.darkGrey,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.start,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: TextFormField(
                                readOnly: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please choose class';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  hintText: 'Select Class',
                                  hintStyle: TextStyle(
                                      color: AppColors.textColor,),
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColors
                                            .textColor), // Default bottom border
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColors
                                            .textColor), // Bottom border when enabled
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColors.textColor,
                                        width:
                                            2.0), // Bottom border when focused
                                  ),
                                ),
                                onTap: () {
                                  showPhoneNumbersBottomSheet(context);
                                },
                                onChanged: (value) {},
                              ),
                            ),
                            const Gap(30),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                'Division *',
                                style: TextStyle(
                                    fontSize: 13,
                                    color: AppColors.darkGrey,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.start,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Choose your division';
                                  }
                                  return null;
                                },
                                readOnly: true,
                                decoration: InputDecoration(
                                  hintText: 'Select Division',
                                  hintStyle:
                                      TextStyle(color: AppColors.textColor),
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColors
                                            .textColor), // Default bottom border
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColors
                                            .textColor), // Bottom border when enabled
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColors.textColor,
                                        width:
                                            2.0), // Bottom border when focused
                                  ),
                                ),
                                onChanged: (value) {},
                              ),
                            ),
                            const Gap(30),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                'Boys *',
                                style: TextStyle(
                                    fontSize: 13,
                                    color: AppColors.darkGrey,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.start,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter boys count';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  hintText: 'Enter Boys Count',
                                  hintStyle:
                                      TextStyle(color: AppColors.textColor),
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColors
                                            .textColor), // Default bottom border
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColors
                                            .textColor), // Bottom border when enabled
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColors.textColor,
                                        width:
                                            2.0), // Bottom border when focused
                                  ),
                                ),
                                onChanged: (value) {},
                              ),
                            ),
                            const Gap(30),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                'Girls *',
                                style: TextStyle(
                                    fontSize: 13,
                                    color: AppColors.darkGrey,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.start,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter girls count';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.done,
                                decoration: InputDecoration(
                                  hintText: 'Enter Girls Count',
                                  hintStyle:
                                      TextStyle(color: AppColors.textColor),
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColors
                                            .textColor), // Default bottom border
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColors
                                            .textColor), // Bottom border when enabled
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColors.textColor,
                                        width:
                                            2.0), // Bottom border when focused
                                  ),
                                ),
                                onChanged: (value) {},
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {},
                              child: Container(
                                width: double.infinity,
                                height: 45,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: AppColors.app_color,
                                    width: 1.0, // border width
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Center(
                                  child: Text(
                                    "Cancel",
                                    style: TextStyle(
                                      fontSize: 17,
                                      color: AppColors.black,
                                      fontFamily: "UbuntuMedium",
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Gap(25),
                          Expanded(
                
                            child: GestureDetector(
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  // If the form is valid, display a snackbar. In the real world,
                                  // you'd often call a server or save the information in a database.
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Processing Data')),
                                  );
                                }
                              },
                              child: Container(
                
                                width: double.infinity,
                                height: 45,
                                decoration: BoxDecoration(
                                  color: AppColors.app_color,
                                  border: Border.all(
                                    color: AppColors.app_color,
                                    width: 1.0, // border width
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Center(
                                  child: Text(
                                    "Save",
                                    style: TextStyle(
                                      fontSize: 17,
                                      color: AppColors.white,
                                      fontFamily: "UbuntuMedium",
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                
                  ],
                ),
              ),
            );
          },
    ),
    ),);
  }

  void showPhoneNumbersBottomSheet(BuildContext context) {
    double sheetHeight = MediaQuery.of(context).size.height *
        0.25; // Initial height, adjust as needed

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              height: sheetHeight,
              color: AppColors.white, // White background color
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                // Ensure the bottom sheet only takes up as much space as needed
                children: [
                  /* Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.clear,
                          color: Colors.red,
                          size: 25,
                        ),
                        // Icon to close the bottom sheet
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )
                    ],
                  ),*/
                  Gap(10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Choose your class',
                      style: TextStyle(
                          fontSize: 14,
                          color: AppColors.darkGrey,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: GridView.builder(
                        itemCount: classes.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          // Number of columns in the grid
                          // crossAxisSpacing: 10.0, // Horizontal spacing between items
                          //  mainAxisSpacing: 10.0, // Vertical spacing between items
                          childAspectRatio:
                              2, // Aspect ratio of each item (width / height)
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          var item = classes[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.pop(
                                  context); // Close bottom sheet when an item is tapped
                            },
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Container(
                                //width: double.infinity,
                                decoration: BoxDecoration(
                                  color: AppColors.app_color,
                                  // Container background color
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      spreadRadius: 5.0,
                                      blurRadius: 7.0,
                                      offset: Offset(0.0,
                                          3.0), // Moves the shadow slightly down and right
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(4.0),
                                  child: Center(
                                    child: Text(
                                      item,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'UbuntuMedium',
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
