import 'dart:convert';
import 'package:absensi_project/components/form_text.dart';
import 'package:absensi_project/components/rounded_button.dart';
import 'package:absensi_project/screens/absen_page.dart';
import 'package:absensi_project/screens/first_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class BodyFormOut extends StatefulWidget {
  const BodyFormOut({Key? key}) : super(key: key);

  @override
  State<BodyFormOut> createState() => _FormState();
}

class _FormState extends State<BodyFormOut> {
  TextEditingController username = TextEditingController();
  TextEditingController NIK = TextEditingController();
  bool isLoading = false;
  TextEditingController dateOut = TextEditingController();
  String keepDate = "";

  @override
  void initState(){
    super.initState();
    DateTime dateTime = DateTime.now();
    final dateFormat = DateFormat().format(dateTime);
    keepDate = formatISOTime(dateTime);
    dateOut.text = dateFormat.toString();
    _getUserTemp();
  }

  _getUserTemp() async {
    final prefs = await SharedPreferences.getInstance();
    NIK.text = prefs.getString("nik")!;
    username.text = prefs.getString("fullname")!;
  }

  String formatISOTime(DateTime date) {
    //converts date into the following format:
    // or 2019-06-04T12:08:56.235-0700
    var duration = date.timeZoneOffset;
    if (duration.isNegative)
      return (DateFormat("yyyy-MM-ddTHH:mm:ss").format(date));
    else
      return (DateFormat("yyyy-MM-ddTHH:mm:ss").format(date));
  }

  Future<int> absenKeluar() async {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getInt('idAbsen');
    if (kDebugMode) {
      print(id);
    }
    var body = {
      "idAbsensi" : id,
      "nik" : NIK.text,
      "fullname" : username.text,
      "dateOut" : keepDate
    };
    print(body);
    var url = await http.put(Uri.parse("http://192.168.0.3:9091/absensi"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
    },body: jsonEncode(body));
    var result = jsonDecode(url.body);
    int statusCode = result["statusCode"];
    prefs.remove('idAbsen');
    return statusCode;
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {

        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition(forceAndroidLocationManager: true);
  }

  Future<Placemark> GetAddress(Position position) async {
    List<Placemark> placemark = await placemarkFromCoordinates(position.latitude, position.latitude);
    Placemark place = placemark[0];
    return place;
  }

  void processAbsenOut() async{
    int result = await absenKeluar();
    setState(() => {
      if (result == 200){
        _showMyDialog()
      }else {
        Fluttertoast.showToast(
            msg: "Absen keluar gagal",
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

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Absen keluar berhasil'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {return const FirstPage();})
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 27, vertical: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
         const Text(
              "Absen Keluar",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold
              ),
          ),
          SizedBox(height: size.height * 0.03,),
          FormText(
              controller: NIK,
              isEnabled: true,
              textLabel: "NIK",
              method: (value) {
                print(value);
              }
          ),
          SizedBox(height: size.height * 0.02,),
          FormText(
              controller: username,
              isEnabled: true,
              textLabel: "Nama Lengkap",
              method: (value) {
                print(value);
              }
          ),
          SizedBox(height: size.height * 0.02,),
          FormText(
              controller: dateOut,
              isEnabled: true,
              textLabel: "Jam Keluar",
              method: (value) {
                print(value);
              }
          ),
          SizedBox(height: size.height * 0.04,),
          RoundedButton(
              text: "Simpan",
              press: () {
                processAbsenOut();
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
                      return AbsenPage();
                    }
                )
              );
            } ,
          ),
        ],
      ),
    );
  }
}
