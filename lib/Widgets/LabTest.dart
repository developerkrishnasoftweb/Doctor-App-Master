import 'package:flutter/material.dart';
import 'package:getcure_doctor/Database/ExaminationTable.dart';
import 'package:getcure_doctor/Helpers/AppConfig/colors.dart';
import 'package:getcure_doctor/provider/ExaminationProvider.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class LabTest extends StatefulWidget {
  final int docId;

  const LabTest({Key key, this.docId}) : super(key: key);

  @override
  _LabTestState createState() => _LabTestState();
}

class _LabTestState extends State<LabTest> with SingleTickerProviderStateMixin {
  final RoundedLoadingButtonController _btnController =
  new RoundedLoadingButtonController();

  TabController controller;
  @override
  void initState() {
    super.initState();
    controller = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  TextEditingController _title = new TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final ex = Provider.of<ExaminationsDB>(context);
    return Consumer<ExaminationProvider>(
      builder: (context, test, child) {
        return AlertDialog(
          titlePadding: EdgeInsets.zero,
          scrollable: true,
          title: Container(
            alignment: Alignment.center,
            color: orangep,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Add Lab Test',
                    style: TextStyle(color: white),
                  ),
                  IconButton(
                      icon: Icon(Icons.cancel),
                      onPressed: () {
                        test.parametersList = [];
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
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 45.0,
                      child: TextFormField(
                        decoration: new InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.orange),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: orange),
                          ),
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
                    SizedBox(
                      height: 20.0,
                    ),
                    TabBar(
                      controller: controller,
                      tabs: <Tab>[
                        Tab(
                          text: 'Numeric Parameter',
                        ),
                        Tab(
                          text: 'Radio Parameter',
                        )
                      ],
                      labelColor: black,
                      isScrollable: true,
                    ),
                    Expanded(
                      child: Container(
                        child: TabBarView(
                          controller: controller,
                          children: <Widget>[
                            NumericParameter(
                              paraName: 'numeric',
                              val1: 'Low Biological Ref Interval',
                              val2: 'High Biological Ref Interval',
                              val3: 'Unit',
                            ),
                            NumericParameter(
                              paraName: 'radio',
                              val1: 'Result Type I',
                              val2: 'Result Type II',
                              val3: 'Biological Reference Interval',
                            ),
                          ],
                        ),
                      ),
                    ),
                    RoundedLoadingButton(
                      width: 80.0,
                      height: 40.0,
                      controller: _btnController,
                      child: Text(
                        'Submit',
                        style: TextStyle(color: white),
                      ),
                      color: blue,
                      onPressed: () {
                        print(test.parametersList.length);
                        ex.insertTask(Examination(
                            clinicDoctorId: 1,
                            doctorId: widget.docId,
                            isOnline: false,
                            price: 200,
                            title: _title.text,
                            parameters:
                            Parameters2(data: test.parametersList)));
                        test.parametersList = [];
                        _title.clear();
                        _btnController.reset();
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ))
          ],
        );
      },
    );
  }
}

class TestNames {
  String sampleTestName;
  String sample;
  String method;
  String numParaName;
  String numLowInterval;
  String numHighInterval;
  String numUnit;
  String radioParaName;
  String result1;
  String result2;
  String radioBioInterval;

  TestNames(
      this.sampleTestName,
      this.sample,
      this.method,
      this.numParaName,
      this.numLowInterval,
      this.numHighInterval,
      this.numUnit,
      this.radioParaName,
      this.result1,
      this.result2,
      this.radioBioInterval);
}

class NumericParameter extends StatefulWidget {
  final String paraName;
  final String val1;
  final String val2;
  final String val3;

  const NumericParameter(
      {Key key, this.paraName, this.val1, this.val2, this.val3})
      : super(key: key);

  @override
  _NumericParameterState createState() => _NumericParameterState();
}

class _NumericParameterState extends State<NumericParameter> {
  TextEditingController _pname = new TextEditingController();
  TextEditingController _lbr = new TextEditingController();
  TextEditingController _hbr = new TextEditingController();
  TextEditingController _unit = new TextEditingController();
  final _formKey = GlobalKey<FormState>();

  TextEditingController _sample = new TextEditingController();
  TextEditingController _method = new TextEditingController();
  String _selectedbio;
  @override
  Widget build(BuildContext context) {
    return Consumer<ExaminationProvider>(builder: (context, test, child) {
      return SingleChildScrollView(
        child: Form(
            key: _formKey,
            child: Container(
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
                        controller: _pname,
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: 100.0,
                            height: 45.0,
                            child: TextField(
                              decoration: new InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: blue),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: blue),
                                  ),
                                  hintText: 'Sample',
                                  labelStyle: TextStyle(color: grey)),
                              controller: _sample,
                            ),
                          ),
                          Container(
                            width: 100.0,
                            height: 45.0,
                            child: TextField(
                              decoration: new InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: blue),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: blue),
                                  ),
                                  hintText: 'Method',
                                  labelStyle: TextStyle(color: grey)),
                              controller: _method,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(
                      height: 5.0,
                    ),
                    widget.paraName == 'numeric'
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
                          keyboardType: TextInputType.number,
                          decoration: new InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: blue),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: blue),
                            ),
                            hintText: widget.val1,
                          ),
                          controller: _lbr,
                        ),
                      ),
                    )
                        : Container(),

                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        height: 45.0,
                        child: widget.paraName == "numeric"
                            ? TextFormField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number,
                          decoration: new InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: blue),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: blue),
                            ),
                            hintText: widget.val2,
                          ),
                          controller: _hbr,
                        )
                            : Row(
                          children: [
                            Container(
                              width:
                              MediaQuery.of(context).size.width * 0.5,
                              child: TextFormField(
                                // validator: (value) {
                                //   if (value.isEmpty) {
                                //     return 'Please enter some text';
                                //   }
                                //   return null;
                                // },
                                decoration: new InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: blue),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: blue),
                                  ),
                                  hintText: "Enter Result Type",
                                ),
                                controller: _hbr,
                              ),
                            ),
                            IconButton(
                                icon: Icon(Icons.add_circle),
                                onPressed: () {
                                  test.addReference(_hbr.text);
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
                        child: widget.paraName == 'numeric'
                            ? TextFormField(
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
                            hintText: widget.val3,
                            // labelText: widget.val3,
                          ),
                          controller: _unit,
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
                              test.bioReferences.contains(newValue)
                                  ? test.bioReferences.remove(newValue)
                                  : test.addBioReference(newValue);
                            });
                          },
                          items: test.references.map((String val) {
                            return DropdownMenuItem(
                              child: ListTile(
                                leading: test.bioReferences.contains(val)
                                    ? Icon(Icons.radio_button_checked)
                                    : Icon(Icons.radio_button_unchecked),
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
                          if (_formKey.currentState.validate()) {
                            widget.paraName == 'numeric'
                                ? test.addParameter(new ParameterData(
                                title: _pname.text,
                                sample: _sample.text,
                                method: _method.text,
                                references: [_lbr.text, _hbr.text],
                                bioReference: [],
                                unit: _unit.text,
                                type: widget.paraName))
                                : test.addParameter(new ParameterData(
                                title: _pname.text,
                                sample: _sample.text,
                                method: _method.text,
                                references: test.references,
                                unit: _unit.text,
                                bioReference: test.bioReferences,
                                type: widget.paraName));
                            test.bioReferences = [];
                            test.references = [];
                            _lbr.clear();
                            _sample.clear();
                            _method.clear();
                            _pname.clear();
                            _hbr.clear();
                            _unit.clear();
                            setState(() {});
                          }
                        })
                    //   ],
                    // )
                  ],
                ))),
      );
    });
  }
}
