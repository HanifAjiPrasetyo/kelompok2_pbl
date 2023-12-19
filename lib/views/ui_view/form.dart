import 'package:flutter/material.dart';
import 'package:kelompok2_pbl/views/app_theme.dart';
import 'package:kelompok2_pbl/views/ui_view/rental_list.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FormWidget extends StatefulWidget {
  @override
  _FormWidgetState createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> with TickerProviderStateMixin {
  // Deklarasikan variabel-variabel yang akan menyimpan input pengguna
  String _nim = '';
  String _name = '';
  DateTime _start = DateTime.now();
  DateTime _end = DateTime.now();

  String status = '';
  String? nim = '';
  String? nama = '';

  AnimationController? animationController;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    super.initState();
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
                helperText: 'Isikan NIM Anda sesuai data pada halaman awal',
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
                ),
                helperText: 'Isikan nama Anda sesuai data pada halaman awal',
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

                print("dateTime: $dateTimeStart");
                setState(() {
                  _start = dateTimeStart!;
                });
              },
              child: Container(
                margin: EdgeInsets.only(top: 5),
                alignment: Alignment.centerLeft,
                child: Text(
                  "Tanggal Mulai Pinjam",
                ),
              ),
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

                print("dateTime: $dateTimeEnd");
                setState(() {
                  _end = dateTimeEnd!;
                });
              },
              child: Container(
                margin: EdgeInsets.only(top: 5),
                alignment: Alignment.centerLeft,
                child: Text(
                  "Tanggal Akhir Pinjam",
                ),
              ),
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
                if (_formKey.currentState!.validate()) {
                  // Form valid, lakukan sesuatu dengan data yang diinputkan
                  _submitForm();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Data berhasil disimpan')),
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RentalList(),
                    ),
                  );
                }
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
      ),
    );
  }

  void _submitForm() {
    // Lakukan sesuatu dengan data yang diinputkan, misalnya mengirimkan data ke server
    print('NIM: $_nim');
    print('Name: $_name');
    print('Mulai: $_start');
    print('Akhir: $_end');
  }
}
