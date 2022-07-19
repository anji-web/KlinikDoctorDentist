import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';
class AbsenList extends StatelessWidget {
  const AbsenList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 27, vertical: 5),
        child: ListView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(vertical: 35, horizontal: 70),
          children: <Widget>[
            Text("Data Absensi", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
            DataTable(
                horizontalMargin: 20,
                columns: [
                  DataColumn(label: Text("Name")),
                  DataColumn(label: Text("Name")),
                  DataColumn(label: Text("Name")),
                  DataColumn(label: Text("Name")),
                  DataColumn(label: Text("Name")),
                  DataColumn(label: Text("Name"))
                ],
                rows: List<DataRow>.generate(10,
                        (index) => DataRow(cells:
                          [
                            DataCell(Text("Anji" )),
                            DataCell(Text("Anji")),
                            DataCell(Text("Anji")),
                            DataCell(Text("Anji")),
                            DataCell(Text("Anji")),
                            DataCell(Text("Anji")),

                          ]
                        )
                )
            )
          ],
        )
      ),
    );
  }
}
