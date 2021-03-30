import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:getcure_doctor/Database/MedicinesTable.dart';
import 'package:getcure_doctor/Database/PatientsVisitTable.dart';
import 'package:getcure_doctor/Helpers/AppConfig/colors.dart';
import 'package:getcure_doctor/Models/DoctorLogin.dart';
import 'package:getcure_doctor/Models/PatientsVisitTableModels.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectMedicine extends StatefulWidget {
  final Medicine medicine;
  final String pId;
  final int docId;
  final VoidCallback fun;
  final String disease;
  final PatientsVisitDB pv;
  SelectMedicine(
      {Key key,
      this.medicine,
      this.docId,
      this.pv,
      this.pId,
      this.fun,
      this.disease})
      : super(key: key);

  @override
  _SelectMedicineState createState() => _SelectMedicineState();
}

class _SelectMedicineState extends State<SelectMedicine> {
  ClinicDoctor doc;
  getParameters() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String doctors = pref.getString('dresponse');
    DoctorLogin docUser = DoctorLogin.fromJson(json.decode(doctors));

    setState(() {
      doc = docUser.data.clinicDoctor
          .where((element) => element.id == widget.docId)
          .first;
      dose = doc.medicineDoses;
      _dose = widget.medicine.defaultDose;
      unit = doc.medicineUnits;
      _unit=widget.medicine.defaultUnit;
      route = doc.medicineRoutes;
      _route=widget.medicine.defaultRoute;
      frequency = doc.medicineFrequencies;
      _frequency=widget.medicine.defaultFrequency;
      directions = doc.medicineDirections;
      _directions=widget.medicine.defaultDirection;
      duration = doc.medicineDurations;
      _duration=widget.medicine.defaultDuration;
      category = doc.medicineCategories;
      
    });
  }

  @override
  void initState() {
    super.initState();
    getParameters();
  }

  List<String> dose = [];
  List<String> unit = [];
  List<String> category = [];
  List<String> route = [];
  List<String> frequency = [];
  List<String> directions = [];
  List<String> duration = [];

  // TextEditingController _name = new TextEditingController();
  // TextEditingController _composition = new TextEditingController();
  // TextEditingController _drug = new TextEditingController();
  // String _category;
  String _dose;
  String _unit;
  String _route;
  String _frequency;
  String _directions;
  String _duration;
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Center(child: Text('Medicine')),
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      children: [
        Text(
            widget.medicine.title +
                " " +
                widget.medicine.salt +
                " " +
                // widget.medicine.interactionDrugs +
                " " +
                widget.medicine.defaultUnit,
            overflow: TextOverflow.ellipsis,
            maxLines: 3),
        Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Default Parameters",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        DropdownButton<String>(
          items: dose.map((String value) {
            return new DropdownMenuItem<String>(
              value: value,
              child: new Text(value),
            );
          }).toList(),
          isExpanded: true,
          hint: Text('Select Dose'),
          value: _dose,
          onChanged: (val) {
            setState(() {
              _dose = val;
            });
          },
        ),
        DropdownButton<String>(
          items: unit.map((String value) {
            return new DropdownMenuItem<String>(
              value: value,
              child: new Text(value),
            );
          }).toList(),
          hint: Text('Select Unit'),
          isExpanded: true,
          value: _unit,
          onChanged: (val) {
            setState(() {
              _unit = val;
            });
          },
        ),
        DropdownButton<String>(
          items: route.map((String value) {
            return new DropdownMenuItem<String>(
              value: value,
              child: new Text(value),
            );
          }).toList(),
          hint: Text('Select Route'),
          isExpanded: true,
          value: _route,
          onChanged: (val) {
            setState(() {
              _route = val;
            });
          },
        ),
        DropdownButton<String>(
          items: directions.map((String value) {
            return new DropdownMenuItem<String>(
              value: value,
              child: new Text(value),
            );
          }).toList(),
          hint: Text('Select Direction'),
          isExpanded: true,
          value: _directions,
          onChanged: (val) {
            setState(() {
              _directions = val;
            });
          },
        ),
        DropdownButton<String>(
          items: frequency.map((String value) {
            return new DropdownMenuItem<String>(
              value: value,
              child: new Text(value),
            );
          }).toList(),
          hint: Text('Select Frequency'),
          isExpanded: true,
          value: _frequency,
          onChanged: (val) {
            setState(() {
              _frequency = val;
            });
          },
        ),
        DropdownButton<String>(
          items: duration.map((String value) {
            return new DropdownMenuItem<String>(
              value: value,
              child: new Text(value),
            );
          }).toList(),
          hint: Text('Select Duration'),
          isExpanded: true,
          value: _duration,
          onChanged: (val) {
            setState(() {
              _duration = val;
            });
          },
        ),
        FlatButton(
          textColor: white,
          onPressed: () async {
            PrescribedMedicines pm = PrescribedMedicines(
                title:
                    widget.medicine.title ?? widget.medicine.defaultDirection,
                direction: _directions ?? widget.medicine.defaultDirection,
                dose: _dose ?? widget.medicine.defaultDose,
                duration: _duration ?? widget.medicine.defaultDuration,
                frequency: _frequency ?? widget.medicine.defaultFrequency,
                medicineId: widget.medicine.id,
                route: _route ?? widget.medicine.defaultRoute,
                unit: _unit ?? widget.medicine.defaultUnit);
            var p = await widget.pv.checkPatient(widget.pId);
            widget.pv.updateMedication(p.last, widget.disease, pm);
            Navigator.pop(context);
            widget.fun();
          },
          child: Text("Done"),
          color: green,
        )
      ],
    );
  }
}
