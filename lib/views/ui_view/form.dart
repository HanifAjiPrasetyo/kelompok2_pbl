import 'package:flutter/material.dart';
import 'package:kelompok2_pbl/views/app_theme.dart';

class FormWidget extends StatefulWidget {
  @override
  _FormWidgetState createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  // Deklarasikan variabel-variabel yang akan menyimpan input pengguna
  String _nim = '';
  String _name = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(30, 0, 30, 20),
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
              labelText: 'NIM',
              labelStyle: TextStyle(
                fontFamily: FitnessAppTheme.fontName,
                fontWeight: FontWeight.bold,
              ),
              helperText: 'Isikan NIM Anda',
            ),
            onChanged: (value) {
              setState(() {
                _nim = value;
              });
            },
          ),
          SizedBox(height: 16.0),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Nama',
              labelStyle: TextStyle(
                fontFamily: FitnessAppTheme.fontName,
                fontWeight: FontWeight.bold,
              ),
              helperText: 'Isikan nama Anda',
            ),
            onChanged: (value) {
              setState(() {
                _name = value;
              });
            },
          ),
          SizedBox(height: 16.0),
          // Tambahkan tombol untuk submit form
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(
                FitnessAppTheme.nearlyDarkBlue,
              ),
            ),
            onPressed: () {
              // Lakukan sesuatu dengan data yang diinputkan
              _submitForm();
            },
            child: Text(
              'Pinjam',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: FitnessAppTheme.fontName,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _submitForm() {
    // Lakukan sesuatu dengan data yang diinputkan, misalnya mengirimkan data ke server
    print('NIM: $_nim');
    print('Name: $_name');
  }
}
