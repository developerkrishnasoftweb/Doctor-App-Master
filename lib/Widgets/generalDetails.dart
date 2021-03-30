import 'package:flutter/material.dart';
import 'package:getcure_doctor/Database/PatientsVisitTable.dart';
import 'package:getcure_doctor/Database/TokenTable.dart';
import 'package:getcure_doctor/Helpers/AppConfig/colors.dart';
import 'package:getcure_doctor/Widgets/VitalInfoEntry.dart';

class GeneralDetails extends StatefulWidget {
  final Token token;
  final String temp;
  final PatientsVisitDB patientVisit;
  GeneralDetails({Key key, this.temp, this.token, this.patientVisit})
      : super(key: key);

  @override
  _GeneralDetailsState createState() => _GeneralDetailsState();
}

class _GeneralDetailsState extends State<GeneralDetails> {
  String temp;
  String bp;
  String pulse;
  String weight;

  getData() async {
    print("General Details");
    List<PatientsVisitData> pd =
        await widget.patientVisit.checkPatient(widget.token.guid);
    print(pd);
    setState(() {
      temp = tempController.text = pd.last.temperature.toString();
      bp = bpController.text = pd.last.bp.toString();
      pulse = pulseController.text = pd.last.pulse.toString();
      weight = weightController.text = pd.last.weight.toString();
    });
  }

  TextEditingController tempController = TextEditingController();
  TextEditingController bpController = TextEditingController();
  TextEditingController pulseController = TextEditingController();
  TextEditingController weightController = TextEditingController();

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Container(
        // height: 90,
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          // shrinkWrap: true,
          // scrollDirection: Axis.horizontal,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return VitalEntry(
                          patientVisit: widget.patientVisit,
                          token: widget.token,
                          bp: bp,
                          temp: temp,
                          pulse: pulse,
                          weight: weight,
                          fun: () => getData(),
                        );
                      });
                },
                child: Container(
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
                            child: Text("ᶿF",
                                style: TextStyle(color: white, fontSize: 15.0)),
                          ),
                        ),
                      ),
                      Positioned(
                          top: 24.0,
                          left: 25.0,
                          child: Container(
                              height: 30,
                              width: 30,
                              child: Image.asset(
                                "images/tempPic.png",
                                fit: BoxFit.cover,
                              )),),
                      Positioned(
                        left: 50.0,
                        child: Center(
                            // child: TextFormField(
                            //   style: TextStyle(fontSize: 12.0, color: white),
                            //   controller: tempController,
                            //   enabled: true,
                            //   textAlign: TextAlign.center,
                            //   // initialValue: widget.temp,
                            //   onChanged: (val) async {
                            //     setState(() {
                            //       temp = val;
                            //     });
                            //     var pv = await widget.patientVisit
                            //         .checkPatient(widget.token.guid);

                            //     // widget.patientVisit.updateTemp(pv.last, temp);
                            //   },
                            // ),
                            child: Text(
                              tempController.text,
                              style: TextStyle(color: black, fontSize:17,backgroundColor: orangef),
                            ),
                        
                        ),
                      ),
                      Positioned(
                          top: 45.0,
                          left: 10.0,
                          child: Text('Temp', style: TextStyle(fontSize: 20.0)))
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return VitalEntry(
                          patientVisit: widget.patientVisit,
                          token: widget.token,
                          bp: bp,
                          temp: temp,
                          pulse: pulse,
                          weight: weight,
                          fun: () => getData(),
                        );
                      });
                },
                child: Container(
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
                            child: Text("mm\nHg",
                                style: TextStyle(color: white, fontSize: 11.0)),
                          ),
                        ),
                      ),
                      Positioned(
                          top: 22.0,
                          left: 35.0,
                          child: Container(
                              height: 32,
                              width: 32,
                              child: Image.asset(
                                "images/bp.png",
                                fit: BoxFit.cover,
                              )),),
                      Positioned(
                        left: 33.0,
                        child: Center(
                          child: Text(
                            bpController.text,
                            style: TextStyle(color: black, fontSize:17,backgroundColor: orangef),
                          ),
                          // child: TextField(
                          //   style: TextStyle(fontSize: 12.0, color: white),
                          //   controller: bpController,

                          //   // autofocus: false,
                          //   // focusNode: FocusNode(canRequestFocus: false),

                          //   // enabled: true,
                          //   textAlign: TextAlign.center,
                          //   onChanged: (val) async {
                          //     setState(() {
                          //       bp = val;
                          //     });
                          //     var pv = await widget.patientVisit
                          //         .checkPatient(widget.token.guid);
                          //     widget.patientVisit.updateBP(pv.last, bp);
                          //   },
                          // ),
                        ),
                      ),
                      Positioned(
                          top: 50.0,
                          left: 30.0,
                          child: Text('B.P', style: TextStyle(fontSize: 20.0)))
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return VitalEntry(
                          patientVisit: widget.patientVisit,
                          token: widget.token,
                          bp: bp,
                          temp: temp,
                          pulse: pulse,
                          weight: weight,
                          fun: () => getData(),
                        );
                      });
                },
                child: Container(
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
                            child: Text("bpm",
                                style: TextStyle(color: white, fontSize: 11.0)),
                          ),
                        ),
                      ),
                      Positioned(
                          top: 24.0, left:27.0, child: Center(
                    child: Container(
                        height: 30,
                        width: 30,
                        child: Image.asset(
                          "images/pulseIcon.png",
                          fit: BoxFit.cover,
                        )),
                  ),),
                      Positioned(
                        left: 50.0,
                        child: Center(
                          // child: TextField(
                          //   controller: pulseController,
                          //   // autofocus: false,
                          //   // focusNode: FocusNode(canRequestFocus: false),
                          //   style: TextStyle(fontSize: 12.0, color: white),
                          //   // enabled: true,
                          //   textAlign: TextAlign.center,
                          //   onChanged: (val) async {
                          //     setState(() {
                          //       pulse = val;
                          //     });
                          //     var pv = await widget.patientVisit
                          //         .checkPatient(widget.token.guid);
                          //     // widget.patientVisit.updatePulse(pv.last, pulse);
                          //   },
                          // ),
                          child: Text(
                            pulseController.text,
                            style: TextStyle(color: black, fontSize:17,backgroundColor: orangef),
                          ),
                        ),
                      ),
                      Positioned(
                          top: 50.0,
                          left: 10.0,
                          child:
                              Text('Pulse', style: TextStyle(fontSize: 20.0)))
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return VitalEntry(
                          patientVisit: widget.patientVisit,
                          token: widget.token,
                          bp: bp,
                          temp: temp,
                          pulse: pulse,
                          weight: weight,
                          fun: () => getData(),
                        );
                      });
                },
                child: Container(
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
                            child: Text("Kg",
                                style: TextStyle(color: white, fontSize: 11.0)),
                          ),
                        ),
                      ),
                      Positioned(
                          top: 24.0, left: 30.0, child:Container(
                              height: 27,
                              width: 27,
                              child: Image.asset(
                                "images/weighticon.png",
                                fit: BoxFit.cover,
                              )),),
                      Positioned(
                        left: 50.0,
                        child: Center(
                          // child: TextField(
                          //   controller: weightController,
                          //   // focusNode: FocusNode(canRequestFocus: false),
                          //   // autofocus: false,
                          //   style: TextStyle(fontSize: 12.0, color: white),
                          //   // enabled: true,
                          //   textAlign: TextAlign.center,
                          //   onChanged: (val) async {
                          //     setState(() {
                          //       weight = val;
                          //     });
                          //     var pv = await widget.patientVisit
                          //         .checkPatient(widget.token.guid);
                          //     // widget.patientVisit
                          //     //     .updateWeight(pv.last, weight);
                          //   },
                          // ),
                          child: Text(
                            weightController.text,
                            style: TextStyle(color: black, fontSize:17,
                            backgroundColor: orangef,
                            
                             ),
                          ),
                        ),
                      ),
                      Positioned(
                          top: 47.0,
                          left: 10.0,
                          child:
                              Text('Weight', style: TextStyle(fontSize: 20.0)))
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
