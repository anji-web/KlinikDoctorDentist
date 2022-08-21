import 'dart:async';
import 'dart:convert';

import 'package:absensi_project/components/background.dart';
import 'package:absensi_project/components/rounded_button.dart';
import 'package:absensi_project/constans.dart';
import 'package:absensi_project/model/user-model.dart';
import 'package:absensi_project/screens/first_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BodyLogin extends StatefulWidget {
  const BodyLogin({Key? key}) : super(key: key);
  @override
  State<BodyLogin> createState() => _BodyLoginState();
}

class _BodyLoginState extends State<BodyLogin> {
  bool obsText = true;
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();


  Future<User> loginProcess () async {

    var body = {
        "username" : username.text,
        "password" : password.text
    };

    var res = await http.post(
        Uri.parse("http://192.168.0.3:9091/absensi-api/login"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(body)
    );

    var result = jsonDecode(res.body)['data'];
    User user =  User(statusCode: result['statusCode'],
        token: result['token'],
        id: result['id'],
        username: result['username'],
        fullname: result['fullname'],
        nik: result['nik'],
        roles: result['roles']);

    _saveTemp(result['id'], result['nik'], result['fullname']);
    return user;
  }

  _saveTemp(id, nik , fullname) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt("id_user", id);
    prefs.setString("nik", nik);
    prefs.setString("fullname", fullname);
  }

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
              child: TextFormField(
                controller: username,
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
                    labelText: "Username",
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
              child: TextFormField(
                controller: password,
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
              press: () async {
                User user = await loginProcess();
                setState((){
                  if(user.statusCode == 200){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return const FirstPage();})
                    );
                  }else {
                    Fluttertoast.showToast(
                        msg: "username atau password salah",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 3,
                        backgroundColor: Colors.white,
                        textColor: Colors.red,
                        fontSize: 18.0
                    );
                  }
                });
              },
              color: primaryLightColor,
            )
          ],
        )
    );
  }
}
