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
    //print("General Details");
    List<PatientsVisitData> pd =
    await widget.patientVisit.checkPatient(widget.token.guid);
    //print(pd);
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 4),
                      Text('Temp', style: TextStyle(color: Colors.black, fontSize: 16)),
                      Container(
                          height: 30,
                          width: 30,
                          child: Image.asset(
                            "images/tempPic.png",
                            fit: BoxFit.cover,
                          )),
                      Text(double.parse(tempController.text).toString(),
                          style: TextStyle(color: Colors.black, fontSize: 16,fontWeight: FontWeight.bold)),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      SizedBox(height: 4),
                      Text('B.P', style: TextStyle(color: Colors.black, fontSize: 16)),
                      Container(
                          height: 30,
                          width: 30,
                          child: Image.asset(
                            "images/bp.png",
                            fit: BoxFit.cover,
                          )),
                      Text( bpController.text,
                          style: TextStyle(color: Colors.black, fontSize: 16,fontWeight: FontWeight.bold)),

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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 4),
                      Text('Pulse', style: TextStyle(color: Colors.black, fontSize: 16)),
                      Container(
                          height: 30,
                          width: 30,
                          child: Image.asset(
                            "images/pulseIcon.png",
                            fit: BoxFit.cover,
                          )),
                      Text(pulseController.text,
                          style: TextStyle(color: Colors.black, fontSize: 16,fontWeight: FontWeight.bold)),

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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      SizedBox(height: 4),
                      Text('Weight', style: TextStyle(color: Colors.black, fontSize: 16)),
                      Container(
                          height: 30,
                          width: 30,
                          child: Image.asset(
                            "images/weighticon.png",
                            fit: BoxFit.cover,
                          )),
                      Text(double.parse(weightController.text).toString(),
                          style: TextStyle(color: Colors.black, fontSize: 16,fontWeight: FontWeight.bold)),
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
