import 'package:absensi_project/components/background.dart';
import 'package:absensi_project/constans.dart';
import 'package:absensi_project/screens/first_page.dart';
import 'package:absensi_project/screens/form_absen_in.dart';
import 'package:absensi_project/screens/form_absen_out.dart';
import 'package:flutter/material.dart';

class BodyAbsen extends StatelessWidget {
  const BodyAbsen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: size.height * 0.08,),
              Text("Absen", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
              SizedBox(height: size.height * 0.05,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) {
                                return FormAbsenIN();
                              }
                          )
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Ink.image(
                            image: AssetImage("assets/images/fingerprint.png"),
                            width: 120,
                            height: 120,
                            fit: BoxFit.cover,
                        ),
                        SizedBox(height: size.height * 0.02,),
                        Text("Datang", style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold, color: Colors.green),)
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) {
                                return FormAbsenOut();
                              }
                          )
                      );
                    },
                    child: Column(
                      children: <Widget>[
                        Ink.image(
                          image: AssetImage("assets/images/fingerprint.png"),
                          width: 120,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(height: size.height * 0.02,),
                        Text("Keluar", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.redAccent),)
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: size.height * 0.10,),
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30)
                  ),
                  onPressed: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) {
                              return FirstPage();
                            }
                        )
                    );
                  },
                  child: const Text(
                    "Cancel",
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 20
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }
}
