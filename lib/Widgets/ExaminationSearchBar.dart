import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:getcure_doctor/Database/ExaminationTable.dart' as exam;
import 'package:getcure_doctor/Database/PatientsVisitTable.dart';
import 'package:getcure_doctor/Helpers/AppConfig/colors.dart';
import 'package:getcure_doctor/Models/PatientsVisitTableModels.dart';
import 'package:getcure_doctor/Widgets/UpdateExamination.dart';
import 'package:provider/provider.dart';

import 'LabTest.dart';

class ExaminationSearchBar extends StatefulWidget {
  final String pId;
  final int docId;
  final VoidCallback fun;

  ExaminationSearchBar({Key key, this.pId, this.docId, this.fun}) : super(key: key);

  @override
  _ExaminationSearchBarState createState() => _ExaminationSearchBarState();
}

class _ExaminationSearchBarState extends State<ExaminationSearchBar> {
  String query = '';
  @override
  Widget build(BuildContext context) {
    final database = Provider.of<exam.ExaminationsDB>(context);
    final patientsVisit = Provider.of<PatientsVisitDB>(context);

    return SingleChildScrollView(
      child: AlertDialog(
        // title: Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: <Widget>[
        //     Container(child: Text('Examination')),
        //     InkWell(
        //         onTap: () {
        //           Navigator.pop(context);
        //         },
        //         child: Icon(Icons.close))
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
                  'Examination',
                  style: TextStyle(color: white),
                ),
                IconButton(
                    icon: Icon(Icons.cancel),
                    onPressed: () {
                      widget.fun();
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

                  children: <Widget>[
                    _buildTaskListGrid(
                        context, query, database, patientsVisit, widget.pId),
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
                    _buildTaskList(
                        context, query, database, patientsVisit, widget.pId),
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
                      barrierDismissible: true,
                      builder: (BuildContext context) {
                        return SingleChildScrollView(
                          child: LabTest(docId: widget.docId),
                        );
                      },
                    );
                  },
                  child: Icon(
                    Icons.add,
                    color: white,
                    size: 40,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  StreamBuilder<List<exam.Examination>> _buildTaskList(
      BuildContext context,
      String query,
      exam.ExaminationsDB database,
      PatientsVisitDB pv,
      String pId) {
    return StreamBuilder(
      stream: database.watchAllTasks(query),
      builder: (context, AsyncSnapshot<List<exam.Examination>> snapshot) {
        final tasks = snapshot.data ?? List();
        //print(tasks.length);
        //print(snapshot.data);
        return Container(
          height: MediaQuery.of(context).size.height * 0.4,
          width: MediaQuery.of(context).size.width * 0.6,
          child: ListView.builder(
            // separatorBuilder: (_, index) {
            //   return Divider();
            // },
            scrollDirection: Axis.vertical,
            itemCount: tasks.length,
            shrinkWrap: true,
            itemBuilder: (_, index) {
              final itemTask = tasks[index];
              return GestureDetector(
                onTap: () async {
                  List<Parameters> par = [];
                  for (var i in itemTask.parameters.data) {
                    par.add(Parameters(
                        bioReference: i.bioReference,
                        references: i.references,
                        result: [],
                        title: i.title,
                        method: i.method,
                        sample: i.sample,
                        type: i.type,
                        unit: i.unit));
                  }
                  List<ExaminationData> bhd = [
                    ExaminationData(
                        examinationId: itemTask.id,
                        title: itemTask.title,
                        parameters: par,
                        status: 'Advised')
                  ];
                  Examinationgenerated bh = Examinationgenerated(data: bhd);
                  var p = await pv.checkPatient(pId);
                  pv.updateExamination(p.last, bh);
                  Fluttertoast.showToast(
                      msg: "${itemTask.title} added to list",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: green,
                      textColor: white,
                      fontSize: 16.0);
                },
                onLongPress: () {
                  showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (BuildContext context) {
                      return SingleChildScrollView(
                        child: UpdateExamination(examination: itemTask,),
                      );
                    },
                  );
                },
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                  leading: Text(itemTask.title),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

StreamBuilder<List<PatientsVisitData>> _buildTaskListGrid(BuildContext context,
    String query,
    exam.ExaminationsDB database,
    PatientsVisitDB pv,
    String pId) {
  return StreamBuilder(
    stream: pv.getBriefHistory(pId),
    builder: (context, AsyncSnapshot<List<PatientsVisitData>> snapshot) {
      switch (snapshot.connectionState) {
        case ConnectionState.waiting:
          return CircularProgressIndicator();
          break;
        default:
          return Container(
            height: (snapshot.data.last.examination == null)?0:(snapshot.data.last.examination.data.length==0)
                ?0:(snapshot.data.last.examination.data.length<=3)?60:120,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Wrap(
                spacing: 5.0,
                children: List.generate(
                    snapshot.data.last.examination == null
                        ? 0
                        : snapshot.data.last.examination.data.length,
                        (index) => GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title:
                              Text("Are you sure you want to remove it?"),
                              actions: [
                                FlatButton(
                                  child: Text("Yes"),
                                  color: red,
                                  onPressed: () {
                                    pv.deleteExam(
                                        snapshot.data.last,
                                        snapshot.data.last.examination
                                            .data[index].title);
                                    Navigator.pop(context);
                                  },
                                ),
                                FlatButton(
                                  child: Text("No"),
                                  color: green,
                                  onPressed: () => Navigator.pop(context),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Container(
                        child: Chip(
                          elevation: 4,
                          shadowColor: Colors.grey[50],
                          padding: EdgeInsets.all(4),
                          // clipBehavior: Clip.antiAlias,
                          backgroundColor: orangef,
                          label: FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Container(
                              //  width: 60.0,
                              //  height: 20,
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(
                                        text: snapshot.data.last.examination
                                            .data[index].title,
                                        style: TextStyle(
                                          color: white,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 5.0)
                                    ),
                                    RichText(
                                        textAlign: TextAlign.center,
                                        text: TextSpan(
                                          text: "X",
                                          style: TextStyle(
                                            color: black,
                                            fontSize: 14,
                                          ),
                                        )),
                                  ],
                                )),
                          ),
                        ),
                      ),
                    )),
              ),
            ),
          );

          break;
      }
    },
  );
}