import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:getcure_doctor/Database/MedicinesTable.dart';
import 'package:getcure_doctor/Database/PatientsVisitTable.dart';
import 'package:getcure_doctor/Helpers/AppConfig/colors.dart';
import 'package:getcure_doctor/Models/DoctorLogin.dart';
import 'package:getcure_doctor/Models/SyncModels/ParameterUpdate.dart';
import 'package:getcure_doctor/Widgets/AddMedicine.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'SelectMedicine.dart';

class MedicineSearch extends StatefulWidget {
  final String pId;
  final int docId;
  final VoidCallback fun;
  final String disease;
  MedicineSearch({Key key, this.pId, this.docId, this.disease, this.fun})
      : super(key: key);

  @override
  _MedicineSearchState createState() => _MedicineSearchState();
}

class _MedicineSearchState extends State<MedicineSearch>
    with SingleTickerProviderStateMixin {
  String query = '';
  TabController tabController;

  ClinicDoctor doc;

  String cate = '';
  TextEditingController _category = new TextEditingController();
  getParameters() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String doctors = pref.getString('parameters');
    ParametersUpdate parametersUpdate =
    ParametersUpdate.fromJson(json.decode(doctors));
    setState(() {
      category = parametersUpdate.data.category.map((e) => e.title).toList();
    });

  }
//dose,fre , dura
  addNewCategory(String category) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String doctors = pref.getString('parameters');
    ParametersUpdate parametersUpdate =
    ParametersUpdate.fromJson(json.decode(doctors));
    parametersUpdate.data.category.add(ParameterData(isOnline: false,title: category,value: 0,type: "category"));
    pref.remove('parameters');
    pref.setString('parameters', json.encode(parametersUpdate));
    // getParameters();
  }

  List<String> category = [];

  @override
  void initState() {
    super.initState();
    getParameters();
    setState(() {
      tabController = TabController(length: 2, vsync: this);
    });
  }

  bool con = false;
  bool newcat = false;

  @override
  Widget build(BuildContext context) {
    final med = Provider.of<MedicinesDB>(context);
    final patientsVisit = Provider.of<PatientsVisitDB>(context);
    return SingleChildScrollView(
      child: AlertDialog(
        // title: Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     Text("Search Medicine"),
        //     InkWell(
        //         child: Icon(Icons.cancel), onTap: () => Navigator.pop(context))
        //   ],
        // ),
        titlePadding: EdgeInsets.zero,
        scrollable: true,
        title: Container(
          alignment: Alignment.center,
          color: orangep,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Search Medicine',
                  style: TextStyle(color: white),
                ),
                IconButton(
                    icon: Icon(Icons.cancel),
                    onPressed: () {
                      Navigator.pop(context);
                    })
              ],
            ),
          ),
        ),
        actions: <Widget>[
          Stack(
            // fit: StackFit.expand,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.7,
                width: MediaQuery.of(context).size.width * 0.8,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Container(
                      color: Colors.green[50],
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: TextField(
                        decoration: InputDecoration(
                            fillColor: Colors.green[100],
                            labelText: 'search',
                            labelStyle: TextStyle(color: blue),
                            border: InputBorder.none),
                        onChanged: (val) {
                          setState(() {
                            query = val;
                          });
                        },
                      ),
                    ),
                    TabBar(
                      controller: tabController,
                      onTap: (ind) {
                        setState(() {
                          con = false;
                        });
                      },
                      tabs: <Tab>[
                        Tab(
                          text: 'Most Prescribed',
                        ),
                        Tab(
                          text: 'Category View',
                        ),
                      ],
                      labelColor: black,
                      isScrollable: true,
                    ),
                    DefaultTabController(
                        length: 2,
                        // initialIndex: 0,
                        child: Flexible(
                          fit: FlexFit.loose,
                          child:
                          TabBarView(controller: tabController, children: [
                            _buildTaskList(
                                context, query, med, patientsVisit, widget.pId),
                            con
                                ? CMedicine(
                                cat: cate,
                                db: med,
                                pv: patientsVisit,
                                pId: widget.pId)
                                : Container(
                              child: ListView.builder(
                                itemCount: category.length + 1,
                                itemBuilder:
                                    (BuildContext context, int index) {
                                  if (index == category.length) {
                                    return Container(
                                      padding: EdgeInsets.only(bottom: 50),
                                      child: ListTile(

                                        title: newcat
                                            ? TextFormField(
                                          controller: _category,
                                          decoration: InputDecoration(
                                              labelText:
                                              'New Category',
                                              border:
                                              OutlineInputBorder(
                                                borderRadius:
                                                BorderRadius
                                                    .circular(5),
                                              )),
                                        )
                                            : Text(
                                          " Category not in list?",
                                          style:
                                          TextStyle(color: blue),
                                        ),
                                        trailing: FlatButton(
                                            onPressed: () {
                                              if (newcat &&
                                                  _category
                                                      .text.isNotEmpty) {
                                                print(_category.text);
                                                category
                                                    .add(_category.text);
                                                addNewCategory(
                                                    _category.text);
                                                _category.clear();
                                              }
                                              setState(() {
                                                newcat = !newcat;
                                              });
                                            },
                                            color: blue,
                                            textColor: white,
                                            child: newcat
                                                ? Text('Save')
                                                : Text('Add New')),
                                      ),
                                    );
                                  } else {
                                    return ListTile(
                                      title: Text(category[index]),
                                      trailing:
                                      Icon(Icons.arrow_forward_ios),
                                      onTap: () {
                                        setState(() {
                                          con = true;
                                          cate = category[index];
                                        });
                                      },
                                    );
                                  }
                                },
                              ),
                            )
                          ]),
                        )),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AddMedicine(
                          docId: widget.docId,
                          database: med,
                          pId: widget.pId,
                        );
                      },
                    );
                  },
                  child: Icon(
                    Icons.add,
                    color: white,
                    size: 30,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  StreamBuilder<List<Medicine>> _buildTaskList(BuildContext context,
      String query, MedicinesDB database, PatientsVisitDB pv, String pId) {
    return StreamBuilder(
      stream: database.watchAllTask(query),
      builder: (context, AsyncSnapshot<List<Medicine>> snapshot) {
        print(query+snapshot.data.toString());
        final tasks = snapshot.data ?? List();
        return Container(
          height: MediaQuery.of(context).size.height * 0.6,
          width: MediaQuery.of(context).size.width * 0.6,
          child: ListView.separated(
            separatorBuilder: (_, index) {
              return Divider();
            },
            scrollDirection: Axis.vertical,
            itemCount: tasks.length,
            shrinkWrap: true,
            itemBuilder: (_, index) {
              final itemTask = tasks[index];
              return GestureDetector(
                onTap: () async {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return SelectMedicine(
                        medicine: itemTask,
                        docId: widget.docId,
                        pv: pv,
                        disease: widget.disease,
                        fun: widget.fun,
                        pId: widget.pId,
                      );
                    },
                  );

                  // PrescribedMedicines pm = PrescribedMedicines(
                  //     title: itemTask.title,
                  //     direction: itemTask.defaultDirection,
                  //     dose: itemTask.defaultDose,
                  //     duration: itemTask.defaultDuration,
                  //     frequency: itemTask.defaultFrequency,
                  //     medicineId: itemTask.id,
                  //     route: itemTask.defaultRoute,
                  //     unit: itemTask.defaultUnit);
                  // var p = await pv.checkPatient(pId);
                  // pv.updateMedication(p[0], widget.disease, pm);
                  // Navigator.pop(context);
                  //   widget.fun();
                },
                child: ListTile(
                  // contentPadding: EdgeInsets.zero,
                  dense: true,

                  title:Text(itemTask.title),
                  subtitle: Text(itemTask.salt  ),
                  // subtitle: Text(itemTask.interactionDrugs +
                  //     " " +
                  //     itemTask.defaultFrequency),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class CMedicine extends StatelessWidget {
  final String cat;
  final MedicinesDB db;
  final PatientsVisitDB pv;
  final String pId;

  const CMedicine({Key key, this.cat, this.db, this.pv, this.pId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: db.searchCategory(cat),
      builder: (context, AsyncSnapshot<List<Medicine>> snapshot) {
        final tasks = snapshot.data ?? List();
        return Container(
          height: MediaQuery.of(context).size.height * 0.6,
          width: MediaQuery.of(context).size.width * 0.6,
          child: ListView.separated(
            separatorBuilder: (_, index) {
              return Divider();
            },
            scrollDirection: Axis.vertical,
            itemCount: tasks.length,
            shrinkWrap: true,
            itemBuilder: (_, index) {
              final itemTask = tasks[index];
              return GestureDetector(
                // onTap: () async {
                // showDialog(
                //   context: context,
                //   builder: (BuildContext context) {
                //     return SelectMedicine(
                //       medicine: itemTask,
                //       docId: widget.docId,
                //       pv: pv,
                //       disease: widget.disease,
                //       fun: widget.fun,
                //       pId: widget.pId,
                //     );
                //   },
                // );

                //   // PrescribedMedicines pm = PrescribedMedicines(
                //   //     title: itemTask.title,
                //   //     direction: itemTask.defaultDirection,
                //   //     dose: itemTask.defaultDose,
                //   //     duration: itemTask.defaultDuration,
                //   //     frequency: itemTask.defaultFrequency,
                //   //     medicineId: itemTask.id,
                //   //     route: itemTask.defaultRoute,
                //   //     unit: itemTask.defaultUnit);
                //   // var p = await pv.checkPatient(pId);
                //   // pv.updateMedication(p[0], widget.disease, pm);
                //   // Navigator.pop(context);
                //   //   widget.fun();
                // },
                child: ListTile(
                  // contentPadding: EdgeInsets.zero,
                  dense: true,

                  title:Text(itemTask.title),
                  subtitle: Text(itemTask.defaultUnit + " "+itemTask.defaultFrequency + " "+itemTask.defaultDose + " "+itemTask.defaultDuration + " "+itemTask.defaultDirection + " "+itemTask.defaultRoute ),
                  // subtitle: Text(itemTask.interactionDrugs +
                  //     " " +
                  //     itemTask.defaultFrequency),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
