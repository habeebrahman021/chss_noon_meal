import 'package:chss_noon_meal/core/di/injector.dart';
import 'package:chss_noon_meal/core/enum/status.dart';
import 'package:chss_noon_meal/presentation/home/bloc/home_bloc.dart';
import 'package:chss_noon_meal/presentation/login/screen/login_screen.dart';
import 'package:chss_noon_meal/presentation/student_entry/screen/student_entry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../core/theme/app_colors.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({super.key});

  static const String route = '/home';
  final List<ChartData> chartData = [
    ChartData('Boys', 25, AppColors.incentiveColor),
    ChartData('Girls', 38, AppColors.commitmentstatusbg),
  ];
  @override
  Widget build(BuildContext context) {
    double totalCount = chartData.fold(0, (sum, item) => sum + item.y);
    return BlocProvider(
      create: (context) => injector<HomeBloc>(),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.white,
            appBar: AppBar(
              backgroundColor: AppColors.app_color,
              elevation: 0,
              title: const Text('Home',style: TextStyle(color: AppColors.white),),
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
              child:  Center(
                child: Padding(
                  padding:  EdgeInsets.only(left: 26,right: 26),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Gap(30),
                      Text(
                        'Hi, Jasel Fasil K',
                        style: TextStyle(
                            fontSize: 28,
                            color: AppColors.darkGrey,
                            fontWeight: FontWeight.bold
                        ),
                        textAlign: TextAlign.start,
                      ),

                      Gap(5),
                      Text(
                        'Welcome to the Dashboard',
                        style: TextStyle(
                          //  fontSize: 18,
                          color: AppColors.title_color,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      Gap(25),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          // Container background color
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              // Shadow color with transparency
                              spreadRadius: 5.0,
                              // Adjusts how far the shadow spreads
                              blurRadius: 7.0,
                              // Adjusts how blurry the shadow is
                              offset: Offset(0.0,
                                  3.0), // Moves the shadow slightly down and right
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Daily Entry',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: AppColors.darkGrey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                                Text(
                                  '24 June 2024',
                                  style: TextStyle(
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
                              legend: Legend(isVisible: true,
                                  position: LegendPosition.bottom),
                                  annotations: [
                                    CircularChartAnnotation(
                                        widget: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "${totalCount.toInt().toString()}",
                                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              "Students",
                                              style: const TextStyle(fontSize: 13,color: AppColors.textColor),
                                            ),
                                          ],
                                        ))
                                  ],
                                    series: <CircularSeries>[
                                      // Renders doughnut chart
                                      DoughnutSeries<ChartData, String>(
                                          dataSource: chartData,
                                          pointColorMapper:(ChartData data,  _) => data.color,
                                          xValueMapper: (ChartData data, _) => data.x,
                                          yValueMapper: (ChartData data, _) => data.y,
                                        //  dataLabelMapper: (ChartData data, _) => "${data.x} " +" ${data.y.toInt().toString()}",
                                          radius: '80%',  // Increase the radius
                                          innerRadius: '60%',
                                          dataLabelSettings: DataLabelSettings(
                                            // Renders the data label
                                              isVisible: true
                                          )
                                      )
                                    ],

                                ),
                          ],
                        ),
                      ),
                      Gap(40),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          // Container background color
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              // Shadow color with transparency
                              spreadRadius: 5.0,
                              // Adjusts how far the shadow spreads
                              blurRadius: 7.0,
                              // Adjusts how blurry the shadow is
                              offset: Offset(0.0,
                                  3.0), // Moves the shadow slightly down and right
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            //mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Image.asset(
                                'images/report-card.png',
                                width: 70,
                                height: 70,
                                 color:AppColors.white,
                              ),
                              Gap(10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Report",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'UbuntuMedium',
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.white,
                                    ),
                                  ),
                                  Gap(3),
                                  Text(
                                    'Detailed reports on students lunch \nChoices and numbers',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: AppColors.white,
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                ],
                              ),
                              Gap(10),
                              Icon(Icons.arrow_forward,color: AppColors.white,),
                            ],
                          ),
                        ),
                      ),
                      /*Row(
                        children: [
                        *//*  Expanded(
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        GoRouter.of(context).pushReplacementNamed(StudentEntry.route);
                                      },
                                      child: Container(
                                      //  margin: EdgeInsets.only(left: 30),
                                        padding: EdgeInsets.all(22),
                                        child: Image.asset(
                                          'images/entry.png',
                                          // color: MyColor.mail_textarea_color_bg,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppColors.white,
                                          // Container background color
                                          borderRadius: BorderRadius.circular(10.0),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(0.3),
                                              // Shadow color with transparency
                                              spreadRadius: 5.0,
                                              // Adjusts how far the shadow spreads
                                              blurRadius: 7.0,
                                              // Adjusts how blurry the shadow is
                                              offset: Offset(0.0,
                                                  3.0), // Moves the shadow slightly down and right
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 10, left: 30),
                                      child: Text(
                                         "Entry",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'UbuntuMedium',
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                          Gap(28),*//*

                        ],
                      ),*/
                    ],
                  ),
                ),

              ),

            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: AppColors.app_color,

              onPressed: () {
                // Action to perform when the button is pressed
                GoRouter.of(context).pushReplacementNamed(StudentEntry.route);
                print('FAB pressed');
              },
              child: Icon(Icons.add,color: AppColors.white,),
            ),
          );
        },
      ),
    );
  }
}
class ChartData {
  ChartData(this.x, this.y, this.color);
  final String x;
  final double y;
  final Color color;
}