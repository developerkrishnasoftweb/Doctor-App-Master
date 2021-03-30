import 'dart:async';
import 'package:flutter/material.dart';
import 'package:getcure_doctor/Database/TokenTable.dart';
import 'package:getcure_doctor/Helpers/AppConfig/colors.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class UpdateBooking extends StatefulWidget {
  final int tokenno;
  final DateTime time;
  final Token token;
  final String initialName;
  final String initialAge;
  final String initialAddress;
  final String initialMob;
  final String initialAppointmentType;
  final String visitType;
  final String initialBookigType;
  final String gender;
  final Function counter;
  final int id;
  final int docId;
  const UpdateBooking({
    Key key,
    this.tokenno,
    this.time,
    this.token,
    this.initialName,
    this.initialAge,
    this.initialAddress,
    this.initialMob,
    this.initialAppointmentType,
    this.visitType,
    this.initialBookigType,
    this.counter,
    this.gender,
    this.id,
    this.docId,
  });
  @override
  _UpdateBookingState createState() => _UpdateBookingState();
}

class _UpdateBookingState extends State<UpdateBooking> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _radioValue; //Initial definition of radio button value
  String _radioValue2;
  String _radioValue3;
  String _radiovalue4;
  String choice;
  String choice2;
  String choice3;
  String choice4;
  String _name;
  String _age;
  String _address;
  String _mobileno;
  bool isEnabled = false;
  FocusNode myFocusNode;

  bool result = false;
  // checkConnection() async {
  //   bool res = await DataConnectionChecker().hasConnection;
  //   print(res);
  //   setState(() {
  //     result = res;
  //   });
  // }

  String _fees;
  @override
  void initState() {
    // checkConnection();

    setState(() {
      _radioValue = widget.initialAppointmentType;
      _radioValue2 = widget.visitType;
      _radioValue3 = widget.initialBookigType;
      _radiovalue4 = widget.gender;
    });
    myFocusNode = FocusNode();
    super.initState();
  }

  void radioButtonChanges(String value) {
    setState(() {
      _radioValue = value;
      switch (value) {
        case 'general':
          choice = value;
          break;
        case 'emergency':
          choice = value;
          break;
        default:
          choice = null;
      }
      debugPrint(choice); //Debug the choice in console
    });
  }

  void radioButtonChanges2(String value) {
    setState(() {
      _radioValue2 = value;
      switch (value) {
        case 'new visit':
          choice2 = value;
          break;
        case 'follow up':
          choice2 = value;
          break;
        default:
          choice2 = null;
      }
      debugPrint(choice2); //Debug the choice in console
    });
  }

  void radioButtonChanges3(String value) {
    setState(() {
      _radioValue3 = value;
      switch (value) {
        case 'walk in':
          choice3 = value;
          break;
        case 'on call':
          choice3 = value;
          break;
        default:
          choice3 = widget.initialBookigType;
      }
      debugPrint(choice3); //Debug the choice in console
    });
  }

  final RoundedLoadingButtonController _btnController =
      new RoundedLoadingButtonController();

  void radioButtonChanges4(String value) {
    setState(() {
      _radiovalue4 = value;
      switch (value) {
        case 'female':
          choice4 = value;
          break;
        case 'male':
          choice4 = value;
          break;
        default:
          choice4 = null;
      }
      debugPrint(choice4); //Debug the choice in console
    });
  }

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<TokenDB>(context);
    _fees = widget.token.fees.toString();

    return SimpleDialog(
      elevation: 20,
      titlePadding: EdgeInsets.zero,
      title: Container(
        color: orangep,
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                'Update Details',
                style: TextStyle(color: white),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width<=360.0? MediaQuery.of(context).size.width*0.10
                :MediaQuery.of(context).size.width* .17,
              ),
              IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    setState(() {
                      isEnabled = true;
                      myFocusNode.requestFocus();
                    });
                  }),
              IconButton(
                  icon: Icon(Icons.cancel),
                  onPressed: () => Navigator.pop(context))
            ],
          ),
        ),
      ),
      children: <Widget>[
        Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8),
                    child: TextFormField(
                      autofocus: true,
                      focusNode: myFocusNode,
                      enabled: isEnabled,
                      initialValue: widget.initialName,
                      decoration: InputDecoration(
                        labelText: 'Patients name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      onSaved: (String val) {
                        _name = val;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Cannot be empty';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 2, 8, 2),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      enabled: isEnabled,
                      initialValue: widget.initialAge,
                      decoration: InputDecoration(
                        labelText: 'Age',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      onSaved: (String val) {
                        _age = val;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Cannot be empty';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 2, 8, 2),
                    child: TextFormField(
                      maxLines: 3,
                      enabled: isEnabled,
                      initialValue: widget.initialAddress,
                      decoration: InputDecoration(
                        labelText: 'Address',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      onSaved: (String val) {
                        _address = val;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Cannot be empty';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 2, 8, 2),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      enabled: isEnabled,
                      initialValue: widget.initialMob,
                      decoration: InputDecoration(
                        labelText: 'Mobile Number',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      onSaved: (String val) {
                        _mobileno = val;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Cannot be empty';
                        }
                        if (value.length != 10) {
                          return 'enter a 10 digit number';
                        }
                        return null;
                      },
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 100,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(8.0, 2, 8, 2),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            initialValue: widget.token.fees.toString(),
                            decoration: InputDecoration(
                              labelText: 'Fees',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            onSaved: (String val) {
                              _fees = val;
                            },
                            // validator: (value) {
                            //   if (value.isEmpty) {
                            //     return 'Cannot be empty';
                            //   }
                            //   if (int.parse(value) < 50) {
                            //     return 'Cannot be less than 50';
                            //   }
                            //   return null;
                            // },
                          ),
                        ),
                      ),
                    ],
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                                      child: Row(
                      children: <Widget>[
                        Text('Gender:'),
                        SizedBox(
                          width: 38,
                        ),
                        Radio(
                          activeColor: orangep,
                          value: 'male',
                          groupValue: _radiovalue4,
                          onChanged: radioButtonChanges4,
                        ),
                        Text(
                          "Male",
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Radio(
                          activeColor: orangep,
                          value: 'female',
                          groupValue: _radiovalue4,
                          onChanged: radioButtonChanges4,
                        ),
                        Text(
                          "Female",
                        ),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                                      child: Row(
                      children: <Widget>[
                        Text('Appointment \nType:'),
                        Radio(
                          activeColor: orangep,
                          value: 'general',
                          groupValue: _radioValue,
                          onChanged: radioButtonChanges,
                        ),
                        Text(
                          "general",
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Radio(
                          activeColor: orangep,
                          value: 'emergency',
                          groupValue: _radioValue,
                          onChanged: radioButtonChanges,
                        ),
                        Text(
                          "emergency",
                        ),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                                      child: Row(
                      children: <Widget>[
                        Text('Visit Type:'),
                        SizedBox(
                          width: 20,
                        ),
                        Radio(
                          activeColor: orangep,
                          value: 'new visit',
                          groupValue: _radioValue2,
                          onChanged: radioButtonChanges2,
                        ),
                        Text(
                          "new visit",
                        ),
                        SizedBox(
                          width: 0,
                        ),
                        Radio(
                          activeColor: orangep,
                          value: 'follow up',
                          groupValue: _radioValue2,
                          onChanged: radioButtonChanges2,
                        ),
                        Text(
                          "follow \nup",
                        ),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                                      child: Row(
                      children: <Widget>[
                        Text('Booked Type:'),
                        Radio(
                          activeColor: orangep,
                          value: 'walk in',
                          groupValue: _radioValue3,
                          onChanged: radioButtonChanges3,
                        ),
                        Text(
                          "walk in",
                        ),
                        SizedBox(
                          width: 12.0,
                        ),
                        Radio(
                          activeColor: orangep,
                          value: 'on call',
                          groupValue: _radioValue3,
                          onChanged: radioButtonChanges3,
                        ),
                        Text(
                          "on call",
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Token no \n& Time:'),
                      Text('Token no: ${widget.tokenno.toString()}'),
                      Text(
                          'Time: ${DateFormat.Hm().format(widget.time).toString()}'),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      RoundedLoadingButton(
                        height: 45,
                        width: 140,
                        color: pcolor,
                        child: Text(
                          'Cancel Appointment',
                          style: TextStyle(color: white),
                        ),
                        controller: _btnController,
                        onPressed: () {
                          database.updateData(
                              widget.token.copyWith(
                                booked: false,
                              ),
                              _name);
                          database.insertTask(Token(
                            clinicid: widget.token.clinicid,
                            name: widget.token.name,
                            tokenno: widget.token.tokenno,
                            doctorid: widget.token.doctorid,
                            fees: widget.token.fees,
                            mobileno: widget.token.mobileno,
                            address: widget.token.address,
                            age: widget.token.age,
                            tokentime: widget.token.tokentime,
                            appointmenttype: widget.token.appointmenttype,
                            visittype: widget.token.visittype,
                            bookedtype: widget.token.bookedtype,
                            bookedVia: 'doctor',
                            guid: widget.token.guid,
                            booked: false,
                            cancelled: true,
                          ));
                          setState(() {
                            widget.counter(database);
                          });
                          _btnController.success();
                          Timer(Duration(seconds: 1),
                              () => Navigator.of(context).pop());
                        },
                      ),
                      RoundedLoadingButton(
                        height: 45,
                        width: 120,
                        color: pcolor,
                        child: Text(
                          'Update Data',
                          style: TextStyle(color: white),
                        ),
                        controller: _btnController,
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            database.updateData(
                                widget.token.copyWith(
                                    name: _name,
                                    fees: int.parse(_fees),
                                    mobileno: int.parse(_mobileno),
                                    address: _address,
                                    age: int.parse(_age),
                                    appointmenttype: _radioValue,
                                    visittype: _radioValue2,
                                    bookedtype: _radioValue3,
                                    booked: true,
                                    isOnline: result,
                                    updatedAt: DateTime.now()),
                                _name);
                            _btnController.success();
                            Timer(Duration(seconds: 1),
                                () => Navigator.of(context).pop());
                          } else {
                            _btnController.reset();
                          }
                        },
                      )
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      RoundedLoadingButton(
                        height: 45,
                        width: 140,
                        color: pcolor,
                        child: Text(
                          'update & Present',
                          style: TextStyle(color: white),
                        ),
                        controller: _btnController,
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            database.updateData(
                                widget.token.copyWith(
                                    name: _name,
                                    fees: int.parse(_fees),
                                    mobileno: int.parse(_mobileno),
                                    address: _address,
                                    age: int.parse(_age),
                                    appointmenttype: _radioValue,
                                    visittype: _radioValue2,
                                    bookedtype: _radioValue3,
                                    booked: true,
                                    isPresent: true,
                                    presentTime: DateTime.now(),
                                    isOnline: result,
                                    updatedAt: DateTime.now()),
                                _name);
                            _btnController.success();
                            Timer(Duration(seconds: 1),
                                () => Navigator.of(context).pop());
                          } else {
                            _btnController.reset();
                          }
                        },
                      ),
                      RoundedLoadingButton(
                        height: 45,
                        width: 120,
                        color: pcolor,
                        child: Text(
                          'Print Medicine',
                          style: TextStyle(color: white),
                        ),
                        controller: _btnController,
                        onPressed: () {},
                      )
                    ],
                  )
                ],
              ),
            )),
      ],
    );
  }
}
