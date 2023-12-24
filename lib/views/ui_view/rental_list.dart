import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:kelompok2_pbl/views/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

// ...

class RentalList extends StatefulWidget {
  @override
  _RentalListState createState() => _RentalListState();
}

class _RentalListState extends State<RentalList> {
  List<Map<String, dynamic>> rentalData = [];

  @override
  void initState() {
    super.initState();
    initializeDateFormatting(
        'id_ID', null); // Menginisialisasi format tanggal bahasa Indonesia
    _loadRentalData();
  }

  Future<void> _loadRentalData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? jsonData = prefs.getStringList('formData');

    if (jsonData != null) {
      List<Map<String, dynamic>> dataList = [];
      for (String jsonStr in jsonData) {
        Map<String, dynamic> data = jsonDecode(jsonStr);
        dataList.add(data);
      }

      setState(() {
        rentalData = dataList;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final DateFormat dateFormat =
        DateFormat.yMMMMd('id_ID').add_Hm(); // Format tanggal bahasa Indonesia
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Riwayat Peminjaman',
          style: TextStyle(
            fontFamily: FitnessAppTheme.fontName,
            fontSize: 20,
          ),
        ),
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(15),
        itemCount: rentalData.length,
        itemBuilder: (context, index) {
          Map<String, dynamic> rentalItem = rentalData[index];
          DateTime startDate = DateTime.parse(rentalItem['mulai']);
          DateTime endDate = DateTime.parse(rentalItem['akhir']);
          return Container(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 39, 47, 135),
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              contentPadding: EdgeInsets.all(15),
              textColor: Colors.white,
              // tileColor: FitnessAppTheme.nearlyDarkBlue,
              title: Text(
                rentalItem['title'],
                style: TextStyle(
                  fontFamily: FitnessAppTheme.fontName,
                  fontWeight: FontWeight.w500,
                ),
              ),
              subtitle: Text(
                '${rentalItem['author']}\nMulai Pinjam : ${dateFormat.format(startDate)}\nAkhir Pinjam : ${dateFormat.format(endDate)}\n\nPeminjam : ${rentalItem['name']}',
                style: TextStyle(fontFamily: FitnessAppTheme.fontName),
              ),
              leading: Image(
                image: AssetImage(rentalItem['imagePath']),
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => SizedBox(height: 14),
      ),
    );
  }
}
