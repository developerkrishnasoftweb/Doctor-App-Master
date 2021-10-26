import 'package:flutter/material.dart';
import 'package:getcure_doctor/Database/MedicinesTable.dart';
import 'package:getcure_doctor/Database/PatientsVisitTable.dart';
import 'package:getcure_doctor/Database/Recommendation.dart';
import 'package:getcure_doctor/Database/TokenTable.dart';
import 'package:getcure_doctor/Helpers/AppConfig/colors.dart';
import 'package:getcure_doctor/Helpers/Network/Requesthttp.dart';
import 'package:getcure_doctor/Models/PatientsVisitTableModels.dart';
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
  void initState() {
    super.initState();
    _getSuggestion();
  }

  void _getSuggestion() async {
    final patient = Provider.of<PatientsVisitDB>(context, listen: false);

    PatientsVisitData visitData =
        (await patient.getDiagnosis(widget.token.guid)).last;
    final briefHistory = visitData?.briefHistory?.data?.map((e) {
      final json = e.toJson();
      final duration = '${e.date}'.split(' ');
      final values =
          duration.where((v) => !v.contains(RegExp(r'\D+'))).toList();
      final keys = duration.where((v) => v.contains(RegExp(r'\D+'))).toList();

      keys.forEach((v) {
        final index = keys.indexOf(v);
        if (v == 'days') {
          json.addAll({'day': values[index]});
        } else if (v == 'months') {
          json.addAll({'month': values[index]});
        } else if (v == 'years') {
          json.addAll({'year': values[index]});
        }
      });
      return json;
    })?.toList();
    final visitReason = visitData?.visitReason?.data?.map((e) {
      final json = e.toJson();
      final duration = '${e.date}'.split(' ');
      final values =
          duration.where((v) => !v.contains(RegExp(r'\D+'))).toList();
      final keys = duration.where((v) => v.contains(RegExp(r'\D+'))).toList();

      keys.forEach((v) {
        final index = keys.indexOf(v);
        if (v == 'days') {
          json.addAll({'day': values[index]});
        } else if (v == 'months') {
          json.addAll({'month': values[index]});
        } else if (v == 'years') {
          json.addAll({'year': values[index]});
        }
      });
      return json;
    })?.toList();
    final allergies =
        visitData?.allergies?.data?.map((e) => e.toJson())?.toList();
    final lifestyle =
        visitData?.lifestyle?.data?.map((e) => e.toJson())?.toList();
    final examination =
        visitData?.examination?.data?.map((e) => e.toJson())?.toList();
    var payload = <String, dynamic>{
      "age": widget.token.age,
      "gender": widget.token.gender,
      "temperature": visitData.temperature,
      "systolicBP": visitData.bp.split('/')[0],
      "diastolicBP": visitData.bp.split('/')[1],
      "pulse": visitData.pulse,
      "weight": visitData.weight
    };

    if (briefHistory != null && briefHistory.isNotEmpty) {
      payload.addAll({"briefHistory": briefHistory});
    }

    if (visitReason != null && visitReason.isNotEmpty) {
      payload.addAll({"visitReason": visitReason});
    }

    if (allergies != null && allergies.isNotEmpty) {
      payload.addAll({"allergies": allergies});
    }

    if (lifestyle != null && lifestyle.isNotEmpty) {
      payload.addAll({"lifestyle": lifestyle});
    }

    if (examination != null && examination.isNotEmpty) {
      payload.addAll({"examination": examination});
    }

    final response = await getMedicationsSuggestion(payload);
    if (response != null && response.isNotEmpty) {
      List<DignosisData> bhdd = [];

      response.forEach((suggestion) {
        bhdd.addAll(suggestion.diagnosis);
      });
      if (bhdd.isNotEmpty) {
        final recom = Provider.of<RecommendationDB>(context, listen: false);
        final med = Provider.of<MedicinesDB>(context, listen: false);
        Dignosisgenerated bht = Dignosisgenerated(data: bhdd);
        await patient.updateDiagnosis(visitData, bht, recom, med);
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // _getSuggestion();
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
