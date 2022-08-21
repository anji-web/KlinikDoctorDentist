import 'package:absensi_project/absen_component/body.dart';
import 'package:flutter/material.dart';

class AbsenPage extends StatelessWidget {
  const AbsenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyAbsen(),
    );
  }
}
