import 'package:chss_noon_meal/core/di/injector.dart';
import 'package:chss_noon_meal/core/enum/status.dart';
import 'package:chss_noon_meal/core/extension/date_time_extension.dart';
import 'package:chss_noon_meal/core/theme/app_colors.dart';
import 'package:chss_noon_meal/core/utils.dart';
import 'package:chss_noon_meal/presentation/student_entry/bloc/daily_entry_bloc.dart';
import 'package:chss_noon_meal/presentation/student_entry/widgets/class_selection_bottom_sheet.dart';
import 'package:chss_noon_meal/presentation/student_entry/widgets/division_selection_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class DailyEntryScreen extends StatefulWidget {
  const DailyEntryScreen({super.key});

  static const String route = '/daily-entry';

  @override
  State<DailyEntryScreen> createState() => _DailyEntryScreenState();
}

class _DailyEntryScreenState extends State<DailyEntryScreen> {
  late TextEditingController _classController;
  late TextEditingController _divisionController;
  late TextEditingController _boysCountController;
  late TextEditingController _girlsCountController;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _classController = TextEditingController();
    _divisionController = TextEditingController();
    _boysCountController = TextEditingController();
    _girlsCountController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => injector<DailyEntryBloc>(),
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: BlocListener<DailyEntryBloc, DailyEntryState>(
          listener: (context, state) {
            if (state.status.isSuccess) {
              GoRouter.of(context).pop();
            }
          },
          child: BlocBuilder<DailyEntryBloc, DailyEntryState>(
            builder: (context, state) {
              if (_classController.text != state.selectedClassName) {
                _classController.text = state.selectedClassName;
              }

              if (_divisionController.text != state.selectedDivision) {
                _divisionController.text = state.selectedDivision ?? '';
              }

              if (_boysCountController.text != state.boysCount) {
                _boysCountController.text = state.boysCount;
              }

              if (_girlsCountController.text != state.girlsCount) {
                _girlsCountController.text = state.girlsCount;
              }
              return SafeArea(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 15, left: 5),
                        child: IconButton(
                          icon: const Icon(
                            Icons.arrow_back,
                            color: AppColors.black,
                          ),
                          onPressed: () => GoRouter.of(context)
                              .pop(), // Go back using GoRouter
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Gap(10),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  'Daily Entry',
                                  style: TextStyle(
                                    fontSize: 19,
                                    color: AppColors.appColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              const Gap(5),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  'Enter daily counts of boys and girls receiving noon meals by class and division',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: AppColors.commentTextColor,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              const Gap(24),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  'Date *',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: AppColors.darkGrey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: TextFormField(
                                  initialValue: state.date
                                      .toStringFormatted('dd MMM yyyy'),
                                  enabled: false,
                                  decoration: const InputDecoration(
                                    hintText: 'Select Date',
                                    hintStyle: TextStyle(
                                      color: AppColors.textColor,
                                    ),
                                    border: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppColors.textColor,
                                      ), // Default bottom border
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppColors.textColor,
                                      ), // Bottom border when enabled
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppColors.textColor,
                                        width: 2,
                                      ), // Bottom border when focused
                                    ),
                                  ),
                                ),
                              ),
                              const Gap(24),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  'Class *',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: AppColors.darkGrey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: TextFormField(
                                  controller: _classController,
                                  readOnly: true,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please select a class';
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                    hintText: 'Select Class',
                                    hintStyle: TextStyle(
                                      color: AppColors.textColor,
                                    ),
                                    border: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppColors.textColor,
                                      ), // Default bottom border
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppColors.textColor,
                                      ), // Bottom border when enabled
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppColors.textColor,
                                        width: 2,
                                      ), // Bottom border when focused
                                    ),
                                  ),
                                  onTap: () {
                                    showClassSelectionBottomSheet(
                                      context: context,
                                      classList: state.classList,
                                      selectedItem: state.selectedClass,
                                      onSelected: (index) {
                                        context.read<DailyEntryBloc>().add(
                                              ClassSelected(
                                                classData:
                                                    state.classList[index],
                                              ),
                                            );
                                      },
                                    );
                                  },
                                ),
                              ),
                              const Gap(24),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  'Division *',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: AppColors.darkGrey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: TextFormField(
                                  controller: _divisionController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please select a division';
                                    }
                                    return null;
                                  },
                                  readOnly: true,
                                  decoration: const InputDecoration(
                                    hintText: 'Select Division',
                                    hintStyle:
                                        TextStyle(color: AppColors.textColor),
                                    border: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppColors.textColor,
                                      ), // Default bottom border
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppColors.textColor,
                                      ), // Bottom border when enabled
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppColors.textColor,
                                        width: 2,
                                      ), // Bottom border when focused
                                    ),
                                  ),
                                  onTap: () {
                                    final divisionList =
                                        state.selectedClass?.divisions ?? [];
                                    if (state.selectedClass != null) {
                                      showDivisionSelectionBottomSheet(
                                        context: context,
                                        divisionList: divisionList,
                                        selectedItem: state.selectedDivision,
                                        onSelected: (index) {
                                          context.read<DailyEntryBloc>().add(
                                                DivisionSelected(
                                                  division: divisionList[index],
                                                ),
                                              );
                                        },
                                      );
                                    } else {
                                      Utils.showToast('Please select a class');
                                    }
                                  },
                                ),
                              ),
                              const Gap(24),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  'Boys *',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: AppColors.darkGrey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: TextFormField(
                                  controller: _boysCountController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter boys count';
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.next,
                                  decoration: const InputDecoration(
                                    hintText: 'Enter Boys Count',
                                    hintStyle:
                                        TextStyle(color: AppColors.textColor),
                                    border: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppColors.textColor,
                                      ), // Default bottom border
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppColors.textColor,
                                      ), // Bottom border when enabled
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppColors.textColor,
                                        width: 2,
                                      ), // Bottom border when focused
                                    ),
                                  ),
                                  onTapOutside: (_) => unFocusKeyboard,
                                  onChanged: (value) {
                                    context
                                        .read<DailyEntryBloc>()
                                        .add(BoysCountChanged(count: value));
                                  },
                                ),
                              ),
                              const Gap(24),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  'Girls *',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: AppColors.darkGrey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: TextFormField(
                                  controller: _girlsCountController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter girls count';
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.done,
                                  decoration: const InputDecoration(
                                    hintText: 'Enter Girls Count',
                                    hintStyle:
                                        TextStyle(color: AppColors.textColor),
                                    border: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppColors.textColor,
                                      ), // Default bottom border
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppColors.textColor,
                                      ), // Bottom border when enabled
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppColors.textColor,
                                        width: 2,
                                      ), // Bottom border when focused
                                    ),
                                  ),
                                  onTapOutside: (_) => unFocusKeyboard,
                                  onChanged: (value) {
                                    context
                                        .read<DailyEntryBloc>()
                                        .add(GirlsCountChanged(count: value));
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  GoRouter.of(context).pop();
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: 45,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppColors.appColor,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'Cancel',
                                      style: TextStyle(
                                        fontSize: 17,
                                        color: AppColors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const Gap(25),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    context
                                        .read<DailyEntryBloc>()
                                        .add(SaveButtonPressed());
                                  }
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: 45,
                                  decoration: BoxDecoration(
                                    color: AppColors.appColor,
                                    border: Border.all(
                                      color: AppColors.appColor,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Text(
                                      state.isUpdateMode ? 'Update' : 'Save',
                                      style: const TextStyle(
                                        fontSize: 17,
                                        color: AppColors.white,
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
        ),
      ),
    );
  }

  void unFocusKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
