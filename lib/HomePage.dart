import 'package:flutter/material.dart';
import 'NextPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedCPU = '3';
  String selectedGeneration = '2';
  String selectedRAM = '2';
  String selectedHardDiskDrive = 'SSD';
  String selectedHardDiskSize = '256';
  List<String> items = ['HDD', 'SSD'];
  String indexHardDiskDrive = '0';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0, // Remove shadow from app bar
          title: Text(
            'Machine Learning',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          titleSpacing: 0, // هذا يزيل التباعد بين النص والحواف اليمنى واليسرى
          backgroundColor: Color(0xff826df0), //
        ),
        backgroundColor: Colors.blue[100], // Set background color here
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Laptop Price Prediction App',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 25),
                  buildDropdown(
                    value: selectedCPU,
                    items: ['3', '5', '7', '9'],
                    hint: 'Select Corei',
                    icon: Icons.computer,
                    onChanged: (newValue) {
                      setState(() {
                        selectedCPU = newValue!;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  buildDropdown(
                    value: selectedGeneration,
                    items: ['2', '3', '4', '5', '6', '7', '8', '9', '10', '11'],
                    hint: 'Select Generation',
                    icon: Icons.memory,
                    onChanged: (newValue) {
                      setState(() {
                        selectedGeneration = newValue!;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  buildDropdown(
                    value: selectedRAM,
                    items: ['2', '4', '8', '6', '16'],
                    hint: 'Select RAM',
                    icon: Icons.memory,
                    onChanged: (newValue) {
                      setState(() {
                        selectedRAM = newValue!;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  buildDropdown(
                    value: selectedHardDiskDrive,
                    items: items,
                    hint: 'Select HardDiskDrive',
                    icon: Icons.storage,
                    onChanged: (newValue) {
                      setState(() {
                        indexHardDiskDrive =
                            items.indexOf(newValue ?? '').toString();
                        selectedHardDiskDrive = newValue!;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  buildDropdown(
                    value: selectedHardDiskSize,
                    items: ['256', '512', '1024'],
                    hint: 'Select HardDiskSize',
                    icon: Icons.storage,
                    onChanged: (newValue) {
                      setState(() {
                        selectedHardDiskSize = newValue!;
                      });
                    },
                  ),
                  SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NextPage(
                            value1: selectedCPU,
                            value2: selectedGeneration,
                            value3: selectedRAM,
                            value4: selectedHardDiskDrive,
                            value5: selectedHardDiskSize,
                          ),
                        ),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.blue[600]!),
                      elevation: MaterialStateProperty.all<double>(5),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Next Page',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
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
          color: Theme.of(context).primaryColor,
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
                Icon(icon, color: Theme.of(context).primaryColor),
                SizedBox(width: 8),
                Text(
                  '$hint $item',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
        onChanged: onChanged,
        style: TextStyle(color: Colors.black),
        underline: SizedBox.shrink(),
        icon:
            Icon(Icons.arrow_drop_down, color: Theme.of(context).primaryColor),
        isExpanded: true,
      ),
    );
  }
}
