import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final TextEditingController marksController = TextEditingController();
  String grade = "";

  void getGrade() {
    int totalMarks = int.parse(marksController.text);
    if (totalMarks >= 90) {
      setState(() {
        grade = 'A';
      });
    } else if (totalMarks >= 80) {
      setState(() {
        grade = 'B';
      });
    } else if (totalMarks >= 70) {
      setState(() {
        grade = 'C';
      });
    } else if (totalMarks >= 60) {
      setState(() {
        grade = 'D';
      });
    } else {
      setState(() {
        grade = 'F';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset('assets/exams.gif', height: 300, width: 300),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Marks Obtained: ',
                        style: GoogleFonts.comicNeue(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextField(
                          controller: marksController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Enter Marks',
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      getGrade();
                    },
                    child: Text('GET MARKSSS !!'),
                  ),
                  SizedBox(height: 20),
                  Text('Your Grade is $grade'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
