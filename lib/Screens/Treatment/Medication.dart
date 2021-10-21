import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:getcure_doctor/Database/AdviceTable.dart';
import 'package:getcure_doctor/Database/PatientsVisitTable.dart';
import 'package:getcure_doctor/Database/Recommendation.dart';
import 'package:getcure_doctor/Database/SymptomsTable.dart';
import 'package:getcure_doctor/Database/TokenTable.dart';
import 'package:getcure_doctor/Helpers/AppConfig/colors.dart';
import 'package:getcure_doctor/Helpers/Network/Requesthttp.dart';
import 'package:getcure_doctor/Models/PatientsVisitTableModels.dart';
import 'package:getcure_doctor/Widgets/MedicineSearch.dart';
import 'package:provider/provider.dart';

class Medication extends StatefulWidget {
  final Token token;
  final RecommendationDB recommend;
  final Function(List<AdviceData>) getAdvices;

  Medication({Key key, this.token, this.recommend, this.getAdvices})
      : super(key: key);

  @override
  _MedicationState createState() => _MedicationState();
}

class _MedicationState extends State<Medication> {
  // int totalCount=0;
  // void getCounts(String disease, int tcount) async{
  //   totalCount = await widget.recommend.getTotalCount(disease);
  //   setState(() {
  //     tcount=totalCount;
  //   });
  // }

  // int cod(String disease, int tcount){
  //   getCounts(disease, tcount);
  //   return totalCount;
  // }
  List<AllAdvices> advices = [];
  AdvicesDatabase adviceProvider;
  PatientsVisitDB patient;

  @override
  void initState() {
    super.initState();
    adviceProvider = Provider.of<AdvicesDatabase>(context, listen: false);
    patient = Provider.of<PatientsVisitDB>(context, listen: false);
    getAdvices();
    _medicineSuggestion();
  }

  Future<void> getAdvices() async {
    List<Advice> tempAdvice = await adviceProvider.getAllAdvices();
    PatientsVisitData visitData =
        (await patient.getDiagnosis(widget.token.guid)).last;
    advices.clear();
    tempAdvice.forEach((advice) {
      setState(() {
        advices.add(AllAdvices(advice: advice));
      });
    });
    if (visitData.diagnosis?.data != null) {
      visitData.diagnosis.data.forEach((diagnosis) {
        advices.forEach((advice) {
          if (advice.advice.symptoms.split(", ").contains(diagnosis.title)) {
            setState(() {
              advice.isSelected = true;
            });
          }
        });
      });
    }
    insertAdvices();
  }

  insertAdvices() async {
    PatientsVisitData visitData =
        (await patient.checkPatient(widget.token.guid)).last;
    List<AdviceData> adviceData = <AdviceData>[];
    advices.forEach((advice) {
      if (advice.isSelected) {
        adviceData.add(AdviceData.fromJson(advice.advice.toJson()));
      }
    });
    await patient.insertAdvice(adviceData, visitData);
    widget.getAdvices(adviceData);
  }

  void _medicineSuggestion() async {
    try {
      final visitData = (await patient.checkPatient(widget.token.guid)).last;
      if (visitData != null) {
        final briefHistory =
            visitData.briefHistory.data.map((e) => e.toJson()).toList();
        final visitReason =
            visitData.visitReason.data.map((e) => e.toJson()).toList();
        final allergies =
            visitData.allergies.data.map((e) => e.toJson()).toList();
        final lifestyle =
            visitData.lifestyle.data.map((e) => e.toJson()).toList();
        final examination =
            visitData.examination.data.map((e) => e.toJson()).toList();
        final diagnosis =
            visitData.diagnosis.data.map((e) => e.toJson()).toList();
        final payload = <String, dynamic>{
          "age": widget.token.age,
          "gender": widget.token.gender,
          "temperature": visitData.temperature,
          "systolicBP": visitData.bp.split('/')[0],
          "diastolicBP": visitData.bp.split('/')[1],
          "pulse": visitData.pulse,
          "weight": visitData.weight,
          "briefHistory": briefHistory,
          "visitReason": visitReason,
          "allergies": allergies,
          "lifestyle": lifestyle,
          "examination": examination,
          "diagnosis": diagnosis
        };
        final response = await getMedicationsSuggestion(payload);
        final patientsVisitDB =
            Provider.of<PatientsVisitDB>(context, listen: false);
        if (response != null) {
          response.forEach((suggestion) {
            patientsVisitDB.updateMedication(visitData, '', suggestion);
          });
          setState(() {});
        } else {
          print('Suggestions not found!!!');
        }
      }
    } catch (_) {
      print('Error: ');
      print(_);
    }
  }

  @override
  Widget build(BuildContext context) {
    final sdb = Provider.of<SymptomsDB>(context);
    // advices.forEach((element) {
    //   if(element.isSelected)
    // });
    return FutureBuilder(
      future: patient.getDiagnosis(widget.token.guid),
      builder:
          (BuildContext context, AsyncSnapshot<List<PatientsVisitData>> list) {
        switch (list.connectionState) {
          case ConnectionState.waiting:
            return Container(child: Center(child: Text("Loading")));
            break;
          case ConnectionState.done:
            return SingleChildScrollView(
              child: Column(
                children: [
                  ListView.separated(
                      itemCount: list.data.last.diagnosis == null
                          ? 0
                          : list.data.last.diagnosis.data.length,
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          height: 5,
                        );
                      },
                      itemBuilder: (BuildContext context, int index) {
                        var md;
                        if (list.data.last.medication != null) {
                          md = list.data.last.medication.data.where((element) =>
                              element.disease ==
                              list.data.last.diagnosis.data[index].title);
                        }
                        // getCounts(list.data.last.diagnosis.data[index].title);
                        int tcount = 0;
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            // height: 120,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: orangef,
                                    offset: new Offset(0.0, 0.0),
                                    blurRadius: 5.0,
                                  ),
                                ]),
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 8),
                            child: Column(
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  list.data.last.diagnosis.data[index].title +
                                      " (" +
                                      list.data.last.diagnosis.data[index]
                                          .date +
                                      ")",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                ListView.builder(
                                  itemCount: md == null || md.length == 0
                                      ? 0
                                      : md.last.medicines.length,
                                  shrinkWrap: true,
                                  physics: ScrollPhysics(),
                                  padding: EdgeInsets.zero,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return ListTile(
                                      dense: true,
                                      subtitle: Text(
                                          "${md.last.medicines[index].dose} ${md.last.medicines[index].unit}  ${md.last.medicines[index].route} ${md.last.medicines[index].frequency} ${md.last.medicines[index].direction} ${md.last.medicines[index].duration}"),
                                      onLongPress: () {},
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
                                                        setState(() {
                                                          patient.deleteMedicine(
                                                              list.data.last,
                                                              md
                                                                  .elementAt(0)
                                                                  .disease,
                                                              md
                                                                  .elementAt(0)
                                                                  .medicines[
                                                                      index]
                                                                  .title);
                                                        });
                                                        Navigator.pop(context);
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
                                      title: Text(
                                        "${md.last.medicines[index].title} ",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.justify,
                                        softWrap: true,
                                      ),
                                    );
                                  },
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.people),
                                        SizedBox(
                                          width: 2,
                                        ),
                                        FutureBuilder(
                                          future: widget.recommend
                                              .getTotalCount(list.data.last
                                                  .diagnosis.data[index].title),
                                          builder: (_,
                                              AsyncSnapshot<
                                                      List<RecommendationData>>
                                                  snapshot) {
                                            switch (snapshot.connectionState) {
                                              case ConnectionState.waiting:
                                                return Container(
                                                    child: Center(
                                                        child:
                                                            CircularProgressIndicator()));
                                                break;
                                              case ConnectionState.done:
                                                if (snapshot.data == null) {
                                                  return Text('0');
                                                } else {
                                                  if (snapshot.data.length ==
                                                      0) {
                                                    return Text("0");
                                                  } else {
                                                    return Text(snapshot
                                                        .data.first.totalCount
                                                        .toString());
                                                  }
                                                }
                                                break;
                                              default:
                                                return Text('0');
                                            }
                                          },
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.timelapse),
                                        // SizedBox(width: 2,),
                                        // FutureBuilder(
                                        //   future:widget.recommend.getTotalCount(list.data.last.diagnosis.data[index].title),
                                        //   builder: (_, AsyncSnapshot<List<RecommendationData>> snapshot){
                                        //     switch(snapshot.connectionState){
                                        //       case ConnectionState.waiting:
                                        //         return Container(
                                        //             child: Center(child: CircularProgressIndicator()));
                                        //         break;
                                        //       case ConnectionState.done:
                                        //         if(snapshot.data==null){
                                        //           return Text('0');
                                        //         }else{
                                        //           if(snapshot.data.length==0){
                                        //             return Text("0");
                                        //           }else{
                                        //             return Text(snapshot.data.first.totalCount.toString());
                                        //           }
                                        //         }
                                        //         break;
                                        //       default:
                                        //         return Text('0');
                                        //     }
                                        //   },
                                        // )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.check_circle),
                                        SizedBox(
                                          width: 2,
                                        ),
                                        FutureBuilder(
                                          future: widget.recommend
                                              .getTotalCount(list.data.last
                                                  .diagnosis.data[index].title),
                                          builder: (_,
                                              AsyncSnapshot<
                                                      List<RecommendationData>>
                                                  snapshot) {
                                            switch (snapshot.connectionState) {
                                              case ConnectionState.waiting:
                                                return Container(
                                                    child: Center(
                                                        child:
                                                            CircularProgressIndicator()));
                                                break;
                                              case ConnectionState.done:
                                                if (snapshot.data == null) {
                                                  return Text('0%');
                                                } else {
                                                  if (snapshot.data.length ==
                                                      0) {
                                                    return Text("0%");
                                                  } else {
                                                    return Text(((snapshot
                                                                        .data
                                                                        .first
                                                                        .cured /
                                                                    snapshot
                                                                        .data
                                                                        .first
                                                                        .totalCount) *
                                                                100)
                                                            .toInt()
                                                            .toString() +
                                                        "%");
                                                  }
                                                }
                                                break;
                                              default:
                                                return Text('0%');
                                            }
                                          },
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.error_outline),
                                        SizedBox(
                                          width: 2,
                                        ),
                                        FutureBuilder(
                                          future: widget.recommend
                                              .getTotalCount(list.data.last
                                                  .diagnosis.data[index].title),
                                          builder: (_,
                                              AsyncSnapshot<
                                                      List<RecommendationData>>
                                                  snapshot) {
                                            switch (snapshot.connectionState) {
                                              case ConnectionState.waiting:
                                                return Container(
                                                    child: Center(
                                                        child:
                                                            CircularProgressIndicator()));
                                                break;
                                              case ConnectionState.done:
                                                if (snapshot.data == null) {
                                                  return Text('0%');
                                                } else {
                                                  if (snapshot.data.length ==
                                                      0) {
                                                    return Text("0%");
                                                  } else {
                                                    return Text(snapshot
                                                            .data
                                                            .first
                                                            .symptomsIncreased
                                                            .toString() +
                                                        "%");
                                                  }
                                                }
                                                break;
                                              default:
                                                return Text('0%');
                                            }
                                          },
                                        )
                                      ],
                                    ),
                                    IconButton(
                                        icon: Icon(Icons.local_hospital),
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return MedicineSearch(
                                                  pId: widget.token.guid,
                                                  docId: widget.token.doctorid,
                                                  disease: list
                                                      .data
                                                      .last
                                                      .diagnosis
                                                      .data[index]
                                                      .title,
                                                  fun: () => setState(() {}));
                                            },
                                          );
                                        })
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      }),

                  /*Advice design*/
                  list.data.last.diagnosis != null
                      ? list.data.last.diagnosis.data.length > 0
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                // height: 120,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    color: white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: orangef,
                                        offset: new Offset(0.0, 0.0),
                                        blurRadius: 5.0,
                                      ),
                                    ]),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 8),
                                child: Column(
                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Advices",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    for (int index = 0;
                                        index < advices.length;
                                        index++)
                                      advices[index].isSelected
                                          ? ListTile(
                                              dense: true,
                                              trailing: IconButton(
                                                icon: Icon(Icons.cancel),
                                                onPressed: () async {
                                                  showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        title: Text(
                                                            "Are you sure you want to remove it?"),
                                                        actions: [
                                                          FlatButton(
                                                            child: Text("Yes"),
                                                            color: red,
                                                            onPressed: () {
                                                              setState(() {
                                                                advices[index]
                                                                        .isSelected =
                                                                    false;
                                                              });
                                                              Navigator.pop(
                                                                  context);
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
                                                },
                                              ),
                                              title: Row(
                                                children: [
                                                  Container(
                                                    height: 10,
                                                    width: 10,
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10),
                                                    decoration: BoxDecoration(
                                                        color: Colors.grey,
                                                        shape: BoxShape.circle),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      "${advices[index].advice.advice}",
                                                      softWrap: true,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          : SizedBox(),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: IconButton(
                                          icon: Icon(Icons.local_hospital),
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder: (_) => StatefulBuilder(
                                                      builder:
                                                          (_, stateSetter) =>
                                                              AlertDialog(
                                                        title: Text(
                                                            "Select Advice"),
                                                        content:
                                                            SingleChildScrollView(
                                                          physics:
                                                              BouncingScrollPhysics(),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: advices
                                                                .map((advice) {
                                                              return CheckboxListTile(
                                                                  value: advice
                                                                      .isSelected,
                                                                  controlAffinity:
                                                                      ListTileControlAffinity
                                                                          .leading,
                                                                  title: Text(advice
                                                                      .advice
                                                                      .advice),
                                                                  onChanged:
                                                                      (value) async {
                                                                    stateSetter(
                                                                        () {
                                                                      setState(
                                                                          () {});
                                                                      advice.isSelected =
                                                                          !advice
                                                                              .isSelected;
                                                                    });
                                                                    await insertAdvices();
                                                                  });
                                                            }).toList(),
                                                          ),
                                                        ),
                                                        actions: [
                                                          Text(
                                                              "Advice not in list?"),
                                                          TextButton(
                                                            onPressed:
                                                                () async {
                                                              // Navigator.pop(context);
                                                              String advice =
                                                                  "";
                                                              List<SelectedSymptoms>
                                                                  symptoms = [];
                                                              await sdb
                                                                  .watchAll()
                                                                  .then(
                                                                      (value) {
                                                                value.forEach(
                                                                    (element) {
                                                                  symptoms.add(
                                                                      SelectedSymptoms(
                                                                          symptom:
                                                                              element));
                                                                });
                                                              });
                                                              showDialog(
                                                                  context:
                                                                      context,
                                                                  builder: (_) =>
                                                                      StatefulBuilder(builder:
                                                                          (context,
                                                                              state) {
                                                                        return AlertDialog(
                                                                          title:
                                                                              Text("Add new advice"),
                                                                          content:
                                                                              SingleChildScrollView(
                                                                            child:
                                                                                Column(
                                                                              children: [
                                                                                TextField(
                                                                                  decoration: InputDecoration(border: UnderlineInputBorder(), hintText: "Advice"),
                                                                                  onChanged: (value) {
                                                                                    state(() {
                                                                                      advice = value;
                                                                                    });
                                                                                  },
                                                                                  maxLines: 3,
                                                                                  maxLength: 300,
                                                                                ),
                                                                                for (int i = 0; i < symptoms.length; i++)
                                                                                  CheckboxListTile(
                                                                                      value: symptoms[i].isSelected,
                                                                                      controlAffinity: ListTileControlAffinity.leading,
                                                                                      title: Text("${symptoms[i].symptom.title}"),
                                                                                      onChanged: (v) {
                                                                                        state(() {
                                                                                          symptoms[i].isSelected = !symptoms[i].isSelected;
                                                                                        });
                                                                                      }),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          actions: [
                                                                            TextButton(
                                                                              onPressed: () {
                                                                                Navigator.pop(context);
                                                                              },
                                                                              child: Text(
                                                                                "Close",
                                                                                style: TextStyle(color: Colors.white),
                                                                              ),
                                                                              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.grey), shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)))),
                                                                            ),
                                                                            TextButton(
                                                                              onPressed: () async {
                                                                                String selectedSymptoms = "";
                                                                                symptoms.forEach((element) {
                                                                                  if (element.isSelected) {
                                                                                    state(() {
                                                                                      selectedSymptoms += element.symptom.title + ", ";
                                                                                    });
                                                                                  }
                                                                                });
                                                                                state(() {
                                                                                  selectedSymptoms = selectedSymptoms.substring(0, selectedSymptoms.length - 2);
                                                                                });
                                                                                await adviceProvider.insertAdvice(Advice(advice: advice, symptoms: selectedSymptoms));
                                                                                await addAdvices(advice, selectedSymptoms);
                                                                                await getAdvices();
                                                                                stateSetter(() {});
                                                                                Navigator.pop(context);
                                                                              },
                                                                              child: Text(
                                                                                "Add",
                                                                                style: TextStyle(color: Colors.white),
                                                                              ),
                                                                              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blue), shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)))),
                                                                            )
                                                                          ],
                                                                        );
                                                                      }));
                                                            },
                                                            child: Text(
                                                              "Add New",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                            style: ButtonStyle(
                                                                backgroundColor:
                                                                    MaterialStateProperty
                                                                        .all(Colors
                                                                            .blue),
                                                                shape: MaterialStateProperty.all(
                                                                    RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(20)))),
                                                          )
                                                        ],
                                                      ),
                                                    ));
                                          }),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : SizedBox()
                      : SizedBox()
                ],
              ),
            );
            break;
          default:
            return Text("No Data");
        }
      },
    );
  }
}

class AllAdvices {
  final Advice advice;
  bool isSelected;

  AllAdvices({this.advice, this.isSelected: false});
}

class SelectedSymptoms {
  Symptom symptom;
  bool isSelected;

  SelectedSymptoms({this.symptom, this.isSelected: false});
}
