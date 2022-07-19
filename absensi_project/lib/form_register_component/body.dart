import 'dart:convert';

import 'package:absensi_project/components/form_text.dart';
import 'package:absensi_project/components/rounded_button.dart';
import 'package:absensi_project/screens/absen_page.dart';
import 'package:absensi_project/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;


class BodyRegister extends StatefulWidget {
  const BodyRegister({Key? key}) : super(key: key);

  @override
  State<BodyRegister> createState() => _FormState();
}

class _FormState extends State<BodyRegister> {
  TextEditingController nik = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController fullname = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool emptyField = false;
  final formKey = GlobalKey<FormState>();

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('User Berhasil Terdaftar'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Silahkan login terlebih dahulu')
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context) {return HomePage();})
                );
              },
            ),
          ],
        );
      },
    );
  }


  Future<int> addUser() async{
    // var url = "localhost:9091/absensi-api/add-user";
    // Uri uri = Uri.http("localhost:9091", "/absensi-api/add-user");
    var body = {
      "nik" : nik.text,
      "fullname": fullname.text,
      "username": username.text,
      "email": email.value.text,
      "phoneNumber" : phoneNumber.text,
      "address" : address.text,
      "password": password.text
    };
    var res = await http.post(Uri.parse("http://10.0.2.2:9091/absensi-api/add-user"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body:jsonEncode(body));
    var result = jsonDecode(res.body);
    int statusCode = result["statusCode"];
    return statusCode;
  }

  void processAddUser() async{
    int result = await addUser();
    setState(() => {
      if (result == 201){
        _showMyDialog()
      }else {
        Fluttertoast.showToast(
            msg: "User Sudah terdaftar",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.white,
            textColor: Colors.red,
            fontSize: 18.0
        )
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 27, vertical: 5),
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Register",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: size.height * 0.03,),
              TextFormField(
                  controller: nik,
                  validator: (value){
                    if(value == null || value == ""){
                      return "NIK tidak boleh kosong";
                    }else {
                      return null;
                    }
                  },
                  decoration: const InputDecoration(
                      labelText: "NIK",
                      border:  OutlineInputBorder(),
                      labelStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold
                      )
                  ),
                  onChanged: (value) {
                    if (value == ""){
                      setState(() => emptyField = true);
                    }else {
                      setState(() => emptyField = false);
                    }
                  }
              ),
              SizedBox(height: size.height * 0.02,),
              TextFormField(
                  controller: username,
                  validator: (value){
                    if(value == null || value == ""){
                      return "Username tidak boleh kosong";
                    }else {
                      return null;
                    }
                  },
                  decoration: const InputDecoration(
                      labelText: "Username",
                      border:  OutlineInputBorder(),
                      labelStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold
                      )
                  ),
                  onChanged: (value) {
                    if (value == ""){
                      setState(() => emptyField = true);
                    }else {
                      setState(() => emptyField = false);
                    }
                  }
              ),
              SizedBox(height: size.height * 0.02,),
              TextFormField(
                  controller: fullname,
                  validator: (value){
                    if(value == null || value == ""){
                      return "Nama Lengkap tidak boleh kosong";
                    }else {
                      return null;
                    }
                  },
                  decoration: const InputDecoration(
                      labelText: "Nama Lengkap",
                      border:  OutlineInputBorder(),
                      labelStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold
                      )
                  ),
                  onChanged: (value) {
                    if (value == ""){
                      setState(() => emptyField = true);
                    }else {
                      setState(() => emptyField = false);
                    }
                  }
              ),
              SizedBox(height: size.height * 0.02,),
              TextFormField(
                  controller: address,
                  validator: (value){
                    if(value == null || value == ""){
                      return "Alamat tidak boleh kosong";
                    }else {
                      return null;
                    }
                  },
                  decoration: const InputDecoration(
                      labelText: "Alamat",
                      border:  OutlineInputBorder(),
                      labelStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold
                      )
                  ),
                  onChanged: (value) {
                    if (value == ""){
                      setState(() => emptyField = true);
                    }else {
                      setState(() => emptyField = false);
                    }
                  }
              ),
              SizedBox(height: size.height * 0.02,),
              TextFormField(
                  controller: phoneNumber,
                  validator: (value){
                    if(value == null || value == ""){
                      return "Nomor telepon tidak boleh kosong";
                    }else {
                      return null;
                    }
                  },
                  decoration: const InputDecoration(
                      labelText: "Nomor Telepon",
                      border:  OutlineInputBorder(),
                      labelStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold
                      )
                  ),
                  onChanged: (value) {
                    if (value == ""){
                      setState(() => emptyField = true);
                    }else {
                      setState(() => emptyField = false);
                    }
                  }
              ),
              SizedBox(height: size.height * 0.02,),
              TextFormField(
                  controller: email,
                  validator: (value){
                    if(value == null || value == ""){
                      return "Email tidak boleh kosong";
                    }else {
                      return null;
                    }
                  },
                  decoration: const InputDecoration(
                      labelText: "Email",
                      border:  OutlineInputBorder(),
                      labelStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold
                      )
                  ),
                  onChanged: (value) {
                    if (value == ""){
                      setState(() => emptyField = true);
                    }else {
                      setState(() => emptyField = false);
                    }
                  }
              ),
              SizedBox(height: size.height * 0.02,),
              TextFormField(
                  controller: password,
                  validator: (value){
                    if(value == null || value == ""){
                      return "Password tidak boleh kosong";
                    }else {
                      return null;
                    }
                  },
                  decoration: const InputDecoration(
                      labelText: "Password",
                      border:  OutlineInputBorder(),
                      labelStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold
                      )
                  ),
                  onChanged: (value) {
                    if (value == ""){
                      setState(() => emptyField = true);
                    }else {
                      setState(() => emptyField = false);
                    }
                  }
              ),
              SizedBox(height: size.height * 0.04,),
              RoundedButton(
                text: "Simpan",
                press: () async {
                  if(formKey.currentState!.validate()){
                    processAddUser();
                  } else {
                      return;
                  }
                } ,
              ),
              SizedBox(height: size.height * 0.02,),
              RoundedButton(
                text: "Batal",
                color: Colors.grey,
                textColor: Colors.white,
                press: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) {
                            return HomePage();
                          }
                      )
                  );
                } ,
              ),
            ],
          ),
        )
      )
    );
  }
}
