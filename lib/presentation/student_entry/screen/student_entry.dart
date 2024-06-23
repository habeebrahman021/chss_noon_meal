import 'package:flutter/material.dart';
class StudentEntry extends StatelessWidget {
  const StudentEntry({super.key});
  static const String route = '/student';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Count'),
      ),
      body:  Center(
        child: TextField(
          cursorColor: Colors.black,
          style: TextStyle(
              color: Colors.white
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.blueAccent,
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(50)
            ),
          ),
        )
      ),
    );
  }
}
