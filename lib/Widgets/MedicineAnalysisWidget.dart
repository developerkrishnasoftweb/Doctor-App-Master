import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:flutter_holo_date_picker/i18n/date_picker_i18n.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:getcure_doctor/Helpers/AppConfig/colors.dart';
import 'package:getcure_doctor/Helpers/Network/Requesthttp.dart';
import 'package:intl/intl.dart';

class MedicineAnalysisWidget extends StatefulWidget {
  final int docId;

  MedicineAnalysisWidget({Key key, this.docId}) : super(key: key);

  @override
  _MedicineAnalysisWidgetState createState() => _MedicineAnalysisWidgetState();
}

class _MedicineAnalysisWidgetState extends State<MedicineAnalysisWidget> {
  DateTime st = DateTime.now();
  DateTime et = DateTime.now();
  @override
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          Container(
            // width: 35,
            height: 50,
            decoration: BoxDecoration(
                color: white, borderRadius: BorderRadius.circular(20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Analysis  from ',
                  style: TextStyle(color: black, fontWeight: FontWeight.bold),
                ),
                InkWell(
                  onTap: () async {
                    var selected = await DatePicker.showSimpleDatePicker(
                      context,
                      initialDate: st,
                      // firstDate:
                      //     DateTime.now().subtract(Duration(days: 365)),
                      dateFormat: "dd-MMMM-yyyy",
                      locale: DateTimePickerLocale.en_us,
                      looping: true,
                    );
                    selected != null
                        ? setState(() {
                            st = selected;
                          })
                        : setState(() {
                            st = st;
                          });
                  },
                  child: Text(
                    "${DateFormat('dd-MM-yyyy').format(st).toString()} ",
                    style: TextStyle(color: blue),
                  ),
                ),
                Text(
                  'To ',
                  style: TextStyle(color: black, fontWeight: FontWeight.bold),
                ),
                InkWell(
                  onTap: () async {
                    var selected = await DatePicker.showSimpleDatePicker(
                      context,
                      initialDate: et,
                      // firstDate:
                      //     DateTime.now().subtract(Duration(days: 365)),
                      dateFormat: "dd-MMMM-yyyy",
                      locale: DateTimePickerLocale.en_us,
                      // looping: true,
                    );
                    selected != null
                        ? setState(() {
                            et = selected;
                          })
                        : setState(() {
                            et = et;
                          });
                  },
                  child: Text(
                    DateFormat('dd-MM-yyyy').format(et).toString(),
                    style: TextStyle(color: blue),
                  ),
                )
              ],
            ),
          ),
          FutureBuilder(
            future: getMedicineAnalysis(widget.docId, st, et),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Container(
                      height: MediaQuery.of(context).size.width,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ));
                  break;
                case ConnectionState.done:
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                        // sortColumnIndex: 1,
                        // columnSpacing: 8,
                        // horizontalMargin: 5,
                        columns: <DataColumn>[
                          DataColumn(label: Text('Medicine Name')),
                          DataColumn(label: Text('No of prescriptions')),
                          DataColumn(label: Text('Quantity')),
                          // DataColumn(label: Text('Medicine Effect')),
                         
                        ],
                        rows: snapshot.data.data
                            .map<DataRow>((p) => DataRow(cells: [
                                  DataCell(
                                      Text(
                                        p.title,
                                        style: TextStyle(color: blue),
                                      ),
                                      onTap: () => showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return SimpleDialog(
                                                title: Text(
                                                    "Prescribed ${p.title} For Disease"),
                                                children: [
                                                  DataTable(
                                                      // columnSpacing: 8,
                                                      // horizontalMargin: 5,

                                                      columns: <DataColumn>[
                                                        // DataColumn(
                                                        //     label: Text(
                                                        //         'Rank')),
                                                        DataColumn(
                                                            label: Text(
                                                          'Disease Name',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )),
                                                        DataColumn(
                                                            label: Text(
                                                          'Times',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )),
                                                      ],
                                                      rows: p.diseases
                                                          .map<DataRow>((li) =>
                                                              DataRow(cells: [
                                                                // DataCell(
                                                                //   Text(
                                                                //     i=,
                                                                //   ),
                                                                // ),
                                                                DataCell(
                                                                  Text(
                                                                    li.name,
                                                                  ),
                                                                ),
                                                                DataCell(
                                                                  Text(li.count
                                                                      .toString()),
                                                                )
                                                              ]))
                                                          .toList())
                                                ],
                                              );
                                            },
                                          )),
                                  DataCell(Text(p.presCount.toString()),
                                      onTap: () {}),
                                  DataCell(Text(p.qty.toString()),
                                      onTap: () {}),
                                  // DataCell(Text(p.cured.toString()),
                                  //     onTap: () {}),
                                  
                                ]))
                            .toList()),
                  );
                  break;

                default:
                  return Text("Something Went Wrong");
              }
            },
          )
        ],
      ),
    );
  }
}
