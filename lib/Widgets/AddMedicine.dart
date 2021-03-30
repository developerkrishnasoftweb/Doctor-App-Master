import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:getcure_doctor/Database/MedicinesTable.dart';
import 'package:getcure_doctor/Helpers/AppConfig/colors.dart';
import 'package:getcure_doctor/Models/DoctorLogin.dart';
import 'package:getcure_doctor/Models/SyncModels/ParameterUpdate.dart';
import 'package:provider/provider.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddMedicine extends StatefulWidget {
  final String pId;
  final int docId;
  final MedicinesDB database;
  AddMedicine({Key key, this.pId, this.docId, this.database});

  @override
  _AddMedicineState createState() => _AddMedicineState();
}

class _AddMedicineState extends State<AddMedicine> {
  ClinicDoctor doc;

  List<int> selectedItems = [];
  getParameters() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String doctors = pref.getString('parameters');
    ParametersUpdate parametersUpdate =
        ParametersUpdate.fromJson(json.decode(doctors));
    setState(() {
      dose = parametersUpdate.data.dose.map((e) => e.title).toSet().toList();
      unit = parametersUpdate.data.unit.map((e) => e.title).toSet().toList();
      route = parametersUpdate.data.route.map((e) => e.title).toSet().toList();
      frequency =
          parametersUpdate.data.frequency.map((e) => e.title).toSet().toList();
      directions =
          parametersUpdate.data.direction.map((e) => e.title).toSet().toList();
      duration =
          parametersUpdate.data.duration.map((e) => e.title).toSet().toList();
      category =
          parametersUpdate.data.category.map((e) => e.title).toSet().toList();
      _dose = dose.first;
      _unit = unit.first;
      _route = route.first;
      _frequency = frequency.first;
      _directions = directions.first;
      _duration = duration.first;
      _category = category.first;
    });
    print(duration);
  }

  addParameter(String parameter, String type, String value) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String doctors = pref.getString('parameters');
    ParametersUpdate parametersUpdate =
        ParametersUpdate.fromJson(json.decode(doctors));
    switch (type) {
      case 'dose':
        parametersUpdate.data.dose.add(ParameterData(
            isOnline: false,
            title: parameter,
            type: type,
            value: int.parse(value)));
        break;
      case 'unit':
        parametersUpdate.data.unit.add(ParameterData(
            isOnline: false,
            title: parameter,
            type: type,
            value: int.parse(value)));
        break;
      case 'route':
        parametersUpdate.data.route.add(ParameterData(
            isOnline: false,
            title: parameter,
            type: type,
            value: int.parse(value)));
        break;
      case 'frequency':
        parametersUpdate.data.frequency.add(ParameterData(
            isOnline: false,
            title: parameter,
            type: type,
            value: int.parse(value)));
        break;
      case 'directions':
        parametersUpdate.data.direction.add(ParameterData(
            isOnline: false,
            title: parameter,
            type: type,
            value: int.parse(value)));
        break;
      case 'duration':
        parametersUpdate.data.duration.add(ParameterData(
            isOnline: false,
            title: parameter,
            type: type,
            value: int.parse(value)));
        break;
      default:
    }
    print('done');
    pref.remove('parameters');
    pref.setString('parameters', json.encode(parametersUpdate));
    print(pref.getString("parameters"));
    getParameters();
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
  List<String> interactionDrugList = [];
  TextEditingController _name = new TextEditingController();
  TextEditingController _composition = new TextEditingController();
  TextEditingController _drug = new TextEditingController();
  String _category;
  String _dose;
  String _unit;
  String _route;
  String _frequency;
  String _directions;
  String _duration;

  @override
  Widget build(BuildContext context) {
    final med = Provider.of<MedicinesDB>(context);

    return SingleChildScrollView(
      physics: ClampingScrollPhysics(),
      child: AlertDialog(
        titlePadding: EdgeInsets.zero,
        title: Container(
          alignment: Alignment.center,
          color: orangep,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Add Medication',
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
          Container(
            height: MediaQuery.of(context).size.height * 0.7,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Form(
              child: ListView(
                children: [
                  Container(
                    height: 40,
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      controller: _name,
                      decoration: new InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: blue),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: blue),
                        ),
                        labelText: 'Medicine Name',
                      ),
                    ),
                  ),
                  Container(
                    height: 40,
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      controller: _composition,
                      decoration: new InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: blue),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: blue),
                        ),
                        labelText: 'Salt Composition',
                      ),
                    ),
                  ),
                  FutureBuilder(
                      future: med.fetchTask(""),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<Medicine>> snapshot) {
                        if (snapshot.data == null) {
                          return Container(
                            height: 50,
                            child: Center(
                                child: Text(
                              "No Drugs",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                          );
                        } else {
                          for (var i in snapshot.data) {
                            if (!interactionDrugList.contains(i.title))
                              interactionDrugList.add(i.title);
                          }
                          return SearchableDropdown.multiple(
                            items: interactionDrugList.map((String value) {
                              return new DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            selectedItems: selectedItems,
                            dialogBox: false,
                            hint: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12.0, horizontal: 1),
                              child: Text("Severe Interaction Drugs"),
                            ),
                            searchHint: "Severe Interaction\nDrugs",
                            onChanged: (value) {
                              setState(() {
                                selectedItems = value;
                              });
                            },
                            closeButton: (selectedItems) {
                             
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  RaisedButton(
                                      onPressed: () {
                                        setState(() {
                                          selectedItems.clear();
                                          selectedItems.addAll(
                                              Iterable<int>.generate(
                                                      interactionDrugList
                                                          .length)
                                                  .toList());
                                        });
                                      },
                                      child: Text("Select all")),
                                  RaisedButton(
                                      onPressed: () {
                                        setState(() {
                                          selectedItems.clear();
                                        });
                                      },
                                      child: Text("Select none")),
                                ],
                              );
                            },
                            isExpanded: true,
                            menuConstraints:
                                BoxConstraints.tight(Size.fromHeight(350)),
                          );
                        }
                        
                      }),

                  // Text(selectedItems.toString()),
                  // Container(
                  //   height: 40,
                  //   padding: EdgeInsets.symmetric(vertical: 5),
                  //   child: TextFormField(
                  //     validator: (value) {
                  //       if (value.isEmpty) {
                  //         return 'Please enter some text';
                  //       }
                  //       return null;
                  //     },
                  //     controller: _drug,
                  //     decoration: new InputDecoration(
                  //       enabledBorder: OutlineInputBorder(
                  //         borderSide: BorderSide(color: blue),
                  //       ),
                  //       focusedBorder: OutlineInputBorder(
                  //         borderSide: BorderSide(color: blue),
                  //       ),
                  //       labelText: 'Severe Interaction Drugs',
                  //     ),
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButton<String>(
                      items: category.map((String value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      hint: Text('Select Category'),
                      value: _category,
                      elevation: 5,
                      isExpanded: true,
                      onChanged: (val) {
                        setState(() {
                          _category = val;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Default Parameters",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DropdownButton<String>(
                          items: dose.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          hint: Text('Select Dose'),
                          value: _dose,
                          onChanged: (val) {
                            setState(() {
                              _dose = val;
                            });
                          },
                        ),
                        IconButton(
                            icon: Icon(Icons.add_circle),
                            onPressed: () {
                              _addParameter('dose', context);
                            })
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DropdownButton<String>(
                          items: unit.map((String value) {
                            return new DropdownMenuItem<String>(
                              value: value,
                              child: new Text(value),
                            );
                          }).toList(),
                          hint: Text('Select Unit'),
                          value: _unit,
                          onChanged: (val) {
                            setState(() {
                              _unit = val;
                            });
                          },
                        ),
                        IconButton(
                            icon: Icon(Icons.add_circle),
                            onPressed: () {
                              _addParameter('unit', context);
                            })
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DropdownButton<String>(
                          items: route.map((String value) {
                            return new DropdownMenuItem<String>(
                              value: value,
                              child: new Text(value),
                            );
                          }).toList(),
                          hint: Text('Select Route'),
                          value: _route,
                          onChanged: (val) {
                            setState(() {
                              _route = val;
                            });
                          },
                        ),
                        IconButton(
                            icon: Icon(Icons.add_circle),
                            onPressed: () {
                              _addParameter('route', context);
                            })
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DropdownButton<String>(
                          items: frequency.map((String value) {
                            return new DropdownMenuItem<String>(
                              value: value,
                              child: new Text(value),
                            );
                          }).toList(),
                          hint: Text('Select Frequency'),
                          value: _frequency,
                          onChanged: (val) {
                            setState(() {
                              _frequency = val;
                            });
                          },
                        ),
                        IconButton(
                            icon: Icon(Icons.add_circle),
                            onPressed: () {
                              _addParameter('frequency', context);
                            })
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DropdownButton<String>(
                          items: directions.map((String value) {
                            return new DropdownMenuItem<String>(
                              value: value,
                              child: new Text(value),
                            );
                          }).toList(),
                          hint: Text('Select Direction'),
                          value: _directions,
                          onChanged: (val) {
                            setState(() {
                              _directions = val;
                            });
                          },
                        ),
                        IconButton(
                            icon: Icon(Icons.add_circle),
                            onPressed: () {
                              _addParameter('directions', context);
                            })
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DropdownButton<String>(
                          items: duration.map((String value) {
                            return new DropdownMenuItem<String>(
                              value: value,
                              child: new Text(value),
                            );
                          }).toList(),
                          hint: Text('Select Duration'),
                          value: _duration,
                          onChanged: (val) {
                            setState(() {
                              _duration = val;
                            });
                          },
                        ),
                        IconButton(
                            icon: Icon(Icons.add_circle),
                            onPressed: () {
                              _addParameter('duration', context);
                            })
                      ],
                    ),
                  ),
                  FlatButton(
                      onPressed: () {
                        print('hello');
                        print(selectedItems.toString());
                        print(selectedItems.map((e) => interactionDrugList[e]));
                        Medicine medicine = new Medicine(
                            category: _category,
                            clinicDoctorId: widget.docId,
                            defaultDirection: _directions,
                            defaultDose: _dose,
                            defaultDuration: _duration,
                            defaultFrequency: _frequency,
                            defaultRoute: _route,
                            defaultUnit: _unit,
                            doctorId: widget.docId,
                            interactionDrugs: InteractionDruggenerated(
                                interactionDrug: selectedItems
                                    .map((e) => interactionDrugList[e])
                                    .toList()),
                            isOnline: false,
                            salt: _composition.text,
                            title: _name.text);
                        med.insert(medicine);
                        Navigator.pop(context);
                      },
                      color: green,
                      child: Text("SAVE"))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  _addParameter(String type, BuildContext context) {
    TextEditingController _parameter = new TextEditingController();
    TextEditingController _value = new TextEditingController(text: '0');

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text('Add $type'),
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(labelText: 'Enter New $type'),
                controller: _parameter,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(labelText: 'Value'),
                controller: _value,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                  addParameter(_parameter.text, type, _value.text);
                },
                child: Text('Save'),
                color: green,
                textColor: white,
              ),
            ),
          ],
        );
      },
    );
  }
}
