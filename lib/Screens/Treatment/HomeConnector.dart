import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:getcure_doctor/Database/PatientsVisitTable.dart';
import 'package:getcure_doctor/Database/Recommendation.dart';
import 'package:getcure_doctor/Database/TokenTable.dart';
import 'package:getcure_doctor/Helpers/Navigation.dart';
import 'package:getcure_doctor/Helpers/Network/Requesthttp.dart';
import 'package:getcure_doctor/Models/PatientsVisitTableModels.dart';
import 'package:getcure_doctor/Screens/Treatment/Diagnosis.dart';
import 'package:getcure_doctor/Screens/Treatment/Examination.dart';
import 'package:getcure_doctor/Screens/Treatment/Symptoms.dart';
import 'package:getcure_doctor/Screens/pdf_generator/pdf_generator.dart';
import 'package:getcure_doctor/Widgets/DiagnosisNotice.dart';
import 'package:getcure_doctor/Widgets/ExamNoticable.dart';
import 'package:getcure_doctor/Widgets/generalDetails.dart';
import 'package:provider/provider.dart';
import '../../Helpers/AppConfig/colors.dart';
import 'Medication.dart';

class HomeConnector extends StatefulWidget {
  final Token token;
  final ScrollController pageController;
  final int clinicDocId;

  const HomeConnector(
      {Key key, this.token, this.pageController, this.clinicDocId})
      : super(key: key);

  @override
  _HomeConnectorState createState() => _HomeConnectorState();
}

class _HomeConnectorState extends State<HomeConnector>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  int _currentIndex = 0;
  List<AdviceData> advices = [];

  @override
  void initState() {
    super.initState();

    setState(() {
      tabController = TabController(length: 4, vsync: this);

      tabController.animation
        ..addListener(() {
          setState(() {
            _currentIndex = (tabController.animation.value)
                .round(); //_tabController.animation.value returns double
            getDataPd(pq);
            getExamCount(pq);
          });
        });
    });
  }

  int examcount = 0;

  void getExamCount(PatientsVisitDB patient) async {
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
    print("Exam call hua");
    print(examcount);
    setState(() {});
  }

  @override
  void dispose() {
    tabController.dispose();
    controller.dispose();
    super.dispose();
  }

  final controller = PageController(
    initialPage: 0,
  );

  List<Widget> tabsFun(
    BuildContext context,
    RecommendationDB recommend,
  ) {
    final tabpages = <Widget>[
      Symtoms(
        token: widget.token,
        clinicDocId: widget.clinicDocId,
        pd: pdo,
      ),
      Examination(
        token: widget.token,
        examCount: examcount,
      ),
      Diagnosis(
        token: widget.token,
        clinicDocId: widget.clinicDocId,
      ),
      Medication(
        token: widget.token,
        recommend: recommend,
        getAdvices: (v) {
          advices = v;
        },
      )
    ];
    return tabpages;
  }

  final tabs = <Tab>[
    Tab(
      text: 'Symptom',
    ),
    Tab(
      text: 'Examination',
    ),
    Tab(
      text: 'Diagnosis',
    ),
    Tab(
      text: 'Medication',
    )
  ];
  var scrollDirection = Axis.horizontal;

  List<PatientsVisitData> pdo = [];

  Future<List<PatientsVisitData>> getDataPd(PatientsVisitDB patient) async {
    print("General Details");
    List<PatientsVisitData> pd = await patient.checkPatient(widget.token.guid);
    print(pd);
    setState(() {
      pdo = pd;
    });
    return pd;
  }

  Widget getDesigns(PatientsVisitDB patient) {
    switch (_currentIndex) {
      case 0:
        return GeneralDetails(
            token: widget.token, patientVisit: patient, temp: "109");
      case 1:
        return ExamNotice(
          token: widget.token,
          patientVisit: patient,
          pd: pdo,
        );
      case 2:
        return DiagnosisNotice(
          token: widget.token,
          patientVisit: patient,
          pd: pdo,
        );
      default:
        return Container();
    }
  }

  PatientsVisitDB pq;

  @override
  Widget build(BuildContext context) {
    print(tabController.index);
    final patient = Provider.of<PatientsVisitDB>(context);
    final tokenDB = Provider.of<TokenDB>(context);
    final recommend = Provider.of<RecommendationDB>(context);
    setState(() {
      pq = patient;
    });
    return Scaffold(
        body: PageView(
          scrollDirection: scrollDirection,
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        color: grey300,
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: green),
                                  child: Center(
                                    child: Text(
                                      widget.token.tokenno.toString(),
                                      style: TextStyle(color: white),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(widget.token.name),
                              ],
                            ),
                            Text(widget.token.age.toString() + " years"),
                            // SizedBox(
                            //       width: 5,
                            //     ),
                            Text(widget.token.gender ?? 'MALE'),
                          ],
                        ),
                      ),
                    ],
                  ),
                  getDesigns(patient),
                  TabBar(
                    onTap: (value) {
                      setState(() {
                        getDesigns(patient);
                        getDataPd(patient);
                        getExamCount(patient);
                      });
                    },
                    controller: tabController,
                    tabs: tabs,
                    labelColor: black,
                    isScrollable: true,
                    physics: AlwaysScrollableScrollPhysics(),
                    dragStartBehavior: DragStartBehavior.down,
                  ),
                  DefaultTabController(
                      initialIndex: 0,
                      length: tabs.length,
                      // initialIndex: 0,
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Flexible(
                              fit: FlexFit.loose,
                              child: TabBarView(
                                  controller: tabController,
                                  physics: ScrollPhysics(),
                                  children: tabsFun(context, recommend)),
                            )
                          ],
                        ),
                      ))
                ],
              ),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            patient.updateCompleteStatus(widget.token.guid);
            tokenDB.updateCompleteStatus(widget.token.guid);
            setState(() {});
            changeScreen(
                context,
                PatientReport(
                  patientId: widget.token.guid,
                  token: widget.token,
                  advices: advices,
                ));
          },
          child: Icon(Icons.print, color: Colors.white),
        ));
  }
}

/*
final upperDesign3 = Container(
    color: Colors.teal,
    child: Column(
      // mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('Similar Patients'),
              Text('Treatment Time'),
              Text('Success Rate'),
              Text('Side Effects'),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('121'),
              Text('6-10 Days'),
              Text('95%'),
              Text('3%')
            ],
          ),
        ),
      ],
    ),
  );

  final upperDesign1 = Container(
    child: Column(
      // mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Center(child: Text('Brief History')),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('Asthama (2 Months)'),
            Text('HyperTension (6 Months)'),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('Asthama (2 Months)'),
            Text('HyperTension (6 Months)'),
          ],
        ),
      ],
    ),
  );

*/
