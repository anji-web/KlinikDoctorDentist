import 'dart:convert';

import 'package:absensi_project/components/form_text.dart';
import 'package:absensi_project/components/rounded_button.dart';
import 'package:absensi_project/model/absen-model.dart';
import 'package:absensi_project/screens/absen_page.dart';
import 'package:absensi_project/screens/first_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geocoder/geocoder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class BodyFormIn extends StatefulWidget {
  const BodyFormIn({Key? key}) : super(key: key);

  @override
  State<BodyFormIn> createState() => _FormState();
}

class _FormState extends State<BodyFormIn> {
  String? location  = '';
  String? address = '';
  TextEditingController username = TextEditingController();
  TextEditingController NIK = TextEditingController();
  TextEditingController lokasi = TextEditingController();
  TextEditingController dateIn = TextEditingController();
  String keepDate = "";
  bool isLoading = false;

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

    return await Geolocator.getCurrentPosition();
  }

  Future<Placemark> GetAddress(Position position) async {
    List<Placemark> placemark = await placemarkFromCoordinates(position.latitude, position.latitude);
    Placemark place = placemark[0];
    return place;
  }

  @override
  void initState()  {

    super.initState();
    DateTime dateTime = DateTime.now();
    final dateFormat = DateFormat().format(dateTime);

    keepDate = formatISOTime(dateTime);
    dateIn.text = dateFormat.toString();
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

  Future<int> addAbsenMasuk() async {
    var body = {
      "nik" : NIK.text,
      "fullname" : username.text,
      "dateIn" : keepDate,
      "address" : lokasi.text
    };
    var url = await http.post(Uri.parse("http://192.168.0.3:9091/absensi"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(body));
    print(jsonDecode(url.body));
    var result = jsonDecode(url.body);
    print(result['data']);
    var absen = Absen.fromJson(result['data']);
    int statusCode = result["statusCode"];
    _saveIdTemp(absen.idAbsensi);
    return statusCode;
  }

  _saveIdTemp(id) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt("idAbsen", id);
    final valId = prefs.getInt("idAbsen") ?? 0;
  }

  void processAbsenIn() async{
    int result = await addAbsenMasuk();
    setState(() => {
      if (result == 201){
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
          title: const Text('User Berhasil Absen'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {return FirstPage();})
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

    return SingleChildScrollView(
      child:  Container(
        padding: const EdgeInsets.symmetric(horizontal: 27, vertical: 60),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "Absen Datang",
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
                controller: dateIn,
                isEnabled: true,
                textLabel: "Jam Masuk",
                method: (value) {
                  print(value);
                }
            ),
            SizedBox(height: size.height * 0.02,),
            ElevatedButton(
              child: isLoading ? SpinKitCircle(color: Colors.white,) : const Text("Masukan Lokasi Anda") ,
              onPressed: () async {
                if (isLoading) return;
                setState(() => isLoading = true);
                Position position = await _determinePosition();
                // Placemark place = await GetAddress(position);
                final cordinates =  Coordinates(position.latitude, position.longitude);
                var newAdress = await Geocoder.local.findAddressesFromCoordinates(cordinates);
                setState(() {
                  address = newAdress.first.addressLine;
                  lokasi.text = address.toString();
                  isLoading = false;
                });
              },
            ),
            SizedBox(height: size.height * 0.02,),
            FormText(
                controller: lokasi,
                isEnabled: true,
                textLabel: "Lokasi",
                method: (value) {
                  print(value);
                }
            ),
            SizedBox(height: size.height * 0.04,),
            RoundedButton(
              text: "Simpan",
              press: () {
                processAbsenIn();
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
      ),
    );
  }
}
