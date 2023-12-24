import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:kelompok2_pbl/views/app_theme.dart';
import 'package:kelompok2_pbl/views/ui_view/rental_list.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FormWidget extends StatefulWidget {
  final String? imagePath;
  final String? title;
  final String? author;

  const FormWidget({
    super.key,
    required this.imagePath,
    required this.title,
    required this.author,
  });

  @override
  _FormWidgetState createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> with TickerProviderStateMixin {
  // Deklarasikan variabel-variabel yang akan menyimpan input pengguna
  String _nim = '';
  String _name = '';
  DateTime? _start = DateTime.now();
  DateTime? _end = DateTime.now();

  String status = '';
  String? nim = '';
  String? nama = '';

  AnimationController? animationController;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    super.initState();
    initializeDateFormatting('id_ID', null);
    getStatus();
    getNIM();
    getNama();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  Future<void> getStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? ktmValidation = prefs.getBool('ktmValidation');

    setState(() {
      if (ktmValidation != null && ktmValidation) {
        status = 'Valid';
      } else if (ktmValidation == false) {
        status = 'Belum Valid';
      }
    });
  }

  Future<void> getNIM() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedNIM = prefs.getString('nim');

    setState(() {
      nim = storedNIM;
    });
  }

  Future<void> getNama() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedNama = prefs.getString('nama');

    setState(() {
      nama = storedNama;
    });
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
          color: FitnessAppTheme.nearlyDarkBlue,
        ),
        padding: EdgeInsets.fromLTRB(30, 10, 30, 20),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: 'NIM',
                labelStyle: TextStyle(
                  fontFamily: FitnessAppTheme.fontName,
                  fontWeight: FontWeight.bold,
                  color: FitnessAppTheme.nearlyBlue,
                ),
                helperText: 'Isikan NIM Anda sesuai data pada halaman awal',
                helperStyle: TextStyle(
                  color: const Color.fromARGB(255, 98, 215, 254),
                ),
              ),
              style: TextStyle(
                color: Colors.white,
              ),
              validator: (value) {
                if (value != nim) {
                  return 'NIM tidak valid';
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  _nim = value;
                });
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Nama',
                labelStyle: TextStyle(
                  fontFamily: FitnessAppTheme.fontName,
                  fontWeight: FontWeight.bold,
                  color: FitnessAppTheme.nearlyBlue,
                ),
                helperText: 'Isikan nama Anda sesuai data pada halaman awal',
                helperStyle: TextStyle(
                  color: const Color.fromARGB(255, 98, 215, 254),
                ),
              ),
              style: TextStyle(
                color: Colors.white,
              ),
              validator: (value) {
                if (value != nama) {
                  return 'Nama tidak valid';
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  _name = value;
                });
              },
            ),
            TextButton(
              onPressed: () async {
                DateTime? dateTimeStart = await showOmniDateTimePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate:
                      DateTime(1600).subtract(const Duration(days: 3652)),
                  lastDate: DateTime.now().add(
                    const Duration(days: 3652),
                  ),
                  is24HourMode: false,
                  isShowSeconds: false,
                  minutesInterval: 1,
                  secondsInterval: 1,
                  isForce2Digits: true,
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                  constraints: const BoxConstraints(
                    maxWidth: 350,
                    maxHeight: 650,
                  ),
                  transitionBuilder: (context, anim1, anim2, child) {
                    return FadeTransition(
                      opacity: anim1.drive(
                        Tween(
                          begin: 0,
                          end: 1,
                        ),
                      ),
                      child: child,
                    );
                  },
                  transitionDuration: const Duration(milliseconds: 200),
                  barrierDismissible: true,
                );

                setState(() {
                  _start = dateTimeStart;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: FitnessAppTheme.nearlyBlue,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.all(12),
                width: 250,
                margin: EdgeInsets.only(top: 5),
                child: Text(
                  "Tanggal Mulai Pinjam",
                  style: TextStyle(
                    fontFamily: FitnessAppTheme.fontName,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Text(
              _start != null
                  ? '${DateFormat('EEEE, d MMMM yyyy HH:mm', 'id_ID').format(_start!)}'
                  : 'Pilih Tanggal Mulai Pinjam',
              style: TextStyle(
                fontFamily: FitnessAppTheme.fontName,
                color: Colors.white,
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
            TextButton(
              onPressed: () async {
                DateTime? dateTimeEnd = await showOmniDateTimePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate:
                      DateTime(1600).subtract(const Duration(days: 3652)),
                  lastDate: DateTime.now().add(
                    const Duration(days: 3652),
                  ),
                  is24HourMode: false,
                  isShowSeconds: false,
                  minutesInterval: 1,
                  secondsInterval: 1,
                  isForce2Digits: true,
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                  constraints: const BoxConstraints(
                    maxWidth: 350,
                    maxHeight: 650,
                  ),
                  transitionBuilder: (context, anim1, anim2, child) {
                    return FadeTransition(
                      opacity: anim1.drive(
                        Tween(
                          begin: 0,
                          end: 1,
                        ),
                      ),
                      child: child,
                    );
                  },
                  transitionDuration: const Duration(milliseconds: 200),
                  barrierDismissible: true,
                );

                setState(() {
                  _end = dateTimeEnd;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: FitnessAppTheme.nearlyBlue,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.all(12),
                width: 250,
                margin: EdgeInsets.only(top: 5),
                child: Text(
                  "Tanggal Akhir Pinjam",
                  style: TextStyle(
                    fontFamily: FitnessAppTheme.fontName,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Text(
              _end != null
                  ? '${DateFormat('EEEE, d MMMM yyyy HH:mm', 'id_ID').format(_end!)}'
                  : 'Pilih Tanggal Akhir Pinjam',
              style: TextStyle(
                  fontFamily: FitnessAppTheme.fontName,
                  color: Colors.white,
                  fontSize: 12),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.0),
            // Tambahkan tombol untuk submit form
            TextButton(
              onPressed: () {
                // Lakukan sesuatu dengan data yang diinputkan
                if (_formKey.currentState!.validate()) {
                  // Form valid, lakukan sesuatu dengan data yang diinputkan
                  _submitForm();
                }
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: FitnessAppTheme.darkerText,
                ),
                child: Text(
                  'Pinjam',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: FitnessAppTheme.fontName,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _submitForm() async {
    // Lakukan sesuatu dengan data yang diinputkan, misalnya mengirimkan data ke server
    print('NIM: $_nim');
    print('Name: $_name');
    print('Mulai: $_start');
    print('Akhir: $_end');

    print('Image Path: ${widget.imagePath}');
    print('Title: ${widget.title}');
    print('Author: ${widget.author}');

    // Buat objek Map yang mewakili data form
    Map<String, dynamic> formData = {
      'nim': _nim,
      'name': _name,
      'mulai': _start.toString(),
      'akhir': _end.toString(),
      'imagePath': widget.imagePath,
      'title': widget.title,
      'author': widget.author,
    };

    // Ambil instance SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Ambil data yang sudah ada dari SharedPreferences
    List<String>? existingData = prefs.getStringList('formData');

    // Buat list baru atau tambahkan ke list yang sudah ada
    List<String> updatedData = existingData ?? [];
    updatedData.add(jsonEncode(formData));

    // Simpan data ke SharedPreferences
    prefs.setStringList('formData', updatedData);

    // Tampilkan snackbar atau pesan sukses lainnya
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Buku berhasil dipinjam')),
    );

    // Navigasi ke halaman RentalList
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RentalList(),
      ),
    );
  }
}
