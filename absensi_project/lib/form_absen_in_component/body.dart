import 'package:absensi_project/components/form_text.dart';
import 'package:absensi_project/components/rounded_button.dart';
import 'package:absensi_project/screens/absen_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geocoder/geocoder.dart';
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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

    return await Geolocator.getCurrentPosition(forceAndroidLocationManager: true);
  }

  Future<Placemark> GetAddress(Position position) async {
    List<Placemark> placemark = await placemarkFromCoordinates(position.latitude, position.latitude);
    Placemark place = placemark[0];
    return place;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var dateNow = DateTime.now().toString();
    DateTime localDate = DateFormat("yyyy-MM-dd HH:mm:ssZ").parseUTC(dateNow).toLocal();
    final dateFormat = DateFormat.yMd().add_jm().format(localDate);
    TextEditingController dateIn = TextEditingController(text: dateFormat);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 27, vertical: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
              "Absen Datang",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold
              ),
          ),
          SizedBox(height: size.height * 0.03,),
          FormText(
              controller: NIK,
              isEnabled: false,
              textLabel: "NIK",
              method: (value) {
                print(value);
              }
          ),
          SizedBox(height: size.height * 0.02,),
          FormText(
              controller: username,
              isEnabled: false,
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
              press: () {} ,
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
