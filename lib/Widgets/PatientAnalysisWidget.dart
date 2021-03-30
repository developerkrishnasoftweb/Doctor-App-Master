import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:flutter_holo_date_picker/i18n/date_picker_i18n.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:getcure_doctor/Helpers/AppConfig/colors.dart';
import 'package:getcure_doctor/Helpers/Network/Requesthttp.dart';
import 'package:getcure_doctor/Models/FeedbackAnalysis.dart';
import 'package:intl/intl.dart';

class PatientAnalysisWidget extends StatefulWidget {
  final int docId;
  PatientAnalysisWidget({Key key, this.docId}) : super(key: key);
  @override
  _PatientAnalysisWidgetState createState() => _PatientAnalysisWidgetState();
}

class _PatientAnalysisWidgetState extends State<PatientAnalysisWidget> {
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
            future: getFeedBackAnalysis(widget.docId, st, et),
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
                  return ListView.builder(
                    itemCount: snapshot.data.data.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(color: white, boxShadow: [
                            BoxShadow(
                              color: orangef,
                              blurRadius: 5.0,
                            ),
                          ]),
                          padding: EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Q${index+1} " + snapshot.data.data[index].question),
                              ListView.builder(
                                itemCount:
                                    snapshot.data.data[index].options.length,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int ind) {
                                  return ListTile(
                                    leading: Text(
                                      snapshot.data.data[index].options[ind]
                                          .title),
                                        title: Text(
                                      snapshot.data.data[index].options[ind]
                                          .count.toString()+" %"),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
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
