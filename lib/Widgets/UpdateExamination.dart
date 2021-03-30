import 'package:flutter/material.dart';
import 'package:getcure_doctor/Database/ExaminationTable.dart';
import 'package:getcure_doctor/Helpers/AppConfig/colors.dart';
import 'package:getcure_doctor/Widgets/LabTest.dart';

class UpdateExamination extends StatefulWidget {
  final Examination examination;
  UpdateExamination({Key key, this.examination}) : super(key: key);

  @override
  _UpdateExaminationState createState() => _UpdateExaminationState();
}

class _UpdateExaminationState extends State<UpdateExamination> {
  TextEditingController _title;

  @override
  void initState() {
    super.initState();
    _title = TextEditingController(text: widget.examination.title);
  }

  TextEditingController _pname = new TextEditingController();
  TextEditingController _lbr = new TextEditingController();
  TextEditingController _hbr = new TextEditingController();
  TextEditingController _unit = new TextEditingController();

  TextEditingController _sample = new TextEditingController();
  TextEditingController _method = new TextEditingController();
  String _selectedbio;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(child: Text('Update Examination')),
          InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.close))
        ],
      ),
      actions: [
        Container(
          height: MediaQuery.of(context).size.height * 0.7,
          width: MediaQuery.of(context).size.width * 0.8,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 45.0,
                  margin: EdgeInsets.all(8),
                  child: TextFormField(
                    decoration: new InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: orange),
                      ),
                      labelText: 'Sample Test',
                      hintText: 'Sample Test',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    controller: _title,
                  ),
                ),
                ListView.builder(
                  itemCount: widget.examination.parameters.data.length,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return ExpansionTile(
                      title:
                          Text(widget.examination.parameters.data[index].title),
                      children: [
                        Container(
                            padding: EdgeInsets.all(10.0),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  height: 45.0,
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter some text';
                                      }
                                      return null;
                                    },
                                    decoration: new InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: blue),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: blue),
                                      ),
                                      hintText: 'Parameter Name',
                                    ),
                                    initialValue: widget.examination.parameters
                                        .data[index].title,
                                  ),
                                ),

                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        width: 100.0,
                                        height: 45.0,
                                        child: TextFormField(
                                          decoration: new InputDecoration(
                                              enabledBorder: OutlineInputBorder(
                                                borderSide:
                                                    BorderSide(color: blue),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide:
                                                    BorderSide(color: blue),
                                              ),
                                              hintText: 'Sample',
                                              labelStyle:
                                                  TextStyle(color: grey)),
                                          initialValue: widget.examination
                                              .parameters.data[index].sample,
                                        ),
                                      ),
                                      Container(
                                        width: 100.0,
                                        height: 45.0,
                                        child: TextFormField(
                                          decoration: new InputDecoration(
                                              enabledBorder: OutlineInputBorder(
                                                borderSide:
                                                    BorderSide(color: blue),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide:
                                                    BorderSide(color: blue),
                                              ),
                                              hintText: 'Method',
                                              labelStyle:
                                                  TextStyle(color: grey)),
                                          initialValue: widget.examination
                                              .parameters.data[index].method,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                SizedBox(
                                  height: 5.0,
                                ),
                                widget.examination.parameters.data[index]
                                            .type ==
                                        'numeric'
                                    ? Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Container(
                                          height: 45.0,
                                          child: TextFormField(
                                              validator: (value) {
                                                if (value.isEmpty) {
                                                  return 'Please enter some text';
                                                }
                                                return null;
                                              },
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: new InputDecoration(
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide:
                                                        BorderSide(color: blue),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide:
                                                        BorderSide(color: blue),
                                                  ),
                                                  hintText:
                                                      "Low Biological Ref Interval"),
                                              initialValue: widget
                                                  .examination
                                                  .parameters
                                                  .data[index]
                                                  .references
                                                  .first),
                                        ),
                                      )
                                    : Container(),

                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Container(
                                    height: 45.0,
                                    child: widget.examination.parameters
                                                .data[index].type ==
                                            "numeric"
                                        ? TextFormField(
                                            validator: (value) {
                                              if (value.isEmpty) {
                                                return 'Please enter some text';
                                              }
                                              return null;
                                            },
                                            keyboardType: TextInputType.number,
                                            decoration: new InputDecoration(
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide:
                                                      BorderSide(color: blue),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide:
                                                      BorderSide(color: blue),
                                                ),
                                                // hintText: widget.val2,
                                                hintText:
                                                    "High Biological Ref Interval"),
                                            initialValue: widget
                                                .examination
                                                .parameters
                                                .data[index]
                                                .references
                                                .last)
                                        : Row(
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.5,
                                                child: TextFormField(
                                                  // validator: (value) {
                                                  //   if (value.isEmpty) {
                                                  //     return 'Please enter some text';
                                                  //   }
                                                  //   return null;
                                                  // },
                                                  decoration:
                                                      new InputDecoration(
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: blue),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: blue),
                                                    ),
                                                    hintText:
                                                        "Enter Result Type",
                                                  ),
                                                  controller: _hbr,
                                                ),
                                              ),
                                              IconButton(
                                                  icon: Icon(Icons.add_circle),
                                                  onPressed: () {
                                                    // test.addReference(_hbr.text);
                                                    setState(() {});
                                                    _hbr.clear();
                                                  })
                                            ],
                                          ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Container(
                                    height: 45.0,
                                    child: widget.examination.parameters
                                                .data[index].type ==
                                            'numeric'
                                        ? TextFormField(
                                            validator: (value) {
                                              if (value.isEmpty) {
                                                return 'Please enter some text';
                                              }
                                              return null;
                                            },
                                            decoration: new InputDecoration(
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide:
                                                      BorderSide(color: blue),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide:
                                                      BorderSide(color: blue),
                                                ),
                                                hintText: "Unit"
                                                // hintText: widget.val3,
                                                // labelText: widget.val3,
                                                ),
                                            initialValue: widget.examination
                                                .parameters.data[index].unit,
                                          )
                                        : DropdownButton(
                                            value: _selectedbio,
                                            isExpanded: true,
                                            hint: Text('Select Bio References'),
                                            elevation: 16,
                                            style: TextStyle(color: black),
                                            isDense: true,
                                            onChanged: (newValue) {
                                              setState(() {
                                                _selectedbio = newValue;
                                                widget
                                                        .examination
                                                        .parameters
                                                        .data[index]
                                                        .bioReference
                                                        .contains(newValue)
                                                    ? widget
                                                        .examination
                                                        .parameters
                                                        .data[index]
                                                        .bioReference
                                                        .remove(newValue)
                                                    : widget
                                                        .examination
                                                        .parameters
                                                        .data[index]
                                                        .bioReference
                                                        .add(newValue);
                                              });
                                            },
                                            items: widget.examination.parameters
                                                .data[index].references
                                                .map((dynamic val) {
                                              return DropdownMenuItem(
                                                child: ListTile(
                                                  leading: widget
                                                          .examination
                                                          .parameters
                                                          .data[index]
                                                          .bioReference
                                                          .contains(val)
                                                      ? Icon(Icons
                                                          .radio_button_checked)
                                                      : Icon(Icons
                                                          .radio_button_unchecked),
                                                  title: Text(val),
                                                ),
                                                value: val,
                                              );
                                            }).toList(),
                                          ),
                                  ),
                                ),

                                RaisedButton(
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(width: 50.0),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    color: purple,
                                    child: Text('Add More'),
                                    onPressed: () {
                                      // _formKey.currentState.save();
                                      // if (_formKey.currentState.validate()) {
                                      //   widget.paraName == 'numeric'
                                      //       ? test.addParameter(new ParameterData(
                                      //           title: _pname.text,
                                      //           sample: _sample.text,
                                      //           method: _method.text,
                                      //           references: [_lbr.text, _hbr.text],
                                      //           bioReference: [],
                                      //           unit: _unit.text,
                                      //           type: widget.paraName))
                                      //       : test.addParameter(new ParameterData(
                                      //           title: _pname.text,
                                      //           sample: _sample.text,
                                      //           method: _method.text,
                                      //           references: test.references,
                                      //           unit: _unit.text,
                                      //           bioReference: test.bioReferences,
                                      //           type: widget.paraName));
                                      //   test.bioReferences = [];
                                      //   test.references = [];
                                      //   _lbr.clear();
                                      //   _sample.clear();
                                      //   _method.clear();
                                      //   _pname.clear();
                                      //   _hbr.clear();
                                      //   _unit.clear();
                                      //   setState(() {});
                                      // }
                                    })
                                //   ],
                                // )
                              ],
                            ))
                      ],
                      // trailing: Icon(Icons.arrow_forward_ios),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FlatButton(onPressed: () {}, child: Text("Update"), color: green),
            FlatButton(
              onPressed: () {},
              child: Text("Delete"),
              color: red,
            )
          ],
        )
      ],
    );
  }
}

// class UpdateParameter extends StatefulWidget {
//   UpdateParameter({Key key}) : super(key: key);

//   @override
//   _UpdateParameterState createState() => _UpdateParameterState();
// }

// class _UpdateParameterState extends State<UpdateParameter> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//        child: child,
//     );
//   }
// }
