import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart'; // Import the intl package

// PA System Options
enum PaSystemOption { yes, no }

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Event Hall Package Booking',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.amber, secondary: Colors.amberAccent),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Event Hall Package Booking'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // BELOW FOR DATE ONLY
  DateTime? _selectedDate;

  void _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  // BELOW FOR TIME ONLY YA
  // THIS ONE NO DEFAULT VALUE, JUST NULL
  TimeOfDay? _selectedTime;

  void _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );

    if (pickedTime != null && pickedTime != _selectedTime) {
      setState(() {
        _selectedTime = pickedTime;
      });
    }
  }

  // BELOW FOR PA SYSTEM
  PaSystemOption? _paSystemOption = PaSystemOption.no; // Default to 'no'

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text(widget.title),
      ),
      body: Align(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          // Wrap with SingleChildScrollView for scrollable content
          child: Container(
            margin: const EdgeInsets.only(top: 50.0, bottom: 50.0),
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // USERNAME FIELD
                  Container(
                    margin: const EdgeInsets.only(bottom: 8.0),
                    child: const TextField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter your username',
                      ),
                    ),
                  ),

                  // EMAIL FIELD
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: const TextField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter your email',
                      ),
                    ),
                  ),

                  // PHONE NUMBER FIELD
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: const TextField(
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter your phone number',
                      ),
                    ),
                  ),

                  // NUMBER OF PEOPLE IN HALL FIELD
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: const TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Amount of people in hall',
                      ),
                    ),
                  ),

                  // PASSWORD FIELD
                  Container(
                    margin: const EdgeInsets.only(top: 8.0),
                    child: const TextField(
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter your password',
                      ),
                    ),
                  ),

                  // DATE AND TIME CONTAINER
                  Container(
                    margin: const EdgeInsets.only(bottom: 8.0, top: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment
                          .spaceEvenly, // This will space out the children evenly
                      children: <Widget>[
                        // WIDGET 1 - DATE
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => _selectDate(context),
                            child: const Text('Select Date'),
                          ),
                        ),
                        const SizedBox(
                            width:
                                8.0), // This will provide spacing between the buttons

                        // WIDGET 2 - TIME
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => _selectTime(context),
                            child: const Text('Select Time'),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // DATE TEXT
                  Text(_selectedDate != null
                      ? 'Selected Date: ${DateFormat('dd/MM/yyyy').format(_selectedDate!.toLocal())}'
                      : 'No date selected'),

                  // TIME TEXT
                  Text(_selectedTime != null
                      ? 'Selected Time: ${_selectedTime!.format(context)}'
                      : 'No time selected'),

                  // PA SYSTEM
                  Column(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(top: 20.0),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'PA System Included',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          // YES OPTION
                          Expanded(
                            child: ListTile(
                              title: const Text('YES'),
                              leading: Radio<PaSystemOption>(
                                value: PaSystemOption.yes,
                                groupValue: _paSystemOption,
                                onChanged: (PaSystemOption? value) {
                                  setState(() {
                                    _paSystemOption = value;
                                  });
                                },
                              ),
                            ),
                          ),

                          // NO OPTION
                          Expanded(
                            child: ListTile(
                              title: const Text('NO'),
                              leading: Radio<PaSystemOption>(
                                value: PaSystemOption.no,
                                groupValue: _paSystemOption,
                                onChanged: (PaSystemOption? value) {
                                  setState(() {
                                    _paSystemOption = value;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
