import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:getcure_doctor/Database/PatientsVisitTable.dart';
import 'package:getcure_doctor/Database/Recommendation.dart';
import 'package:getcure_doctor/Database/SymptomsTable.dart';
import 'package:getcure_doctor/Database/TokenTable.dart';
import 'package:getcure_doctor/Helpers/AppConfig/colors.dart';
import 'package:getcure_doctor/Helpers/Navigation.dart';
import 'package:getcure_doctor/Widgets/MedicineSearch.dart';
import 'package:getcure_doctor/Widgets/printing.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class Medication extends StatefulWidget {
  final Token token;
  final RecommendationDB recommend;

  Medication({Key key, this.token, this.recommend}) : super(key: key);

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
  List<Advice> advices = [
    Advice(
        advice:
            "Avoid red meat, trans fats, processed carbohydrates and food with high fructose corn syrup",
        isSelected: true),
    Advice(
        advice:
            "Exercise 30 to 60 minutes ground three to four times a week at moderate intensity"),
    Advice(
        advice:
            "Cut calories by 500 to 1,000 calories daily if you're overweight"),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final patient = Provider.of<PatientsVisitDB>(context);
    final sdb = Provider.of<SymptomsDB>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          flex: 2,
          child: FutureBuilder(
            future: patient.getDiagnosis(widget.token.guid),
            builder: (BuildContext context,
                AsyncSnapshot<List<PatientsVisitData>> list) {
              switch (list.connectionState) {
                case ConnectionState.waiting:
                  return Container(child: Center(child: Text("Loading")));
                  break;
                case ConnectionState.done:
                  return ListView.separated(
                      itemCount: list.data.last.diagnosis == null
                          ? 0
                          : list.data.last.diagnosis.data.length,
                      physics: ScrollPhysics(),
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
                                      onLongPress: () {
                                        print(md.last.medicines[index].title);
                                      },
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
                      });
                  break;
                default:
                  return Text("No Data");
              }
            },
          ),
        ),
        Expanded(
          flex: 1,
          child: Padding(
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
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: SingleChildScrollView(
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Advices",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    for (int index = 0; index < advices.length; index++)
                      advices[index].isSelected
                          ? ListTile(
                              dense: true,
                              trailing: IconButton(
                                  icon: Icon(Icons.cancel),
                                  onPressed: () async {
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
                                                  advices[index].isSelected =
                                                      false;
                                                });
                                                Navigator.pop(context);
                                              },
                                            ),
                                            FlatButton(
                                              child: Text("No"),
                                              color: green,
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }),
                              title: Row(
                                children: [
                                  Container(
                                    height: 10,
                                    width: 10,
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    decoration: BoxDecoration(
                                        color: Colors.grey,
                                        shape: BoxShape.circle),
                                  ),
                                  Expanded(
                                    child: Text(
                                      "${advices[index].advice}",
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
                                      builder: (_, state) => AlertDialog(
                                        title: Text("Select Advice"),
                                        content: SingleChildScrollView(
                                          physics: BouncingScrollPhysics(),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: advices.map((advice) {
                                              return CheckboxListTile(
                                                  value: advice.isSelected,
                                                  controlAffinity:
                                                      ListTileControlAffinity
                                                          .leading,
                                                  title: Text(advice.advice),
                                                  onChanged: (value) {
                                                    state(() {
                                                      setState(() {});
                                                      advice.isSelected =
                                                          !advice.isSelected;
                                                    });
                                                  });
                                            }).toList(),
                                          ),
                                        ),
                                        actions: [
                                          Text("Advice not in list?"),
                                          TextButton(
                                            onPressed: () async {
                                              String advice = "";
                                              List<SelectedSymptoms> symptoms =
                                                  [];
                                              await sdb
                                                  .watchAll()
                                                  .then((value) {
                                                value.forEach((element) {
                                                  symptoms.add(SelectedSymptoms(
                                                      symptom: element));
                                                });
                                              });
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (_) => StatefulBuilder(
                                                              builder: (context,
                                                                  state) {
                                                            return AlertDialog(
                                                              title: Text(
                                                                  "Add new advice"),
                                                              content:
                                                                  SingleChildScrollView(
                                                                child: Column(
                                                                  children: [
                                                                    TextField(
                                                                      decoration: InputDecoration(
                                                                          border:
                                                                              UnderlineInputBorder(),
                                                                          hintText:
                                                                              "Advice"),
                                                                      onChanged:
                                                                          (value) {
                                                                        state(
                                                                            () {
                                                                          advice =
                                                                              value;
                                                                        });
                                                                      },
                                                                    ),
                                                                    for (int i =
                                                                            0;
                                                                        i <
                                                                            symptoms
                                                                                .length;
                                                                        i++)
                                                                      CheckboxListTile(
                                                                          value: symptoms[i]
                                                                              .isSelected,
                                                                          controlAffinity: ListTileControlAffinity
                                                                              .leading,
                                                                          title: Text(
                                                                              "${symptoms[i].symptom.title}"),
                                                                          onChanged:
                                                                              (v) {
                                                                            state(() {
                                                                              symptoms[i].isSelected = !symptoms[i].isSelected;
                                                                            });
                                                                          }),
                                                                    /* DropdownButton<
                                                                  Symptom>(
                                                                  onChanged: (v) {
                                                                    state(() {
                                                                      selectedSymptom =
                                                                          v;
                                                                    });
                                                                  },
                                                                  isExpanded: true,
                                                                  value:
                                                                  selectedSymptom,
                                                                  items: symptoms
                                                                      .map(
                                                                          (symptom) {
                                                                        return DropdownMenuItem<
                                                                            Symptom>(
                                                                          child: Text(
                                                                              "${symptom.title}"),
                                                                          value:
                                                                          symptom,
                                                                        );
                                                                      }).toList()) */
                                                                  ],
                                                                ),
                                                              ),
                                                              actions: [
                                                                TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  child: Text(
                                                                    "Close",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                  style: ButtonStyle(
                                                                      backgroundColor:
                                                                          MaterialStateProperty.all(Colors
                                                                              .grey),
                                                                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(20)))),
                                                                ),
                                                                TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    state(() {
                                                                      advices.add(Advice(
                                                                          advice:
                                                                              advice));
                                                                      setState(
                                                                          () {});
                                                                      Navigator.pop(
                                                                          context);
                                                                    });
                                                                  },
                                                                  child: Text(
                                                                    "Add",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                  style: ButtonStyle(
                                                                      backgroundColor:
                                                                          MaterialStateProperty.all(Colors
                                                                              .blue),
                                                                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(20)))),
                                                                )
                                                              ],
                                                            );
                                                          }));
                                            },
                                            child: Text(
                                              "Add New",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        Colors.blue),
                                                shape:
                                                    MaterialStateProperty.all(
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20)))),
                                          )
                                        ],
                                      ),
                                    ));
                          }),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class Advice {
  final String advice;
  bool isSelected;

  Advice({this.advice, this.isSelected: false});
}

class SelectedSymptoms {
  Symptom symptom;
  bool isSelected;

  SelectedSymptoms({this.symptom, this.isSelected: false});
}
