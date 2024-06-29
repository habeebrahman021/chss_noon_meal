import 'package:chss_noon_meal/core/di/injector.dart';
import 'package:chss_noon_meal/core/enum/status.dart';
import 'package:chss_noon_meal/core/extension/date_time_extension.dart';
import 'package:chss_noon_meal/core/theme/app_colors.dart';
import 'package:chss_noon_meal/domain/entity/dashboard/chart_data.dart';
import 'package:chss_noon_meal/presentation/home/bloc/home_bloc.dart';
import 'package:chss_noon_meal/presentation/login/screen/login_screen.dart';
import 'package:chss_noon_meal/presentation/student_entry/screen/daily_entry_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../reports/screen/entry_report.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const String route = '/home';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => injector<HomeBloc>(),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.white,
            appBar: AppBar(
              backgroundColor: AppColors.app_color,
              elevation: 0,
              title: const Text(
                'Home',
                style: TextStyle(color: AppColors.white),
              ),
              actions: [
                BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    return IconButton(
                      onPressed: () {
                        context.read<HomeBloc>().add(LogoutButtonPressed());
                      },
                      icon: const Icon(
                        Icons.exit_to_app,
                        color: AppColors.white,
                      ),
                    );
                  },
                ),
              ],
            ),
            body: BlocListener<HomeBloc, HomeState>(
              listener: (context, state) {
                if (state.logoutStatus.isSuccess) {
                  GoRouter.of(context).pushReplacementNamed(LoginScreen.route);
                }
              },
              child: BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 26, right: 26),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Gap(30),
                          Text(
                            'Hi, ${state.fullName}',
                            style: const TextStyle(
                              fontSize: 28,
                              color: AppColors.darkGrey,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.start,
                          ),
                          const Gap(5),
                          const Text(
                            'Welcome to the Dashboard',
                            style: TextStyle(
                              //  fontSize: 18,
                              color: AppColors.title_color,
                            ),
                            textAlign: TextAlign.start,
                          ),
                          const Gap(25),
                          Container(
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              // Container background color
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  // Shadow color with transparency
                                  spreadRadius: 5,
                                  // Adjusts how far the shadow spreads
                                  blurRadius: 7,
                                  // Adjusts how blurry the shadow is
                                  offset: const Offset(
                                    0,
                                    3,
                                  ), // Moves the shadow slightly down and right
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Daily Entry',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: AppColors.darkGrey,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                      Text(
                                        state.date.toStringFormatted(
                                          'dd MMM yyyy',
                                        ),
                                        style: const TextStyle(
                                          fontSize: 13,
                                          color: AppColors.darkGrey,
                                          // fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                    ],
                                  ),
                                ),
                                SfCircularChart(
                                  legend: const Legend(
                                    isVisible: true,
                                    position: LegendPosition.bottom,
                                  ),
                                  annotations: [
                                    CircularChartAnnotation(
                                      widget: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            state.totalCount,
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const Text(
                                            'Students',
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: AppColors.textColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                  series: [
                                    DoughnutSeries<ChartData, String>(
                                      dataSource: state.chartData,
                                      pointColorMapper: (ChartData data, _) =>
                                          data.color,
                                      xValueMapper: (ChartData data, _) =>
                                          data.x,
                                      yValueMapper: (ChartData data, _) =>
                                          data.y,
                                      // Increase the radius
                                      innerRadius: '60%',
                                      dataLabelSettings:
                                          const DataLabelSettings(
                                        // Renders the data label
                                        isVisible: true,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const Gap(40),
                          InkWell(
                            onTap: () async {
                              await GoRouter.of(context)
                                  .pushNamed(EntryReport.route);
                            },
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                // Container background color
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    // Shadow color with transparency
                                    spreadRadius: 5,
                                    // Adjusts how far the shadow spreads
                                    blurRadius: 7,
                                    // Adjusts how blurry the shadow is
                                    offset: const Offset(
                                      0,
                                      3,
                                    ), // Moves the shadow slightly down and right
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Row(
                                  //mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Image.asset(
                                      'images/report-card.png',
                                      width: 70,
                                      height: 70,
                                      color: AppColors.black,
                                    ),
                                    const Gap(10),
                                    const Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Report',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.black,
                                            ),
                                          ),
                                          Gap(3),
                                          Text(
                                            'View detailed report of students receiving noon meals in each class and division',
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: AppColors.black,
                                            ),
                                            textAlign: TextAlign.start,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: AppColors.app_color,
              onPressed: () async {
                await GoRouter.of(context)
                    .pushNamed(DailyEntryScreen.route)
                    .then((_) {
                  context.read<HomeBloc>().add(GetStudentEntryCount());
                });
              },
              child: const Icon(
                Icons.add,
                color: AppColors.white,
              ),
            ),
          );
        },
      ),
    );
  }
}
