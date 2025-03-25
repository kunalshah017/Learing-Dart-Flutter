import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smallest_of_two_with_feild_validator/pages/weatherPage.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int selectedIndex = 0;
  List<Widget> screen = [Home(), Gesture(), APIPage()];
  List<String> titles = ["Greatest or Smallest", "Gesture DE", "APIs"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(titles[selectedIndex])),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (int tapIndex) {
          setState(() {
            selectedIndex = tapIndex;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'G&S'),
          BottomNavigationBarItem(
            icon: Icon(Icons.gesture),
            label: 'Gesture DE',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.network_ping),
            label: 'APIs',
          ),
        ],
      ),
      body: SafeArea(child: screen[selectedIndex]),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNumberController = TextEditingController();
  final TextEditingController _secondNumberController = TextEditingController();

  bool isTermsAndConditionsAccepted = false;
  String selectedValue = 'greatest';
  int? answer;

  void findSmallest() {
    double firstNumber = double.parse(_firstNumberController.text);
    double secondNumber = double.parse(_secondNumberController.text);

    if (selectedValue == 'smallest') {
      if (firstNumber < secondNumber) {
        setState(() {
          answer = firstNumber.toInt();
        });
      } else {
        setState(() {
          answer = secondNumber.toInt();
        });
      }
    }

    if (selectedValue == 'greatest') {
      if (firstNumber > secondNumber) {
        setState(() {
          answer = firstNumber.toInt();
        });
      } else {
        setState(() {
          answer = secondNumber.toInt();
        });
      }
    }
  }

  void clear() {
    setState(() {
      _firstNumberController.text = '';
      _secondNumberController.text = '';
      isTermsAndConditionsAccepted = false;
      answer = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _firstNumberController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  label: Text('First Number'),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: _secondNumberController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  label: Text('Second Number'),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 18),
              DropdownButton(
                onChanged: (value) {
                  setState(() {
                    if (value != null) {
                      selectedValue = value;
                    }
                  });
                },
                value: selectedValue,
                items: [
                  DropdownMenuItem(child: Text('Greatest'), value: 'greatest'),
                  DropdownMenuItem(child: Text('Smallest'), value: 'smallest'),
                ],
              ),
              CheckboxListTile(
                title: Text(
                  'Accept T&C to find Smallest Number :)',
                  style: TextStyle(fontSize: 15),
                ),
                value: isTermsAndConditionsAccepted,
                onChanged: (bool? value) {
                  setState(() {
                    isTermsAndConditionsAccepted = value ?? false;
                  });
                },
              ),
              SizedBox(height: 18),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      isTermsAndConditionsAccepted
                          ? {
                            if (_formKey.currentState!.validate())
                              {findSmallest()},
                          }
                          : {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Accept T&C Please :)')),
                            ),
                          };
                    },
                    child: Text('Find'),
                  ),
                  SizedBox(width: 18),
                  ElevatedButton(onPressed: clear, child: Text('Clear')),
                ],
              ),
              SizedBox(height: 18),
              Container(
                child: AnimatedOpacity(
                  opacity: answer != null ? 1.0 : 0.0,
                  duration: Duration(milliseconds: 300),
                  child: Text(
                    answer != null ? answer.toString() : '',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Gesture extends StatefulWidget {
  const Gesture({super.key});

  @override
  State<Gesture> createState() => _GestureState();
}

class _GestureState extends State<Gesture> {
  var currentIndex = 0;

  final List<Color> colors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
    Colors.pink,
    Colors.purple,
    Colors.orange,
    Colors.black,
    Colors.white,
  ];

  void onTapChange() {
    setState(() {
      if (currentIndex == colors.length - 1) {
        currentIndex = 0;
      } else {
        currentIndex++;
      }
    });
  }

  void onDoubleTapChange() {
    setState(() {
      if (currentIndex != 7) {
        currentIndex = 7;
      } else {
        currentIndex = 8;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTapChange,
        onDoubleTap: onDoubleTapChange,
        child: Container(
          decoration: BoxDecoration(color: colors[currentIndex]),
        ),
      ),
    );
  }
}

class APIPage extends StatefulWidget {
  const APIPage({super.key});

  @override
  State<APIPage> createState() => _APIPageState();
}

class _APIPageState extends State<APIPage> {
  final LatLng _center = LatLng(48.8584, 2.2945);

  var _googleMapController;

  void onMapRender(controller) {
    _googleMapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: GoogleMap(
                  onMapCreated: (controller) => onMapRender(controller),
                  initialCameraPosition: CameraPosition(
                    target: _center,
                    zoom: 17,
                  ),
                  mapType: MapType.satellite,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          left: 16,
          bottom: 30,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WeatherPage()),
              );
            },
            child: Icon(Icons.cloud),
          ),
        ),
      ],
    );
  }
}
