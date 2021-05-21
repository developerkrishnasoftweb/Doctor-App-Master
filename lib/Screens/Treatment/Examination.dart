import 'package:flutter/material.dart';
import 'package:getcure_doctor/Database/PatientsVisitTable.dart';
import 'package:getcure_doctor/Database/TokenTable.dart';
import 'package:getcure_doctor/Helpers/AppConfig/colors.dart';
import 'package:getcure_doctor/Widgets/ExamResult.dart';
import 'package:getcure_doctor/Widgets/ExaminationSearchBar.dart';
import 'package:provider/provider.dart';

class Examination extends StatefulWidget {
  final Token token;
  int examCount;
  Examination({Key key, this.token, this.examCount}) : super(key: key);

  @override
  _ExaminationState createState() => _ExaminationState();
}

class _ExaminationState extends State<Examination> {

  int examcount;
  getExamCount(PatientsVisitDB patient) async {
    final patient = Provider.of<PatientsVisitDB>(context, listen: false);
    List<PatientsVisitData> testsTotal =
        await patient.getBriefHistoryFuture(widget.token.guid);
    if (testsTotal.last.examination == null) {
      examcount = 0;
    } else {
      examcount = 0;
      for (var x in testsTotal.last.examination.data) {
        if (x.status.compareTo("Completed") != 0) {
          examcount += x.parameters.length;
        }
      }
    }
    setState(() {});
  }

  @override
  void initState() {
    examcount = widget.examCount;
  }

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
                      onExpansionChanged: (value) {
                        setState(() {
                          widget.examCount = widget.examCount;
                        });
                      },
                      initiallyExpanded: true,
                      title: Row(
                        children: [
                          Text('Examination'),
                          SizedBox(
                            width: 5,
                          ),
                          Container(
                            height: 28,
                            width: 28,
                            alignment: Alignment.center,
                            child: Center(
                                child: Text(examcount.toString(),
                                    style: TextStyle(color: white))),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: orange),
                          )
                        ],
                      ),
                      trailing: IconButton(
                          icon: Icon(
                            Icons.local_hospital,
                            color: orange,
                          ),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return ExaminationSearchBar(
                                  pId: widget.token.guid,
                                  docId: widget.token.doctorid,
                                   fun: () =>
                                                    getExamCount(patient),
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
                                      snapshot.data.last.examination == null
                                          ? 0
                                          : snapshot.data.last.examination.data
                                              .length,
                                  shrinkWrap: true,
                                  physics: ScrollPhysics(),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return ListTile(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          barrierDismissible: true,
                                          builder: (BuildContext context) {
                                            return SingleChildScrollView(
                                              child: ExamResult(
                                                exmdata: snapshot.data.last
                                                    .examination.data[index],
                                                pid: widget.token.guid,
                                                fun: () =>
                                                    getExamCount(patient),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      title: Text(snapshot.data.last.examination
                                          .data[index].title),
                                      dense: true,
                                      subtitle: Text(
                                        '(${snapshot.data.last.examination.data[index].status})',
                                        style: TextStyle(
                                            color: snapshot
                                                        .data
                                                        .last
                                                        .examination
                                                        .data[index]
                                                        .status ==
                                                    "Completed"
                                                ? green
                                                : orangef),
                                      ),
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
                                                        patient.deleteExam(
                                                            snapshot.data.last,
                                                            snapshot
                                                                .data
                                                                .last
                                                                .examination
                                                                .data[index]
                                                                .title);
                                                        getExamCount(patient);
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
