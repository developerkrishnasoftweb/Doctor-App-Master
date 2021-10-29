import 'package:flutter/material.dart';
import 'package:getcure_doctor/Helpers/AppConfig/colors.dart';

String temp;
String bp;
String pulse;
String weight;

class PatientInfo extends StatefulWidget {
  @override
  _PatientInfoState createState() => _PatientInfoState();
}

class _PatientInfoState extends State<PatientInfo>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    super.initState();
    setState(() {
      tabController = TabController(length: 4, vsync: this);
    });
  }

  final controller = PageController(
    initialPage: 0,
  );

  List<Widget> tabsFun(BuildContext context) {
    final tabpages = <Widget>[
      // Symtoms(),
      // Examination(),
      // Center(
      //     child: Icon(
      //   Icons.gavel,
      //   size: 64,
      //   color: orange,
      // )),
      // Medication()
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

  Widget getDesigns() {
    switch (tabController.index) {
      case 0:
        return upperDesign0;
      case 1:
        // changeDesign();
        return upperDesign1;
      case 3:
        return upperDesign3;
      default:
        return upperDesign1;
    }
  }

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

  final upperDesign0 = Container(
      decoration: BoxDecoration(
          border: Border.all(
        color: Colors.black,
      )),
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
              child: CustomBoxes(
            label: "Temp",
            unit: "'F",
            value: "100",
            icon: Icon(
              Icons.accessibility_new,
              size: 30.0,
            ),
          )),
          Flexible(
              child: CustomBoxes(
            label: "B.P",
            unit: "BFG",
            value: "130/80",
            icon: Icon(Icons.accessible, size: 30.0),
          )),
          Flexible(
              child: CustomBoxes(
            label: "Pulse",
            unit: "bpm",
            value: "75",
            icon: Icon(Icons.assessment, size: 30.0),
          )),
          Flexible(
              child: CustomBoxes(
                  label: "Weight",
                  unit: "Kg",
                  value: "71",
                  icon: Icon(Icons.av_timer, size: 30.0))),
        ],
      ));

  @override
  Widget build(BuildContext context) {
    getDesigns();
    return Scaffold(
        //  drawer: DoctorDrawer(),
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: orange,
          ),
          backgroundColor: white,
          actions: <Widget>[
            Row(
              children: <Widget>[
                InkWell(
                    onTap: () {},
                    child: Container(
                      height: 34,
                      width: 34,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: orange,
                      ),
                    )),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                    onTap: () {},
                    child: Container(
                      height: 34,
                      width: 34,
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
        body: PageView(
          controller: controller,
          scrollDirection: scrollDirection,
          children: <Widget>[
            Container(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      color: grey300,
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Icon(Icons.person),
                              SizedBox(
                                width: 5,
                              ),
                              Text('Ajay Kumar'),
                            ],
                          ),
                          Text('25 Years'),
                          Text('Male')
                        ],
                      ),
                    ),
                    if (tabController.index == 0)
                      upperDesign0
                    else if (tabController.index == 1)
                      upperDesign1
                    else if (tabController.index == 3)
                      upperDesign3
                    else
                      upperDesign1,
                    // getDesigns(),
                    DefaultTabController(
                        length: tabs.length,
                        // initialIndex: 0,
                        child: SizedBox(
                          height: 500,
                          child: Column(
                            children: <Widget>[
                              TabBar(
                                onTap: (value) {
                                  setState(() {
                                    getDesigns();
                                  });
                                },
                                controller: tabController,
                                tabs: tabs,
                                labelColor: black,
                                isScrollable: true,
                              ),
                              Expanded(
                                child: TabBarView(
                                    controller: tabController,
                                    children: tabsFun(context)),
                              )
                            ],
                          ),
                        ))
                  ],
                ),
              ),
            )
          ],
        ));
  }
}

class CustomBoxes extends StatefulWidget {
  final String label;
  final String unit;
  final String value;
  final Icon icon;

  CustomBoxes({this.label, this.value, this.unit, this.icon});

  @override
  _CustomBoxesState createState() => _CustomBoxesState();
}

class _CustomBoxesState extends State<CustomBoxes> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Container(
              height: 70.0,
              width: 80.0,
              color: white,
              alignment: Alignment.center),
          ClipRRect(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(70.0),
            ),
            clipBehavior: Clip.hardEdge,
            child: Align(
              heightFactor: 1.0,
              widthFactor: 0.8,
              alignment: Alignment.topRight,
              child: Container(
                padding: const EdgeInsets.all(2.0),
                alignment: Alignment.center,
                color: Colors.grey[700],
                height: 30.0,
                width: 40.0,
                child: Text(widget.unit,
                    style: TextStyle(color: white, fontSize: 11.0)),
              ),
            ),
          ),
          Positioned(top: 24.0, left: 20.0, child: widget.icon),
          Positioned(
            left: 33.0,
            child: ClipOval(
              child: Container(
                alignment: Alignment.center,
                height: 20.0,
                width: 45.0,
                decoration: BoxDecoration(
                  color: orangef,
                ),
                child: Center(
                  child: TextField(
                    style: TextStyle(fontSize: 12.0),
                    enabled: true,
                    textAlign: TextAlign.center,
                    onChanged: (val) {
                      switch (widget.label) {
                        case 'Temp':
                          setState(() {
                            temp = val;
                          });

                          break;
                        case 'B.P':
                          setState(() {
                            bp = val;
                          });
                          break;
                        case 'Pulse':
                          setState(() {
                            pulse = val;
                          });
                          break;
                        case 'Weight':
                          setState(() {
                            weight = val;
                          });
                          break;
                      }
                    },
                  ),
                ),
              ),
            ),
          ),
          Positioned(
              top: 50.0,
              left: 10.0,
              child: Text(widget.label, style: TextStyle(fontSize: 20.0)))
        ],
      ),
    );
  }
}
