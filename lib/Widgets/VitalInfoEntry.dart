import 'package:flutter/material.dart';
import 'package:getcure_doctor/Database/PatientsVisitTable.dart';
import 'package:getcure_doctor/Database/TokenTable.dart';
import 'package:getcure_doctor/Helpers/AppConfig/colors.dart';

class VitalEntry extends StatefulWidget {
  final Token token;
  final PatientsVisitDB patientVisit;
  final String temp;
  final String bp;
  final String pulse;
  final String weight;
  final VoidCallback fun;
  VitalEntry(
      {Key key,
      this.token,
      this.patientVisit,
      this.temp,
      this.bp,
      this.pulse,
      this.weight,
      this.fun})
      : super(key: key);

  @override
  _VitalEntryState createState() => _VitalEntryState();
}

class _VitalEntryState extends State<VitalEntry> {
  TextEditingController tempController;
  TextEditingController bpController;
  TextEditingController lbpController;
  TextEditingController pulseController;
  TextEditingController weightController;
  @override
  void initState() {
    tempController = TextEditingController(text: widget.temp);
    bpController = TextEditingController(text: widget.bp.split('/')[0]);
    lbpController = TextEditingController(text: widget.bp.split('/')[1]);
    pulseController = TextEditingController(text: widget.pulse);
    weightController = TextEditingController(text: widget.weight);
    super.initState();
  }

  updateInfo() async {
    var pv = await widget.patientVisit.checkPatient(widget.token.guid);
    widget.patientVisit.updateBP(
        pv.last,
         lbpController.text + "/" +bpController.text,
        pulseController.text,
        tempController.text,
        weightController.text);
        widget.fun();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Vital Signs'),
          IconButton(
              icon: Icon(Icons.cancel), onPressed: () => Navigator.pop(context))
        ],
      ),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: TextField(
            keyboardType: TextInputType.number,
            maxLength: 5,
            decoration: InputDecoration(
                labelText: 'Temperature in Fahrenheit',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 5.0),
                )),
            controller: tempController,
            // autofocus: false,
            // focusNode: FocusNode(canRequestFocus: false),
            // enabled: true,
            // onChanged: (val) async {
            //   setState(() {
            //     // bp = val;
            //   });
            //   var pv =
            //       await widget.patientVisit.checkPatient(widget.token.guid);
            //   // widget.patientVisit.updateBP(pv.last, bp);
            // },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: TextField(
            keyboardType: TextInputType.number, maxLength: 3,
            decoration: InputDecoration(
                labelText: 'SYSTOLIC mm hg (upper BP)',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 5.0),
                )),
            controller: bpController,
            // autofocus: false,
            // focusNode: FocusNode(canRequestFocus: false),
            // enabled: true,
            // onChanged: (val) async {
            //   setState(() {
            //     // bp = val;
            //   });
            //   var pv =
            //       await widget.patientVisit.checkPatient(widget.token.guid);
            //   // widget.patientVisit.updateBP(pv.last, bp);
            // },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: TextField(
            keyboardType: TextInputType.number,
            maxLength: 3,
            decoration: InputDecoration(
                labelText: 'DIASTOLIC mm hg (lower BP)',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 5.0),
                )),
            controller: lbpController,
            // autofocus: false,
            // focusNode: FocusNode(canRequestFocus: false),
            // enabled: true,
            // onChanged: (val) async {
            //   setState(() {
            //     // bp = val;
            //   });
            //   var pv =
            //       await widget.patientVisit.checkPatient(widget.token.guid);
            //   // widget.patientVisit.updateBP(pv.last, bp);
            // },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: TextField(
            keyboardType: TextInputType.number,
            maxLength: 3,
            decoration: InputDecoration(
                labelText: 'Pulse in bpm',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 5.0),
                )),
            controller: pulseController,
            // autofocus: false,
            // focusNode: FocusNode(canRequestFocus: false),
            // enabled: true,
            // onChanged: (val) async {
            //   setState(() {
            //     // bp = val;
            //   });
            //   var pv =
            //       await widget.patientVisit.checkPatient(widget.token.guid);
            //   // widget.patientVisit.updateBP(pv.last, bp);
            // },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: TextField(
            keyboardType: TextInputType.number, maxLength: 5,
            decoration: InputDecoration(
                labelText: 'Weight in Kg',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 5.0),
                )),
            controller: weightController,
            // autofocus: false,
            // focusNode: FocusNode(canRequestFocus: false),
            // enabled: true,
            // onChanged: (val) async {
            //   setState(() {
            //     // bp = val;
            //   });
            //   var pv =
            //       await widget.patientVisit.checkPatient(widget.token.guid);
            //   // widget.patientVisit.updateBP(pv.last, bp);
            // },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: FlatButton(
            onPressed: () {
              updateInfo();

              Navigator.pop(context);
              
            },
            child: Text("Save"),
            textColor: white,
            color: green,
          ),
        )
      ],
    );
  }
}
