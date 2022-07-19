import 'package:absensi_project/components/background.dart';
import 'package:absensi_project/components/form_text.dart';
import 'package:absensi_project/screens/absen_list.dart';
import 'package:absensi_project/screens/absen_page.dart';
import 'package:absensi_project/screens/login_page.dart';
import 'package:flutter/material.dart';

class BodyFirstPage extends StatelessWidget {
  const BodyFirstPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextEditingController username = TextEditingController();
    return Background(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("SELAMAT DATANG di",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Text("PT JAVA MEDIA INDONESIA",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(
                height: size.height * 0.04,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  InkWell(
                      onTap: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) {
                                  return AbsenPage();
                                }
                            )
                        );
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Ink.image(
                            image: AssetImage("assets/images/fingerprintout.png"),
                            height: 90,
                            width: 90,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          Text("Absen", style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24
                          ),)
                        ],
                      )
                  ),
                  InkWell(
                      onTap: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) {
                                  return AbsenList();
                                }
                            )
                        );
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Ink.image(
                            image: AssetImage("assets/images/list-icon.jpg"),
                            height: 90,
                            width: 90,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          Text("Data Absen", style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20
                          ),)
                        ],
                      )
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.04,
              ),
              // row 2
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  InkWell(
                      splashColor: Colors.black,
                      onTap: (){
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Ink.image(
                            image: AssetImage("assets/images/leave-icon-0.jpg"),
                            height: 90,
                            width: 90,
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          Text("Cuti", style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),)
                        ],
                      )
                  ),
                  InkWell(
                      onTap: (){},
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Ink.image(
                            image: AssetImage("assets/images/sick-leave.jpg"),
                            height: 90,
                            width: 90,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          Text("Izin", style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24
                          ),)
                        ],
                      )
                  ),
                ],
              ),
            ],
          )
        )
    );
  }
}

