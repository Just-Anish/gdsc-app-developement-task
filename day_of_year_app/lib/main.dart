import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Day of Year App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  final _dayController = TextEditingController();
  final _yearController = TextEditingController();

  String _dateResult = '';
  String _weekResult = '';
  String _leapYearResult = '';

  @override
  void dispose() {
    _dayController.dispose();
    _yearController.dispose();
    super.dispose();
  }

  void _calculate() {
    if (_formKey.currentState!.validate()) {
      final int day = int.parse(_dayController.text);
      final int year = int.parse(_yearController.text);

      DateTime date = DateTime(year).add(Duration(days: day - 1));
      DateFormat dateFormat = DateFormat('dd/MM/yyyy');
      int weekOfYear = int.parse(DateFormat('w').format(date));

      bool isLeapYear = (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);

      setState(() {
        _dateResult = dateFormat.format(date);
        _weekResult = weekOfYear.toString();
        _leapYearResult = isLeapYear.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Day of Year App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _dayController,
                decoration: InputDecoration(labelText: 'Day of the Year'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the day of the year';
                  }
                  final int day = int.parse(value);
                  if (day < 1 || day > 366) {
                    return 'Please enter a valid day of the year';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _yearController,
                decoration: InputDecoration(labelText: 'Year'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the year';
                  }
                  final int year = int.parse(value);
                  if (year < 1) {
                    return 'Please enter a valid year';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _calculate,
                child: Text('Calculate'),
              ),
              SizedBox(height: 20),
              Text('Date: $_dateResult'),
              Text('Week of the Year: $_weekResult'),
              Text('Leap Year: $_leapYearResult'),
            ],
          ),
        ),
      ),
    );
  }
}
