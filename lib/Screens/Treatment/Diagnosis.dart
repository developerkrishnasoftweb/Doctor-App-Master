import 'package:flutter/material.dart';
import 'package:getcure_doctor/Database/PatientsVisitTable.dart';
import 'package:getcure_doctor/Database/TokenTable.dart';
import 'package:getcure_doctor/Helpers/AppConfig/colors.dart';
import 'package:getcure_doctor/Widgets/SearchBarDiagnosis.dart';
import 'package:provider/provider.dart';

class Diagnosis extends StatefulWidget {
  final Token token;
  final int clinicDocId;
  Diagnosis({Key key, this.token, this.clinicDocId}) : super(key: key);

  @override
  _DiagnosisState createState() => _DiagnosisState();
}

class _DiagnosisState extends State<Diagnosis> {
  @override
  Widget build(BuildContext context) {
    final patient = Provider.of<PatientsVisitDB>(context);

    return SingleChildScrollView(
      child: Center(
          child: Column(
        children: <Widget>[
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  child: ExpansionTile(
                    initiallyExpanded: true,
                      title: Text('Diagnosis'),
                      trailing: IconButton(
                          icon: Icon(
                            Icons.local_hospital,
                            color: orange,
                          ),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return SearchBarDiagnosis(
                                  pId: widget.token.guid,
                                  docId: widget.token.doctorid,
                                  clinicDocId: widget.clinicDocId,
                                );
                              },
                            );
                          }),
                      children: [
                          StreamBuilder(
                          stream: patient.getBriefHistory(widget.token.guid),
                          builder: (BuildContext context,
                              AsyncSnapshot<List<PatientsVisitData>> snapshot) {
                            switch (snapshot.connectionState) {
                              case ConnectionState.waiting:
                                return Text("Loading");
                                break;
                              default:
                                return ListView.builder(
                                  itemCount:
                                      snapshot.data.last.diagnosis == null
                                          ? 0
                                          : snapshot
                                              .data.last.diagnosis.data.length,
                                  shrinkWrap: true,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return ListTile(
                                      subtitle: Text(
                                          "${snapshot.data.last.diagnosis.data[index].isCured == true ? "Cured" : "Since"}" +
                                              "(${snapshot.data.last.diagnosis.data[index].date})",
                                          style: TextStyle(
                                              color: snapshot
                                                          .data
                                                          .last
                                                          .diagnosis
                                                          .data[index]
                                                          .isCured ==
                                                      true
                                                  ? green
                                                  : red)),
                                      title: Text(
                                          snapshot.data.last.diagnosis
                                              .data[index].title,
                                          style: TextStyle(
                                              color: snapshot
                                                          .data
                                                          .last
                                                          .diagnosis
                                                          .data[index]
                                                          .isCured ==
                                                      true
                                                  ? green
                                                  : red)),
                                      dense: true,
                                      trailing: IconButton(
                                          icon: Icon(Icons.cancel),
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: Text(
                                                      "Are you sure you want to remove it?"),
                                                  actions: [
                                                    FlatButton(
                                                      child: Text("Yes"),
                                                      color: red,
                                                      onPressed: () {
                                                        patient
                                                            .deleteDiagnosis(
                                                                snapshot
                                                                    .data.last,
                                                                snapshot
                                                                    .data
                                                                    .last
                                                                    .diagnosis
                                                                    .data[index]
                                                                    .title)
                                                            .then((value) =>
                                                                Navigator.pop(
                                                                    context));
                                                        // patient.deleteBrief(
                                                        //     snapshot.data.last,
                                                        //     snapshot
                                                        //         .data
                                                        //         .last
                                                        //         .briefHistory
                                                        //         .data[index]
                                                        //         .title);
                                                      },
                                                    ),
                                                    FlatButton(
                                                      child: Text("No"),
                                                      color: green,
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              context),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          }),
                                      // subtitle: Text(
                                      //     "${snapshot.data.last.briefHistory.data[index].isCured == true ? "Cured" : "Since"} (${snapshot.data.last.briefHistory.data[index].date})"),
                                    );
                                  },
                                );

                                break;
                              // default:
                              //   return Text('NO Data');
                              //   break;
                            }
                          },
                        ),
                      ]),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
