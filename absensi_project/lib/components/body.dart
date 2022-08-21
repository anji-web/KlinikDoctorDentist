import 'package:absensi_project/constans.dart';
import 'package:absensi_project/screens/login_page.dart';
import 'package:absensi_project/screens/register.dart';
import 'package:flutter/material.dart';
import 'package:absensi_project/components/rounded_button.dart';

import 'background.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: size.height * 0.07,
            ),
            Text(
              "Selamat datang di",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25
              ),
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            Text(
              "KLINIK DOCTOR DENTIST",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(
              height: size.height * 0.09,
            ),
            RoundedButton(
              text: "Login",
              press: () => {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) {
                          return LoginPage();
                        }
                    )
                )
              },
              color: primaryLightColor,
              textColor: Colors.black,
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            RoundedButton(
                text: "Register",
                press: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) {
                            return RegisterPage();
                          }
                      )
                  )
                }
            )
          ],
        ),
      )
    );
  }
}


