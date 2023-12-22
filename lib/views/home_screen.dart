import 'dart:convert';
import 'dart:io';
import 'package:kelompok2_pbl/views/models/tabIcon_data.dart';
import 'package:flutter/material.dart';
import 'package:kelompok2_pbl/views/ui_view/rental_list.dart';
import 'package:kelompok2_pbl/views/ui_view/result.dart';
import 'bottom_navigation_view/bottom_bar_view.dart';
import 'app_theme.dart';
import 'my_diary/my_diary_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  AnimationController? animationController;

  List<TabIconData> tabIconsList = TabIconData.tabIconsList;

  Widget tabBody = Container(
    color: FitnessAppTheme.background,
  );

  @override
  void initState() {
    tabIconsList.forEach((TabIconData tab) {
      tab.isSelected = false;
    });
    tabIconsList[0].isSelected = true;

    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    tabBody = MyDiaryScreen(animationController: animationController);
    super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: FitnessAppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: FutureBuilder<bool>(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox();
            } else {
              return Stack(
                children: <Widget>[
                  tabBody,
                  bottomBar(),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  Future<void> _showImageSourceDialog() async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Camera'),
                onTap: () async {
                  Navigator.pop(context);
                  File? image = await _pickImage(ImageSource.camera);
                  if (image != null) {
                    await _uploadImage(image);
                  }
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Gallery'),
                onTap: () async {
                  Navigator.pop(context);
                  File? image = await _pickImage(ImageSource.gallery);
                  if (image != null) {
                    await _uploadImage(image);
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<http.Response> uploadImage(File image) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('https://7171-34-125-96-107.ngrok-free.app/api/upload-ktm'),
    );
    request.files.add(await http.MultipartFile.fromPath('file', image.path));

    var response = await request.send();
    if (response.statusCode == 200) {
      return http.Response.fromStream(response);
    } else {
      throw Exception('Error during image upload');
    }
  }

  Future<void> _uploadImage(File image) async {
    try {
      http.Response message = await uploadImage(image);
      String body = message.body;
      final parsedBody = jsonDecode(body);
      print(message);

      if (message.statusCode == 200) {
        // Alihkan ke halaman hasil atau response
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResultScreen(body: body),
          ),
        );
        // Set shared preferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        if (parsedBody['nim'] != 'NIM tidak ditemukan' &&
            parsedBody['nama'] != 'Nama tidak ditemukan') {
          prefs.setBool('ktmValidation', true);
          prefs.setString(
            'nim',
            parsedBody['nim'],
          );
          prefs.setString(
            'nama',
            parsedBody['nama'],
          );
        } else {
          prefs.setBool('ktmValidation', false);
          prefs.setString('nim', '-');
          prefs.setString('nama', '-');
        }
      } else {
        // Tampilkan pesan kesalahan
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Error during image upload'),
              actions: [
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      // Tampilkan pesan kesalahan
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Error during image upload: $e'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  Future<File?> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: source);
    if (pickedImage != null) {
      return File(pickedImage.path);
    }
    return null;
  }

  Widget bottomBar() {
    return Column(
      children: <Widget>[
        const Expanded(
          child: SizedBox(),
        ),
        BottomBarView(
          tabIconsList: tabIconsList,
          addClick: () {
            animationController?.reverse().then<dynamic>((data) {
              if (!mounted) {
                return;
              }
              setState(() {
                _showImageSourceDialog();
              });
            });
          },
          changeIndex: (int index) {
            if (index == 0) {
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody =
                      MyDiaryScreen(animationController: animationController);
                });
              });
            } else if (index == 3) {
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody = RentalList();
                });
              });
            }
          },
        ),
      ],
    );
  }
}
