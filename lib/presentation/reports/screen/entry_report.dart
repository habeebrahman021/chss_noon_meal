import 'package:flutter/material.dart';
class EntryReport extends StatefulWidget {
  const EntryReport({super.key});

  @override
  State<EntryReport> createState() => EntryReportState();
}

class EntryReportState extends State<EntryReport> {

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class StudentReport {
  StudentReport(this.date, this.standard, this.division, this.boys,this.girls);
  final String date;
  final String standard;
  final String division;
  final String boys;
  final String girls;
}