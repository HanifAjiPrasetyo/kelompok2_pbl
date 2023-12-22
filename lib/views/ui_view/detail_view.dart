import 'package:flutter/material.dart';
import 'package:kelompok2_pbl/views/app_theme.dart';
import 'package:kelompok2_pbl/views/ui_view/form.dart';

class DetailPage extends StatefulWidget {
  final String? imagePath;
  final String? title;
  final String? author;

  const DetailPage({
    super.key,
    required this.imagePath,
    required this.title,
    required this.author,
  });

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late FormWidget formWidgetInstance;

  @override
  void initState() {
    super.initState();
    formWidgetInstance = FormWidget(
      imagePath: widget.imagePath,
      title: widget.title,
      author: widget.author,
    );
  }

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
                  fontFamily: FitnessAppTheme.fontName,
                ),
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
                      height: 120,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      padding: EdgeInsets.all(10),
                      alignment: Alignment.centerLeft,
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Judul Buku : ',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: FitnessAppTheme.fontName,
                                        fontSize: 17,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                      child: Text(
                                        '${widget.title}',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: FitnessAppTheme.fontName,
                                          fontSize: 15,
                                        ),
                                        textAlign: TextAlign.justify,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Penulis : ',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: FitnessAppTheme.fontName,
                                        fontSize: 17,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 50,
                                    ),
                                    Expanded(
                                      child: Text(
                                        '${widget.author}',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: FitnessAppTheme.fontName,
                                          fontSize: 15,
                                        ),
                                        textAlign: TextAlign.justify,
                                      ),
                                    ),
                                  ],
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
                'Data Peminjaman',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: FitnessAppTheme.fontName),
                textAlign: TextAlign.left,
              ),
              formWidgetInstance,
            ],
          ),
        ],
      ),
    );
  }
}
