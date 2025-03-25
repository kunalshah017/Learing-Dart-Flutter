import 'dart:developer';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Home());
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _formkey = GlobalKey<FormState>();
  bool isTermsConditionsAccepted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Form Validator')),
      body: SafeArea(
        child: Form(
          key: _formkey,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      label: Text('First Name'),
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    decoration: InputDecoration(
                      label: Text('Last Name'),
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 8),
                  CheckboxListTile(
                    title: Text('I agree to terms & conditions'),
                    value: isTermsConditionsAccepted,
                    onChanged: (bool? value) {
                      log(value.toString());
                      setState(() {
                        isTermsConditionsAccepted = value ?? false;
                      });
                    },
                  ),
                  SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      isTermsConditionsAccepted
                          ? {
                            if (_formkey.currentState!.validate())
                              {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Submitting')),
                                ),
                              },
                          }
                          : {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Please accept Terms & Conditions',
                                ),
                              ),
                            ),
                          };
                    },
                    child: Text('Submit'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
