import 'package:flutter/material.dart';
import 'package:kelompok2_pbl/views/ui_view/formError.dart';
import 'package:kelompok2_pbl/views/ui_view/rounded_button.dart';
import 'package:kelompok2_pbl/views/constants.dart';
import 'package:kelompok2_pbl/views/home_screen.dart';
import 'package:iconsax/iconsax.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height,
          maxWidth: MediaQuery.of(context).size.width,
        ),
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [
            Colors.blue.shade800,
            Colors.blue.shade600,
          ],
          begin: Alignment.topLeft,
          end: Alignment.centerRight,
        )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 50, horizontal: 24),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 24.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        "Login to Enter Homepage",
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ]),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: LoginForm(),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  late String email;
  late String password;
  final List<String> errors = [];

  void _login() async {
    if (email.isNotEmpty && password.isNotEmpty) {
      // res = await APIService.signIn(email, password);
      // if (res.success == true) {
      //   // snackbar
      //   final snackBar = SnackBar(
      //     content: Text(
      //       "Login Success!",
      //       style: TextStyle(color: kPrimaryColor),
      //     ),
      //     backgroundColor: kSecondaryLightColor,
      //     duration: Duration(seconds: 4),
      //     elevation: 6.0,
      //     behavior: SnackBarBehavior.floating,
      //   );
      //   ScaffoldMessenger.of(context).showSnackBar(snackBar);

      //   Navigator.push(context, MaterialPageRoute(builder: (context) {
      //     return HomeScreen();
      //   }));

      if (email == 'hanif@gmail.com' && password == 'password') {
        final snackBar = SnackBar(
          content: Text(
            "Login Success!",
            style: TextStyle(color: kPrimaryColor),
          ),
          backgroundColor: kSecondaryLightColor,
          duration: Duration(seconds: 4),
          elevation: 6.0,
          behavior: SnackBarBehavior.floating,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return HomeScreen();
        }));
      } else {
        // snackbar
        final snackBar = SnackBar(
          // content: Text(res.message),
          content: Text('Email / Password Salah'),
          backgroundColor: kPrimaryColor,
          duration: Duration(seconds: 4),
          elevation: 6.0,
          behavior: SnackBarBehavior.floating,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              onSaved: (newValue) => email = newValue.toString(),
              onChanged: (value) {
                if (value.isNotEmpty && errors.contains(kEmailNullError)) {
                  setState(() {
                    errors.remove(kEmailNullError);
                  });
                } else if (emailValidatorRegExp.hasMatch(value) &&
                    errors.contains(kInvalidEmailError)) {
                  setState(() {
                    errors.remove(kInvalidEmailError);
                  });
                }
                return null;
              },
              validator: (value) {
                if (value!.isEmpty && !errors.contains(kEmailNullError)) {
                  setState(() {
                    errors.add(kEmailNullError);
                  });
                } else if (!emailValidatorRegExp.hasMatch(value.toString()) &&
                    !errors.contains(kInvalidEmailError) &&
                    !errors.contains(kEmailNullError)) {
                  setState(() {
                    errors.add(kInvalidEmailError);
                  });
                }
                return null;
              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Color(0xFFe7edeb),
                  hintText: "Email",
                  prefixIcon: Icon(
                    Icons.mail_outline_rounded,
                    color: Colors.grey[600],
                  )),
            ),
            SizedBox(
              height: 25.0,
            ),
            TextFormField(
              obscureText: true,
              onSaved: (newValue) => password = newValue.toString(),
              onChanged: (value) {
                if (value.isNotEmpty && errors.contains(kPassNullError)) {
                  setState(() {
                    errors.remove(kPassNullError);
                  });
                }
                return null;
              },
              validator: (value) {
                if (value!.isEmpty && !errors.contains(kPassNullError)) {
                  setState(() {
                    errors.add(kPassNullError);
                  });
                }
                return null;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Color(0xFFe7edeb),
                hintText: "Password",
                prefixIcon: Icon(
                  Iconsax.lock,
                  color: Colors.grey[600],
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(child: FormError(errors: errors)),
            SizedBox(
              height: 15.0,
            ),
            RoundedButton(
              text: "Login",
              color: kPrimaryColor,
              press: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  _login();
                }
              },
            ),
            // SizedBox(
            //   height: 10.0,
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.start,
            //   children: [
            //     Text(
            //       "Don't have an account? ",
            //       style: TextStyle(
            //         fontWeight: FontWeight.w500,
            //       ),
            //     ),
            //     GestureDetector(
            //       onTap: () {
            //         Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //             builder: (context) {
            //               return SignupScreen();
            //             },
            //           ),
            //         );
            //       },
            //       child: Text(
            //         "Sign up",
            //         style: TextStyle(
            //             color: kPrimaryColor, fontWeight: FontWeight.w500),
            //       ),
            //     ),
            //   ],
            // ),
            // SizedBox(
            //   height: 10.0,
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.start,
            //   children: [
            //     GestureDetector(
            //       onTap: () {},
            //       child: Text(
            //         "Forgot your Password",
            //         style: TextStyle(
            //             color: kPrimaryColor, fontWeight: FontWeight.w500),
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
