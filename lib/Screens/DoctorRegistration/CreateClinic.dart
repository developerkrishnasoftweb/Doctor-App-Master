import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:getcure_doctor/Helpers/AppConfig/colors.dart';
import 'package:getcure_doctor/Helpers/Navigation.dart';
import 'package:getcure_doctor/Helpers/Network/Requesthttp.dart';
import 'package:getcure_doctor/Models/ClinicsByState.dart';
import 'package:getcure_doctor/Models/StateSearchSuggestion.dart';
import 'package:getcure_doctor/Screens/DoctorRegistration/CompleteProfile.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class CreateClinic extends StatefulWidget {
  final List<StateData> suggestionsstate;

  const CreateClinic({Key key, this.suggestionsstate}) : super(key: key);

  @override
  _CreateClinicState createState() => _CreateClinicState(suggestionsstate);
}

class _CreateClinicState extends State<CreateClinic> {
  List<StateData> suggestionstate = [];

  RoundedLoadingButtonController _bttnCont = RoundedLoadingButtonController();

  _CreateClinicState(this.suggestionstate) {
    cityTextField = new AutoCompleteTextField<StateData>(
      decoration: new InputDecoration(
          icon: Icon(Icons.location_on),
          hintText: "Location",
          suffixIcon: new Icon(Icons.search)),
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

  // List<LocationSearch> locationsugg = [
  //   LocationSearch(1, 'kalkaji'),
  //   LocationSearch(3, 'Anand Vihar'),
  //   LocationSearch(2, 'govindpuri')
  // ];

  GlobalKey key = new GlobalKey<AutoCompleteTextFieldState<StateData>>();

  AutoCompleteTextField<StateData> cityTextField;

  String clinicname;
  String clinicnumber;
  String fees;
  String address;
  String phoneNo;
  StateData selected;

  //LocationSearch selected;

  bool _autoValidate = false;
  bool isSelected = false;

  //List<dynamic> timings=timereturn();

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  String validateName(String value) {
    if (value.length < 3)
      return 'Please enter a valid name';
    else
      return null;
  }

  String validateAddress(String value) {
    if (value.length < 3)
      return 'Please enter a valid address';
    else
      return null;
  }

  String validateNumber(String value) {
    if (value.isEmpty)
      return 'Please enter a valid number';
    else
      return null;
  }

  String validateFees(String value) {
    if (value.isEmpty)
      return 'Please enter a valid number';
    else
      return null;
  }

  String validateMobile(String value) {
    if (value.isEmpty) {
      return "Field can't be empty";
    } else if (value.length != 10)
      return 'Mobile Number must be of 10 digit';
    else
      return null;
  }

  void _validateInputs() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      //   if(await addClinic(clinicname,selected.id.toString(),selected.title,double.parse(fees).toString(),double.parse(fees).toString(),address,[], phoneNo)){
      //     changeScreen(context, CompleteProfile());
      //   }else{
      //     changeScreen(context, CreateClinic());
      //   }
      // } else {
      //   setState(() {
      //     _autoValidate = true;
      //   });
    }
  }

  getState() async {
    List<StateData> l = await activeStates();
    setState(() {
      li = l;
    });
  }

  @override
  void initState() {
    super.initState();
    getState();
  }

  List<StateData> li = [];
  List<ClinicsByStateData> clinics = [];
  StateData state;
  ClinicsByStateData _selectedClinic;

  @override
  Widget build(BuildContext context) {
    print("Clinic timings");
    return new Scaffold(
        appBar: new AppBar(
          backgroundColor: orangef,
          actions: <Widget>[
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {},
                  child: IconButton(
                    color: white,
                    icon: Icon(Icons.assignment_turned_in),
                    onPressed: _validateInputs,
                  ),
                ),
              ),
            ),
          ],
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () => Navigator.pop(context)),
          title: new Text('Creating Clinic'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: DropdownButton(
                  hint: Text('Select State'),
                  value: state,
                  isExpanded: true,
                  items: li.map((StateData value) {
                    return DropdownMenuItem(
                      value: value,
                      child: new Text(value.title),
                    );
                  }).toList(),
                  onTap: () {
                    setState(() {
                      _selectedClinic = null;
                      clinics.clear();
                    });
                  },
                  onChanged: (val) async {
                    List<ClinicsByStateData> cbs =
                        await clinicsByState(val.id.toString());

                    setState(() {
                      state = val;
                      clinics = cbs;
                    });
                  },
                ),
              ),
              clinics.length == 0
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 15),
                      child: DropdownButton(
                        hint: Text('Select Clinics by state'),
                        value: _selectedClinic,
                        isExpanded: true,
                        items: clinics.map((ClinicsByStateData value) {
                          return DropdownMenuItem(
                            value: value,
                            child: new Text(value.name),
                          );
                        }).toList(),
                        onChanged: (val) {
                          setState(() {
                            _selectedClinic = val;
                          });
                        },
                      ),
                    ),
              _selectedClinic == null
                  ? Container()
                  : RoundedLoadingButton(
                      color: green,
                      child: Text(
                        "Add clinic",
                        style: TextStyle(color: white),
                      ),
                      controller: _bttnCont,
                      onPressed: () async {
                        bool isAdded =
                            await addClinicByCode(_selectedClinic.getCureCode);
                        if (isAdded) {
                          _bttnCont.success();
                        } else {
                          _bttnCont.error();
                          _bttnCont.reset();
                        }
                      },
                    )
            ],
          ),
        )
        // body: new Container(
        //     padding: new EdgeInsets.all(5.0),
        //     child: new Form(
        //       autovalidate: _autoValidate,
        //       key: this._formKey,
        //       child: new Column(
        //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //         children: <Widget>[
        //           Expanded(
        //             child: ListView(
        //               children: <Widget>[
        //                 new TextFormField(
        //                     keyboardType: TextInputType.text,
        //                     decoration: new InputDecoration(
        //                       icon: Icon(Icons.portrait),
        //                       hintText: 'Your clinic name',
        //                       labelText: 'Clinic Name',
        //                     ),
        //                     validator:validateName,
        //                     onSaved: (String value) {
        //                       clinicname = value;
        //                   }
        //                 ),
        //                 Padding(
        //                   padding: const EdgeInsets.only(top: 10, right: 15),
        //                   child: selected == null
        //                       ? cityTextField
        //                       : Column(
        //                           children: <Widget>[
        //                             Row(
        //                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                               children: <Widget>[
        //                                Row(
        //                                  children: <Widget>[
        //                                     Icon(Icons.location_on,color:grey),
        //                                     SizedBox(width: 12.0,),
        //                                     Text(
        //                                       selected.title,
        //                                       style: TextStyle(fontSize: 15),
        //                                     ),
        //                                  ],
        //                                ),
        //                                 IconButton(
        //                                     icon: Icon(
        //                                       Icons.cancel,
        //                                       color: red,
        //                                     ),
        //                                     onPressed: () {
        //                                       setState(() {
        //                                         selected = null;
        //                                       });
        //                                     })
        //                               ],
        //                             ),
        //                             Padding(
        //                               padding: const EdgeInsets.only(left: 40.0),
        //                               child: Divider(
        //                                 color: black,
        //                               ),
        //                             ),
        //                           ],
        //                         ),
        //                 ),
        //               Padding(
        //                 padding: EdgeInsets.only(top:20.0),
        //               ),
        //               new TextFormField(
        //                     keyboardType: TextInputType.number,
        //                     decoration: new InputDecoration(
        //                       icon: Icon(Icons.confirmation_number),
        //                       hintText: 'Clinic Regsiration Number',
        //                       labelText: 'Clinic Number',
        //                     ),
        //                     validator:validateNumber,
        //                     onSaved: (String value) {
        //                       clinicnumber = value;
        //                   }
        //                 ),
        //                  Padding(
        //                 padding: EdgeInsets.only(top:20.0),
        //               ),
        //                 new TextFormField(
        //                     keyboardType: TextInputType.number,
        //                     decoration: new InputDecoration(
        //                       icon: Icon(Icons.timer),
        //                       hintText: 'Checking Fees',
        //                       labelText: 'Fees',
        //                     ),
        //                     validator:validateFees,
        //                     onSaved: (String value) {
        //                       fees = value;
        //                   }
        //                 ),
        //                  Padding(
        //                 padding: EdgeInsets.only(top:20.0),
        //               ),
        //                  new TextFormField(
        //                     decoration: new InputDecoration(
        //                       icon: Icon(Icons.location_searching),
        //                       hintText: 'Enter clinic address',
        //                       labelText: 'Address',
        //                     ),
        //                     validator:validateAddress,
        //                     onSaved: (String value) {
        //                       address = value;
        //                   }
        //                 ),
        //                  Padding(
        //                 padding: EdgeInsets.only(top:20.0),
        //               ),
        //                  new TextFormField(
        //                     keyboardType: TextInputType.number,
        //                     decoration: new InputDecoration(
        //                       icon: Icon(Icons.phone),
        //                       hintText: 'Phone no',
        //                       labelText: 'Phone No',
        //                     ),
        //                     validator:validateMobile,
        //                     onSaved: (String value) {
        //                       phoneNo = value;
        //                   },
        //                 ),
        //                 Padding(
        //                 padding: EdgeInsets.only(top:20.0),
        //               ),
        //                 // new TextFormField(
        //                 //     decoration: new InputDecoration(
        //                 //       icon: Icon(Icons.timer),
        //                 //       labelText: 'Add your timings at the clinic',
        //                 //       suffixIcon: Icon(Icons.arrow_forward),
        //                 //     ),
        //                 //     initialValue:"timings",
        //                 //     onTap: (){
        //                     //   Navigator.push(context, MaterialPageRoute(
        //                     //       builder: (context)=>WeekTimings()
        //                     //       )
        //                     //   );
        //                     // },
        //                     // onSaved: (String value) {
        //                     //   //code left
        //                     //   timings=timereturn();
        //                 //     }
        //                 // ),
        //                  Padding(
        //                 padding: EdgeInsets.only(top:20.0),
        //               ),
        //                 // new TextFormField(
        //                 //     decoration: new InputDecoration(
        //                 //       icon: Icon(Icons.access_time),
        //                 //       labelText: 'Add Clinic Timings',
        //                 //       suffixIcon: Icon(Icons.arrow_forward),
        //                 //     ),
        //                 //     onTap: (){
        //                 //       Navigator.push(context, MaterialPageRoute(
        //                 //           builder: (context)=>AddEducation())
        //                 //       );
        //                 //     },
        //                 //     onSaved: (String value) {
        //                 //       //code left
        //                 //     }
        //                 // ),
        //               ],
        //             ),
        //           ),
        //         ],
        //       ),
        //     )
        // ),
        );
  }
}

class DegreeSearch {
  int id;
  String name;

  DegreeSearch(this.id, this.name);
}

class LocationSearch {
  int id;
  String name;

  LocationSearch(this.id, this.name);
}
