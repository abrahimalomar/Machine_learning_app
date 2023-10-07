import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NextPage extends StatefulWidget {
  final String value1;
  final String value2;
  final String value3;
  final String value4;
  final String value5;

  NextPage({
    required this.value1,
    required this.value2,
    required this.value3,
    required this.value4,
    required this.value5,
  });

  @override
  State<NextPage> createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  String screenSizes = '14';
  String selectedScreenSize = '14';
  String resolutions = 'QHD';
  String selectedResolution = 'QHD';
  String indexResolution = '0';
  List<String> items = ['Full HD', 'QHD'];

  double yValue = 0;
  String graphicsCardType = 'Core I3';
  String screenSize = '2';

  int graphicsCardTypeIndex = 0;
  int screenSizeIndex = 0;

  double sum = 0.0;

  Future<void> fetchData() async {
    double v1 = double.tryParse(widget.value1.toString()) ?? 0.0;
    double v2 = double.tryParse(widget.value2.toString()) ?? 0.0;
    double v3 = double.tryParse(widget.value3.toString()) ?? 0.0;
    double v4 = double.tryParse(widget.value4.toString()) ?? 0.0;
    double v5 = double.tryParse(widget.value5.toString()) ?? 0.0;

    final response = await http.get(
      Uri.parse(
          "http://127.0.0.1:8000/getsum/$v1/$v2/$v3/$v4/$v5/$selectedScreenSize/$indexResolution"),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      double calculatedSum = data['s'][0];

      setState(() {
        sum = calculatedSum;
      });

      // Show the sum in a custom-styled pop-up dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Result', style: TextStyle(color: Colors.blue)),
            content: Text('Prediction Price: \$${sum.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 18)),
            actions: <Widget>[
              TextButton(
                child: Text('OK', style: TextStyle(color: Colors.blue)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
            backgroundColor: Colors.white, // Change the pop-up background color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
          );
        },
      );
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Second Page'),
      ),
      backgroundColor: Colors.blue[100], // Set background color here
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            buildDropdown(
              value: screenSizes,
              items: ['11.6', '14', '15.6', '17.3'],
              hint: 'Screen Size',
              icon: Icons.computer,
              onChanged: (newValue) {
                setState(() {
                  screenSizes = newValue!;
                });
              },
            ),
            SizedBox(height: 20),
            buildDropdown(
              value: resolutions,
              items: items,
              hint: 'Select Resolution',
              icon: Icons.desktop_windows,
              onChanged: (newValue) {
                setState(() {
                  selectedResolution = newValue ?? '';
                  indexResolution = items.indexOf(newValue ?? '').toString();
                });
              },
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () async {
                await fetchData();
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.blue[600], // Set button background color here
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: Icon(Icons.send),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget buildDropdown({
    required String value,
    required List<String> items,
    required String hint,
    required IconData icon,
    required Function(String?) onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: Colors.blue,
          width: 2.0,
        ),
      ),
      child: DropdownButton<String>(
        value: value,
        items: items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Row(
              children: [
                Icon(icon),
                SizedBox(width: 8),
                Text('$hint $item'),
              ],
            ),
          );
        }).toList(),
        onChanged: onChanged,
        style: TextStyle(color: Colors.black),
        underline: SizedBox.shrink(),
        icon: Icon(Icons.arrow_drop_down, color: Colors.blue),
        isExpanded: true,
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: NextPage(
      value1: '3',
      value2: '2',
      value3: '2',
      value4: 'SSD',
      value5: '256',
    ),
  ));
}
