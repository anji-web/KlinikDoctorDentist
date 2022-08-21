import 'dart:convert';
import 'package:absensi_project/components/rounded_button.dart';
import 'package:absensi_project/screens/first_page.dart';
import 'package:absensi_project/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LeaveForm extends StatefulWidget {
  const LeaveForm({Key? key}) : super(key: key);

  @override
  State<LeaveForm> createState() => _FormState();
}

class _FormState extends State<LeaveForm> {
  DateTimeRange? dateRange;
  String? dateTextStart;
  String? dateTextEnd;
  TextEditingController nik = TextEditingController();
  TextEditingController fullname = TextEditingController();
  TextEditingController reason = TextEditingController();
  bool emptyField = false;
  final formKey = GlobalKey<FormState>();

  @override
  void initState (){
    super.initState();
    _getUserTemp();
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pengajuan cuti Berhasil Terdaftar'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Silahkan menunggu persetujuan manager')
              ],
            ),
          ),
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

  _getUserTemp() async {
    final prefs = await SharedPreferences.getInstance();
    nik.text = prefs.getString("nik")!;
    fullname.text = prefs.getString("fullname")!;
  }

  String getFrom(){
    if(dateRange == null){
      dateTextStart = 'Dari';
      return dateTextStart!;
    } else{
      dateTextStart = DateFormat("dd/MM/yyyy").format(dateRange!.start);
      return dateTextStart!;
    }
  }

  String getUntil(){
    if(dateRange == null){
      dateTextEnd = 'Sampai';
      return dateTextEnd!;
    } else{
      dateTextEnd = DateFormat("dd/MM/yyyy").format(dateRange!.end);
      return dateTextEnd!;
    }
  }

  Future<int> addCuti() async{
    var body = {
      "nik" : nik.text,
      "name": fullname.text,
      "leaveStart": dateTextStart,
      "leaveEnd" : dateTextEnd,
      "reason" : reason.text
    };
    print(body);
    var res = await http.post(Uri.parse("http://192.168.0.3:9091/absensi-api/cuti"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body:jsonEncode(body));
    var result = jsonDecode(res.body);
    int statusCode = result["statusCode"];
    return statusCode;
  }

  void processAddCuti() async{
    int result = await addCuti();
    setState(() => {
      if (result == 201){
        _showMyDialog()
      }else {
        Fluttertoast.showToast(
            msg: "Pengajuan Cuti Gagal",
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

  Future pickDateRange(BuildContext context) async {
    final initDateRange = DateTimeRange(start: DateTime.now(), end: DateTime.now().add(const Duration(hours: 24 * 3)));
    final newDateRange = await showDateRangePicker(context: context,
        firstDate: DateTime(DateTime.now().year - 5),
        lastDate: DateTime(DateTime.now().year + 5),
      initialDateRange: dateRange ?? initDateRange
    );
    if(newDateRange == null) return;
    setState(() => dateRange = newDateRange);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
          padding: EdgeInsets.symmetric(horizontal: 27, vertical: 5),
          child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: size.height * 0.05,),
                    const Text(
                      "Permohonan Cuti",
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
                    const Text("Tanggal Cuti", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                    SizedBox(height: size.height * 0.04,),
                    Row(
                      children: <Widget>[
                        Container(
                          width: size.width * 0.3,
                          child : ElevatedButton(
                              onPressed: (){
                                pickDateRange(context);
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.grey,

                              ),
                              child: Text(getFrom()),
                            )
                        ),
                        SizedBox(width: size.width * 0.05,),
                        const Icon(Icons.arrow_right_alt_outlined),
                        SizedBox(width: size.width * 0.04,),
                        Container(
                            width: size.width * 0.3,
                            child : ElevatedButton(
                              onPressed: (){
                                pickDateRange(context);
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.grey,
                              ),
                              child: Text(getUntil()),
                            )
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.04,),
                    TextFormField(
                      controller: reason,
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
                      enableInteractiveSelection: true,
                      autofocus: false,
                      minLines: 1,
                      maxLines: 5,
                      decoration: const InputDecoration(
                        labelText: "Alasan cuti"
                      ),
                    ),
                    SizedBox(height: size.height * 0.04,),
                    RoundedButton(
                      text: "Simpan",
                      press: () async {
                        if(formKey.currentState!.validate()){
                          processAddCuti();
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
                                  return FirstPage();
                                }
                            )
                        );
                      } ,
                    ),
                  ],
                ),
              )
          )
      ),
    );
  }
}
