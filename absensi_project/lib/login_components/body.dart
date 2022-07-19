import 'dart:async';

import 'package:absensi_project/components/background.dart';
import 'package:absensi_project/components/rounded_button.dart';
import 'package:absensi_project/constans.dart';
import 'package:absensi_project/screens/first_page.dart';
import 'package:flutter/material.dart';

class BodyLogin extends StatefulWidget {
  const BodyLogin({Key? key}) : super(key: key);
  @override
  State<BodyLogin> createState() => _BodyLoginState();
}

class _BodyLoginState extends State<BodyLogin> {
  bool obsText = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "LOGIN",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.black
              ) ,
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              width: size.width * 0.8,
              decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(29)
              ),
              child: TextField(
                autofocus: false,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                ),
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.person,
                      size: 30,
                      color: Colors.black,
                    ),
                    labelText: "Username or Email",
                    labelStyle: TextStyle(
                        color: Colors.black
                    )
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
              width: size.width * 0.8,
              decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(29)
              ),
              child: TextField(
                autofocus: false,
                enableInteractiveSelection: true,
                obscureText: obsText,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                ),
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.password,
                      size: 30,
                      color: Colors.black,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.remove_red_eye),
                      onPressed:() {
                          if(obsText){
                            setState(() {
                              obsText = false;
                              Timer(Duration(seconds: 1), (){
                                setState((){
                                  obsText = true;
                                });
                              });
                            });
                          }
                        },
                    ),
                    labelText: "Password",
                    labelStyle: TextStyle(
                        color: Colors.black
                    )
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            RoundedButton(
              text: "Submit",
              press: () => {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return FirstPage();
                    }
                ))
              },
              color: primaryLightColor,
            )
          ],
        )
    );
  }
}
