import 'dart:convert';

import 'package:absensi_project/components/rounded_button.dart';
import 'package:absensi_project/model/absen-model.dart';
import 'package:absensi_project/screens/first_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class AbsenList extends StatefulWidget {
  const AbsenList({Key? key}) : super(key: key);
  @override
  State<AbsenList> createState() => _AbsenList();
}

class _AbsenList extends State<AbsenList> {
  late List<Absen> data = [];
  
  @override
  void initState() {
    super.initState();
    getData();

  }
  
  Future<List<Absen>> getData() async {
    final prefs = await SharedPreferences.getInstance();
    final nik = prefs.getString("nik");
    final fullname = prefs.getString("fullname");
    var response = await http.get(Uri.parse("http://192.168.0.3:9091/absensi/$nik/$fullname"));
    var res = jsonDecode(response.body)['data'].cast<Map<String, dynamic>>();
    setState(() {
      data = res.map<Absen>((json) => Absen.fromJson(json)).toList();
    });
    return data;
  }

  List<DataColumn> _createDataColumen(){
    return [
      const DataColumn(label: Text("Nama", textAlign: TextAlign.center,style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),)),
      const DataColumn(label: Text("Absen Masuk", textAlign: TextAlign.center,style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),)),
      const DataColumn(label: Text("Absen Keluar", textAlign: TextAlign.center,style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),)),
      const DataColumn(label: Text("Lokasi Absen", textAlign: TextAlign.center,style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),)),
    ];
  }

  List<DataRow> _createDataRow(){
    if(data.isNotEmpty){
      return data.map((e) => DataRow(cells: <DataCell>[
        DataCell(Text(e.fullname)),
        DataCell(Text(e.dateIn.toString())),
        DataCell(Text(e.dateOut.toString())),
        DataCell(Text(e.address.toString())),
      ])).toList();
    }else {
      return data.map((e) => const DataRow(cells:  <DataCell>[
        DataCell(Text("")),
        DataCell(Text("")),
        DataCell(Text("")),
        DataCell(Text(""))
      ])).toList();
    }
  }
    
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: size.height * 0.05,),
                const Text("Data Absensi", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),),
                SizedBox(height: size.height * 0.03,),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(
                    children: <Widget>[
                      DataTable(
                          showBottomBorder: true,
                          dividerThickness: 5,
                          headingTextStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                          ),
                          headingRowColor: MaterialStateProperty.resolveWith(
                                  (states) => Colors.black
                          ),
                          dataRowHeight: 50,
                          horizontalMargin: 10,
                          columnSpacing: 10,
                          border: TableBorder.all(width: 1.0, color: Colors.blueGrey,style:BorderStyle.none  ),
                          columns: _createDataColumen(),
                          rows: _createDataRow(),
                      )
                    ],
                  ),
                ),
                SizedBox(height: size.height * 0.20,),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: RoundedButton(
                    text: "Kembali ke menu utama",
                    press: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return const FirstPage();
                      }));
                    },
                  ),
                ),
                SizedBox(height: size.height * 0.05,),
              ],
            ),
          ),
    );
  }
}
