import 'package:flutter/material.dart';
import 'package:kelompok2_pbl/views/app_theme.dart';
import 'package:kelompok2_pbl/views/ui_view/form.dart';

class DetailPage extends StatefulWidget {
  final String? imagePath;
  final String? title;
  final String? author;

  const DetailPage(
      {super.key,
      required this.imagePath,
      required this.title,
      required this.author});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
            ),
            style: ButtonStyle(
              alignment: Alignment.centerLeft,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Detail Buku',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: FitnessAppTheme.fontName),
                textAlign: TextAlign.left,
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                padding: EdgeInsets.all(15),
                margin: EdgeInsets.only(bottom: 25),
                width: 360,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: FitnessAppTheme.nearlyDarkBlue,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      widget.imagePath!,
                      height: 150,
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Container(
                            child: Column(
                              children: [
                                Text(
                                  'Judul Buku',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: FitnessAppTheme.fontName,
                                    fontSize: 17,
                                  ),
                                ),
                                Text(
                                  '\t\t${widget.title}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: FitnessAppTheme.fontName,
                                    fontSize: 15,
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  'Penulis',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: FitnessAppTheme.fontName,
                                    fontSize: 17,
                                  ),
                                ),
                                Text(
                                  '\t\t${widget.author}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: FitnessAppTheme.fontName,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                'Data Anda',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: FitnessAppTheme.fontName),
                textAlign: TextAlign.left,
              ),
              FormWidget(),
            ],
          ),
        ],
      ),
    );
  }
}
