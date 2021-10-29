import 'package:flutter/material.dart';
import 'package:getcure_doctor/Database/SymptomsTable.dart';
import 'package:getcure_doctor/Database/TokenTable.dart';
import 'package:getcure_doctor/Helpers/AppConfig/colors.dart';
import 'package:getcure_doctor/Screens/Treatment/HomeConnector.dart';
import 'package:getcure_doctor/Widgets/DisplayEmergencyList.dart';
import 'package:getcure_doctor/Widgets/DisplayListPatients.dart';
import 'package:provider/provider.dart';

int tokenNo = 0;
String tokenName = '';

class ListDocPatients extends StatefulWidget {
  final SymptomsDB databse;
  final int docId;
  final TokenDB topi;
  final DateTime date;
  final int clinicDocId;

  const ListDocPatients(
      {Key key,
      this.databse,
      this.docId,
      this.topi,
      this.date,
      this.clinicDocId})
      : super(key: key);

  @override
  _ListDocPatientsState createState() => _ListDocPatientsState();
}

class _ListDocPatientsState extends State<ListDocPatients> {
  @override
  void initState() {
    totalTokens(widget.topi);

    super.initState();
  }

  PageController pageController = new PageController();
  List<String> data = [];

  Token tok;

  void changePages(int index) {
    print(index);
    pageController.animateToPage(index,
        duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);

    pageController.jumpToPage(index);
    Navigator.of(context).pop();
  }

  int countOfTokens = 0;
  int countOfEmergency = 0;

  void totalTokens(TokenDB topi) async {
    List<Token> list = await topi.getcount(widget.date);
    countOfTokens = list.length;
    List<Token> list2 = await topi.getAllEmergencyTasks(widget.date);
    countOfEmergency = list2.length;
    // List<Token> checkList = await topi.getAllbookedTasks(widget.date);
    // print("CheckList Length");
    // print(checkList.length);
    // tokenNo =checkList.length==0?0: checkList.first.tokenno;
    setState(() {});

    print("COUNT OF TOKENS ");
    print(countOfTokens);
    print(tokenNo);
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  // void insertPatients(int index, Token tok) async {
  //   final patient = Provider.of<PatientsVisitDB>(context, listen: false);
  //   print(tok.guid);
  //   List<PatientsVisitData> result = await patient.checkPatient(tok.guid);
  //   setState(() {
  //     tokenNo = tok.tokenno;
  //   });
  //   if (result.isEmpty) {
  //     print('absent');
  //     final p = PatientsVisitData(
  //         mobileNo: tok.mobileno,
  //         patientName: tok.name,
  //         patientId: tok.guid.toString(),
  //         age: tok.age,
  //         clinicDoctorId: tok.doctorid);
  //     patient.insert(p);
  //   } else {
  //     print('preseent');
  //     PatientsVisitData r = result.last;
  //     final p = PatientsVisitData(
  //         mobileNo: r.mobileNo,
  //         patientName: r.patientName,
  //         temperature: r.temperature,
  //         pulse: r.pulse,
  //         patientId: r.patientId,
  //         visitReason: r.visitReason,
  //         age: r.age,
  //         briefHistory: r.briefHistory,
  //         allergies: r.allergies,
  //         clinicDoctorId: r.clinicDoctorId,
  //         diagnosis: r.diagnosis,
  //         examination: r.examination,
  //         lifestyle: r.lifestyle,
  //         medication: r.medication,
  //         feedBack: r.medication,
  //         weight: r.weight);
  //     patient.insert(p);
  //     // print(tokenno);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<TokenDB>(context);

    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: orange,
          ),
          backgroundColor: white,
          title: Text(
            '$tokenNo. $tokenName',
            style: TextStyle(color: Colors.black, fontSize: 14),
          ),
          actions: <Widget>[
            Row(
              children: <Widget>[
                InkWell(
                    onTap: () {
                      totalTokens(widget.topi);
                      showDialog(
                          context: context,
                          builder: (context) {
                            return DisplayEmergencyList(
                              token: database,
                              pageController: pageController,
                              tokenNo: tokenNo,
                              changePages: changePages,
                              date: widget.date,
                            );
                          });
                    },
                    child: Container(
                      height: 34,
                      width: 34,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: orange,
                      ),
                      child: Center(
                          child: Text(countOfEmergency.toString(),
                              style: TextStyle(color: white))),
                    )),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                    onTap: () {
                      totalTokens(widget.topi);
                      print('list');
                      showDialog(
                          context: context,
                          builder: (context) {
                            return DisplayLists(
                              token: database,
                              pageController: pageController,
                              tokenNo: tokenNo,
                              changePages: changePages,
                              date: widget.date,
                            );
                          });
                    },
                    child: Container(
                      height: 34,
                      width: 34,
                      alignment: Alignment.center,
                      child: Center(
                          child: Text(countOfTokens.toString(),
                              style: TextStyle(color: white))),
                      decoration:
                          BoxDecoration(shape: BoxShape.circle, color: green),
                    )),
                SizedBox(
                  width: 10,
                ),
              ],
            )
          ],
        ),
        body: StreamBuilder(
          stream: database.watchAllbookedTasks(widget.date),
          builder: (context, AsyncSnapshot<List<Token>> snapshot) {
            final tasks = snapshot.data ?? List();
            // tok=tasks[0];

            if (tasks.isNotEmpty) {
              print(tasks.length);
              tok = tasks[0];
              tokenNo = tasks[0].tokenno;
              tokenName = tasks[0].name;
            }

            if (tasks.length == 0) {
              return Container(
                  child: Center(
                      child: Text(
                "No Tokens Available",
                style: TextStyle(fontWeight: FontWeight.bold),
              )));
            }
            return Container(
              child: PageView.builder(
                controller: pageController,
                scrollDirection: Axis.horizontal,
                itemCount: tasks.length,
                // shrinkWrap: true,
                onPageChanged: (int index) async {
                  setState(() {
                    tok = tasks[index];
                    tokenNo = tasks[index].tokenno;
                    tokenName = tasks[index].name;
                    print(tasks[index].name);
                  });
                  // final patient =
                  //     Provider.of<PatientsVisitDB>(context, listen: false);

                  // List<PatientsVisitData> result =
                  //     await patient.checkPatient(tasks[index].guid);

                  // if (result.isEmpty) {
                  //   print('absent');
                  //   final p = PatientsVisitData(
                  //       mobileNo: tasks[index].mobileno,
                  //       patientName: tasks[index].name,
                  //       patientId: tasks[index].guid.toString(),
                  //       age: tasks[index].age,
                  //       clinicDoctorId: tasks[index].doctorid);
                  //   patient.insert(p);
                  // } else {
                  //   print('preseent');
                  //   PatientsVisitData r = result.last;
                  //   final p = PatientsVisitData(
                  //       mobileNo: r.mobileNo,
                  //       patientName: r.patientName,
                  //       temperature: r.temperature,
                  //       pulse: r.pulse,
                  //       patientId: r.patientId,
                  //       visitReason: r.visitReason,
                  //       age: r.age,
                  //       briefHistory: r.briefHistory,
                  //       allergies: r.allergies,
                  //       clinicDoctorId: r.clinicDoctorId,
                  //       diagnosis: r.diagnosis,
                  //       examination: r.examination,
                  //       lifestyle: r.lifestyle,
                  //       medication: r.medication,
                  //       feedBack: r.medication,
                  //       weight: r.weight);
                  //   patient.insert(p);
                  //   // print(tokenno);
                  // }
                },
                itemBuilder: (context, index) {
                  return HomeConnector(
                    token: tasks[index],
                    pageController: pageController,
                    clinicDocId: widget.clinicDocId,
                  );
                },
              ),
            );
          },
        ));
  }
}
