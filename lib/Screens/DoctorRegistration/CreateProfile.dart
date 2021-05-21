import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:getcure_doctor/Helpers/AppConfig/colors.dart';
import 'package:getcure_doctor/Helpers/Network/Requesthttp.dart';
import 'package:getcure_doctor/Models/SpecialitySearchSuggestion.dart';
import 'package:getcure_doctor/Models/StateSearchSuggestion.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';

class CreateProfile extends StatefulWidget {
  final List<StateData> suggestionsstate;
  final List<SpecialityData> suggestionspec;
  const CreateProfile({Key key, this.suggestionsstate, this.suggestionspec})
      : super(key: key);
  @override
  _CreateProfileState createState() =>
      _CreateProfileState(suggestionsstate, suggestionspec);
}

class _CreateProfileState extends State<CreateProfile> {
  _CreateProfileState(this.suggestionstate, this.suggestionspec) {
    cityTextField = new AutoCompleteTextField<StateData>(
      decoration: new InputDecoration(
          icon: Icon(Icons.location_city),
          hintText: "City",
          suffixIcon: new Icon(Icons.search)),
      itemSubmitted: (item) => setState(() => selected = item),
      key: key,
      suggestions: suggestionstate,
      itemBuilder: (context, suggestion) => new Padding(
          child: new ListTile(
            title: new Text(suggestion.title),
          ),
          padding: EdgeInsets.all(8.0)),
      itemSorter: (a, b) => a.id == b.id ? 0 : a.id > b.id ? -1 : 1,
      itemFilter: (suggestion, input) =>
          suggestion.title.toLowerCase().startsWith(input.toLowerCase()),
    );

    
  }

  
  GlobalKey key = new GlobalKey<AutoCompleteTextFieldState<StateData>>();
  GlobalKey lkey = new GlobalKey<AutoCompleteTextFieldState<SpecialityData>>();
  //GlobalKey ekey = new GlobalKey<AutoCompleteTextFieldState<LocalitySearch>>();

  AutoCompleteTextField<StateData> cityTextField;
  AutoCompleteTextField<SpecialityData> specialityTextField;
  //AutoCompleteTextField<LocalitySearch> educationTextField;

  StateData selected;
  //LocalitySearch eselected;
  List<dynamic> specselected=[];

  String city = '';
  String gender = '';
  String speciality = '';
  String email = '';
  String fullname = '';
  String experience = '';
  String education = '';
  //String locality = '';
  bool _autoValidate = false;
  bool isSelected = false;
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  
  @override
  void initState() {
    getSuggestions();
    getSuggestionsspec();
    super.initState();
  }

  List<StateData> suggestionstate = [];
  getSuggestions() async {
    var sugst = await getStateinfo();
    setState(() {
      suggestionstate = sugst;
    });
    //  return suggestionstate;
  }

  List<SpecialityData> suggestionspec = [];
  getSuggestionsspec() async {
    var sugspec = await getSpeciality();
    setState(() {
      suggestionspec = sugspec;
    });
    //return suggestionspec;
  }

  String validateName(String value) {
    if (value.length < 3)
      return 'Please enter a valid name';
    else
      return null;
  }

  String validateExperience(String value) {
    if (value.isEmpty)
      return 'Please enter a valid name';
    else
      return null;
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: orangef,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 7),
            //child: Icon(Icons.info),
          ),
        ],
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pop(context)),
        title: new Text('Create Profile'),
      ),
      body: new Container(
          padding: new EdgeInsets.all(5.0),
          child: new Form(
            autovalidate: _autoValidate,
            key: this._formKey,
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: ListView(
                    children: <Widget>[
                      new TextFormField(
                          keyboardType: TextInputType.text,
                          decoration: new InputDecoration(
                            icon: Icon(Icons.person),
                            hintText: 'Enter your name',
                            labelText: 'Name',
                          ),
                          validator: validateName,
                          onSaved: (String value) {
                            fullname = value;
                          }),
                      TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: new InputDecoration(
                            icon: Icon(Icons.mail),
                            hintText: 'Enter email address',
                            labelText: 'Email',
                          ),
                          validator: validateName,
                          onSaved: (String value) {
                            email = value;
                          }),
                      Padding(
                        padding: const EdgeInsets.only(top: 20, right: 15),
                        child: selected == null
                            ? cityTextField
                            : Column(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.location_city,
                                            color: grey,
                                          ),
                                          SizedBox(
                                            width: 12.0,
                                          ),
                                          Text(
                                            selected.title,
                                            style: TextStyle(fontSize: 15),
                                          ),
                                        ],
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
                      
                      
                      Padding(
                        padding: const EdgeInsets.only( right: 15,left: 15),
                        child: MultiSelectFormField(
                          autovalidate: false,
                          title: Text("speciality"),
                          // titleText: "speciality",
                          dataSource: widget.suggestionspec.map((e) => {"title":e.title,"id":e.id}).toList(),
                          textField: 'title',
                          valueField: 'title',
                          okButtonLabel: 'DONE',
                          cancelButtonLabel: 'CANCEL',
                          onSaved: (value) {
                            if (value == null) return;
                           setState(() {
                             specselected = value;
                           });
                          },

                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20.0),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.people,
                                color: isSelected
                                    ? Colors.blue
                                    : Colors.grey.shade600,
                              ),
                              SizedBox(
                                width: 17.0,
                              ),
                              Text(
                                'Gender',
                                style: TextStyle(
                                    color: isSelected
                                        ? Colors.blue
                                        : Colors.grey.shade600,
                                    fontSize: 16),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Radio(
                                groupValue: gender,
                                value: 'male',
                                onChanged: (val) {
                                  setState(() {
                                    gender = val;
                                    isSelected = true;
                                  });
                                },
                              ),
                              new Text('Male'),
                              Radio(
                                groupValue: gender,
                                value: 'female',
                                onChanged: (val) {
                                  setState(() {
                                    gender = val;
                                    isSelected = true;
                                  });
                                },
                              ),
                              new Text('Female'),
                            ],
                          )
                        ],
                      ),
                      TextFormField(
                          keyboardType: TextInputType.text,
                          decoration: new InputDecoration(
                            icon: Icon(Icons.book),
                            hintText: 'Enter your Latest Education',
                            labelText: 'Education',
                          ),
                          //validator: validateName,
                          onSaved: (String value) {
                            education = value;
                          }),
                      // new TextFormField(
                      //     decoration: new InputDecoration(
                      //       icon: Icon(Icons.receipt),
                      //       labelText: 'Registration Details',
                      //       //suffixIcon: Icon(Icons.arrow_forward),
                      //     ),
                      //     onTap: () {
                      //       //changeScreen(context, RegistrationDetails());
                      //     },
                      //     onSaved: (String value) {
                      //       //code left
                      //     }),
                      new TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: new InputDecoration(
                            icon: Icon(Icons.school),
                            hintText: 'Your Experience',
                            labelText: 'Years of Experience',
                          ),
                          validator: validateExperience,
                          onSaved: (String value) {
                            experience = value;
                          }),
                    ],
                  ),
                ),
                new Container(
                  width: screenSize.width,
                  child: new RaisedButton(
                    child: new Text(
                      'Continue',
                      style: new TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      List<String> test = [];
                      for(var i in specselected){
                        test.add(i.toString());
                      }
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        // print(fullname +
                        //     email +
                        //     selected.title +
                        //     specselected.title +
                        //     gender +
                        //     education +
                        //     experience.toString());
                        bool isval = await updateDoctor(
                            fullname,
                            email,
                            selected.title,
                            test,
                            gender,
                            education,
                            experience);
                        if (isval) {
                          Navigator.pop(context);
                        }
                      } else {
                        setState(() {
                          _autoValidate = true;
                        });
                      }
                    },
                    color: Colors.deepOrangeAccent,
                  ),
                  margin: new EdgeInsets.only(top: 20.0),
                )
              ],
            ),
          )),
    );
  }
}

// class SpecialitySearch {
//   int id;
//   String name;
//   SpecialitySearch(this.id, this.name);
// }
