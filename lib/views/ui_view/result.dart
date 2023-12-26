import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:kelompok2_pbl/views/app_theme.dart';
import 'package:kelompok2_pbl/views/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResultScreen extends StatefulWidget {
  final String body;

  const ResultScreen({required this.body});

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  late TextEditingController nimController;
  late TextEditingController namaController;
  // late TextEditingController resultController;
  SharedPreferences? sharedPreferences;
  late Map<String, dynamic> parsedBody;

  @override
  void initState() {
    super.initState();
    nimController = TextEditingController();
    namaController = TextEditingController();
    // resultController = TextEditingController();
    parsedBody = jsonDecode(widget.body);
    initSharedPreferences();
  }

  Future<void> initSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
    nimController.text =
        sharedPreferences!.getString('nim') ?? parsedBody['nim'];
    namaController.text =
        sharedPreferences!.getString('nama') ?? parsedBody['nama'];
    // resultController.text =
    //     sharedPreferences!.getString('result') ?? parsedBody['result'];
  }

  @override
  void dispose() {
    nimController.dispose();
    namaController.dispose();
    // resultController.dispose();
    super.dispose();
  }

  Future<void> saveData() async {
    await sharedPreferences!.setString('nim', nimController.text);
    await sharedPreferences!.setString('nama', namaController.text);
    // await sharedPreferences!.setString('result', resultController.text);
    await sharedPreferences!.setBool('ktmValidation', true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Hasil Scan KTM',
          style: TextStyle(
            fontFamily: FitnessAppTheme.fontName,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: Center(
        heightFactor: 1,
        child: Container(
          padding: EdgeInsets.all(30),
          margin: EdgeInsets.only(top: 20),
          width: 360,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: FitnessAppTheme.nearlyDarkBlue,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // TextFormField(
              //   controller: resultController,
              //   decoration: InputDecoration(
              //     labelText: 'Result',
              //     labelStyle: TextStyle(
              //         color: const Color.fromARGB(255, 119, 221, 255)),
              //   ),
              //   keyboardType: TextInputType.number,
              //   style: TextStyle(color: Colors.white),
              // ),
              TextFormField(
                controller: nimController,
                decoration: InputDecoration(
                  labelText: 'NIM',
                  labelStyle: TextStyle(
                      color: const Color.fromARGB(255, 119, 221, 255)),
                ),
                keyboardType: TextInputType.number,
                style: TextStyle(color: Colors.white),
              ),
              TextFormField(
                controller: namaController,
                decoration: InputDecoration(
                  labelText: 'Nama',
                  labelStyle: TextStyle(
                      color: const Color.fromARGB(255, 119, 221, 255)),
                ),
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  saveData();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Data berhasil disimpan')),
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    ),
                  );
                },
                child: Text(
                  'SIMPAN',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: FitnessAppTheme.fontName,
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
