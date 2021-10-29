import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:getcure_doctor/Helpers/AppConfig/colors.dart';
import 'package:getcure_doctor/Helpers/Network/Requesthttp.dart';
import 'package:getcure_doctor/Models/StateSearchSuggestion.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class AddClinic extends StatefulWidget {
  final List<StateData> suggestionsstate;

  AddClinic({this.suggestionsstate});

  @override
  _AddClinicState createState() => _AddClinicState(suggestionsstate);
}

class _AddClinicState extends State<AddClinic> {
  List<String> speclist = [];

  _AddClinicState(this.suggestionstate) {
    cityTextField = new AutoCompleteTextField<StateData>(
      decoration: new InputDecoration(
          hintText: "State", suffixIcon: new Icon(Icons.search)),
      itemSubmitted: (item) => setState(() => selected = item),
      key: key,
      suggestions: suggestionstate,
      itemBuilder: (context, suggestion) => new Padding(
          child: new ListTile(
            title: new Text(suggestion.title),
          ),
          padding: EdgeInsets.all(8.0)),
      itemSorter: (a, b) => a.id == b.id
          ? 0
          : a.id > b.id
              ? -1
              : 1,
      itemFilter: (suggestion, input) =>
          suggestion.title.toLowerCase().startsWith(input.toLowerCase()),
    );
  }

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  String startTime;
  String endTime;
  List<StateData> suggestionstate = [];
  GlobalKey key = new GlobalKey<AutoCompleteTextFieldState<StateData>>();
  AutoCompleteTextField<StateData> cityTextField;
  RoundedLoadingButtonController bttncont = RoundedLoadingButtonController();
  StateData selected;
  LocalitySearch lselected;
  TextEditingController _name = TextEditingController();
  TextEditingController _type = TextEditingController();
  TextEditingController _yoe = TextEditingController();
  TextEditingController _nob = TextEditingController();
  TextEditingController _nod = TextEditingController();
  TextEditingController _pincode = TextEditingController();
  TextEditingController _phno = TextEditingController();
  TextEditingController _speciality = TextEditingController();
  TextEditingController _address = TextEditingController();
  TextEditingController _timings = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: orangef,
        actions: <Widget>[],
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pop(context)),
        title: new Text('VISITING CLINIC'),
      ),
      body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 15, left: 15.0),
                  child: TextFormField(
                    enableSuggestions: true,
                    controller: _name,
                    decoration: InputDecoration(
                      labelText: 'Clinic Name',
                    ),
                    validator: (val) {
                      if (val.isEmpty) {
                        return 'Please provide clinic name';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15, left: 15.0),
                  child: TextFormField(
                    enableSuggestions: true,
                    controller: _type,
                    decoration: InputDecoration(
                      labelText: 'Clinic Type',
                    ),
                    validator: (val) {
                      if (val.isEmpty) {
                        return 'Please provide clinic type';
                      }
                      return null;
                    },
                  ),
                ),
                Row(
                  children: [
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 15, left: 15.0),
                        child: TextFormField(
                          enableSuggestions: true,
                          keyboardType: TextInputType.number,
                          controller: _yoe,
                          decoration: InputDecoration(
                              labelText: 'Year of Establishment'),
                          validator: (val) {
                            if (val.isEmpty) {
                              return 'Please provide a year';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 15, left: 15.0),
                        child: TextFormField(
                          enableSuggestions: true,
                          keyboardType: TextInputType.number,
                          controller: _nob,
                          decoration: InputDecoration(labelText: 'No of Beds'),
                          validator: (val) {
                            if (val.isEmpty) {
                              return 'Please provide a year';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15, left: 15.0),
                  child: TextFormField(
                    enableSuggestions: true,
                    keyboardType: TextInputType.number,
                    controller: _nod,
                    decoration: InputDecoration(labelText: 'No of Doctors'),
                    validator: (val) {
                      if (val.isEmpty) {
                        return 'Please provide a year';
                      }
                      return null;
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 20, right: 15, left: 15),
                        child: selected == null
                            ? cityTextField
                            : Column(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        selected.title,
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      IconButton(
                                          icon: Icon(
                                            Icons.cancel,
                                            color: red,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              selected = null;
                                            });
                                          })
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 40.0),
                                    child: Divider(
                                      color: black,
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 15, left: 15.0),
                        child: TextFormField(
                          enableSuggestions: true,
                          keyboardType: TextInputType.number,
                          controller: _pincode,
                          decoration: InputDecoration(labelText: 'Pin Code'),
                          validator: (val) {
                            if (val.isEmpty) {
                              return 'Please provide Area pin code';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15, left: 15.0),
                  child: TextFormField(
                    enableSuggestions: true,
                    keyboardType: TextInputType.number,
                    controller: _phno,
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                    ),
                    validator: (val) {
                      if (val.isEmpty) {
                        return 'Please provide Phone Number';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15, left: 15.0),
                  child: Row(
                    children: [
                      Flexible(
                        child: TextFormField(
                          enableSuggestions: true,
                          controller: _speciality,
                          decoration: InputDecoration(
                            labelText: 'Speciality',
                          ),
                          validator: (val) {
                            if (speclist.length == 0) {
                              return 'Please provide Speciality';
                            }
                            return null;
                          },
                        ),
                      ),
                      Flexible(
                        child: IconButton(
                            icon: Icon(Icons.add_circle_outline),
                            color: orange,
                            onPressed: () {
                              speclist.add(_speciality.text);
                              _speciality.clear();
                              print(speclist);
                            }),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15, left: 15.0),
                  child: TextFormField(
                    enableSuggestions: true,
                    keyboardType: TextInputType.text,
                    controller: _address,
                    maxLines: 3,
                    decoration: InputDecoration(
                      labelText: 'Clinic Address',
                    ),
                    validator: (val) {
                      if (val.isEmpty) {
                        return 'Please provide clinic address';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15, left: 15.0),
                  child: TextFormField(
                    enableSuggestions: true,
                    controller: _timings,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: 'Clinic Timings',
                    ),
                    validator: (val) {
                      if (val.isEmpty) {
                        return 'Please provide clinic address';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RoundedLoadingButton(
                    color: green,
                    controller: bttncont,
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        print('hello');
                        if (await addClinic(
                            _name.text,
                            _type.text,
                            _yoe.text,
                            _nob.text,
                            _nod.text,
                            selected.id,
                            selected.title,
                            _pincode.text,
                            speclist,
                            _address.text,
                            _timings.text,
                            _phno.text)) {
                          bttncont.success();
                        } else {
                          bttncont.reset();
                        }
                      } else {
                        bttncont.stop();
                      }
                    },
                    child: Text(
                      "Save",
                      style: TextStyle(color: white),
                    ),
                  ),
                )
                // Padding(
                //   padding: const EdgeInsets.only(right: 15, left: 15.0),
                //   child: Column(
                //     children: <Widget>[
                //       Row(
                //         children: <Widget>[
                //           Text(
                //             'Clinic Timing',
                //             style: TextStyle(color: grey, fontSize: 16),
                //           ),
                //         ],
                //       ),
                //       Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: <Widget>[
                //           Column(
                //             children: <Widget>[
                //               FlatButton(
                //                   onPressed: () {
                //                     DatePicker.showTimePicker(context,
                //                         showTitleActions: true, onChanged: (date) {
                //                       print('change $date in time zone ' +
                //                           date.timeZoneOffset.inHours.toString());
                //                     }, onConfirm: (date) {
                //                       print('confirm $date');
                //                       setState(() {
                //                         startTime = DateFormat('HH:mm:ss')
                //                             .format(date)
                //                             .toString();
                //                       });
                //                     }, currentTime: DateTime.now());
                //                   },
                //                   child: Text(
                //                     'Opening time',
                //                     style: TextStyle(color: grey),
                //                   )),
                //               startTime == null
                //                   ? Text('data')
                //                   : Text(startTime.toString()),
                //             ],
                //           ),
                //           Column(
                //             children: <Widget>[
                //               FlatButton(
                //                   onPressed: () {
                //                     DatePicker.showTimePicker(context,
                //                         showTitleActions: true, onChanged: (date) {
                //                       print('change $date in time zone ' +
                //                           date.timeZoneOffset.inHours.toString());
                //                     }, onConfirm: (date) {
                //                       print('confirm $date');
                //                       setState(() {
                //                         endTime = DateFormat('HH:mm:ss')
                //                             .format(date)
                //                             .toString();
                //                       });
                //                     }, currentTime: DateTime.now());
                //                   },
                //                   child: Text(
                //                     'Closing time',
                //                     style: TextStyle(color: grey),
                //                   )),
                //               endTime == null ? Text('') : Text(endTime.toString())
                //             ],
                //           ),
                //         ],
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          )),
      // floatingActionButton: FlatButton(
      //     color: orangep,
      //     onPressed: () => Navigator.pop(context),
      //     child: Text(
      //       'Save',
      //       style: TextStyle(color: white),
      //     )),
    );
  }
}

class CitySearch {
  int id;
  String name;

  CitySearch(this.id, this.name);
}

class LocalitySearch {
  int id;
  String name;

  LocalitySearch(this.id, this.name);
}
