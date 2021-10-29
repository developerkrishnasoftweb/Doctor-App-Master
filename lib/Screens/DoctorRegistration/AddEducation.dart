import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:getcure_doctor/Helpers/AppConfig/colors.dart';

class AddEducation extends StatefulWidget {
  @override
  _AddEducationState createState() => _AddEducationState();
}

class _AddEducationState extends State<AddEducation> {
  _AddEducationState() {
    degreeTextField = new AutoCompleteTextField<DegreeSearch>(
      decoration: new InputDecoration(
          icon: Icon(Icons.laptop),
          hintText: "Degree",
          suffixIcon: new Icon(Icons.search)),
      itemSubmitted: (item) => setState(() => selected = item),
      key: key,
      suggestions: degreesugg,
      itemBuilder: (context, suggestion) => new Padding(
          child: new ListTile(
            title: new Text(suggestion.name),
          ),
          padding: EdgeInsets.all(8.0)),
      itemSorter: (a, b) => a.id == b.id
          ? 0
          : a.id > b.id
              ? -1
              : 1,
      itemFilter: (suggestion, input) =>
          suggestion.name.toLowerCase().startsWith(input.toLowerCase()),
    );
    collegeTextField = new AutoCompleteTextField<CollegeSearch>(
      decoration: new InputDecoration(
          icon: Icon(Icons.school),
          hintText: "College/University",
          suffixIcon: new Icon(Icons.search)),
      itemSubmitted: (item) => setState(() => sselected = item),
      key: lkey,
      suggestions: collsugg,
      itemBuilder: (context, specialsugg) => new Padding(
          child: new ListTile(
            title: new Text(specialsugg.name),
          ),
          padding: EdgeInsets.all(8.0)),
      itemSorter: (a, b) => a.id == b.id
          ? 0
          : a.id > b.id
              ? -1
              : 1,
      itemFilter: (specialsugg, input) =>
          specialsugg.name.toLowerCase().startsWith(input.toLowerCase()),
    );
  }

  List<CollegeSearch> collsugg = [
    CollegeSearch(1, 'kalkaji'),
    CollegeSearch(3, 'Anand Vihar'),
    CollegeSearch(2, 'govindpuri')
  ];

  List<DegreeSearch> degreesugg = [
    DegreeSearch(1, 'MBBS'),
    DegreeSearch(2, 'MS'),
    DegreeSearch(3, 'BDS'),
    DegreeSearch(4, 'Cardiologist'),
    DegreeSearch(5, 'ENT'),
    DegreeSearch(6, 'Ophthalmologist'),
    DegreeSearch(7, 'Gynecologist'),
  ];

  GlobalKey key = new GlobalKey<AutoCompleteTextFieldState<DegreeSearch>>();
  GlobalKey lkey = new GlobalKey<AutoCompleteTextFieldState<CollegeSearch>>();

  AutoCompleteTextField<DegreeSearch> degreeTextField;
  AutoCompleteTextField<CollegeSearch> collegeTextField;

  CollegeSearch sselected;
  String year;
  DegreeSearch selected;

  bool _autoValidate = false;
  bool isSelected = false;
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  String validateYear(String value) {
    if (value.isEmpty)
      return 'Please enter a valid Year';
    else
      return null;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: orangef,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 7),
            child: Icon(Icons.info),
          ),
        ],
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pop(context)),
        title: new Text('Add Education'),
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
                      Padding(
                        padding: const EdgeInsets.only(top: 10, right: 15),
                        child: selected == null
                            ? degreeTextField
                            : Column(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Icon(Icons.laptop),
                                      Text(
                                        selected.name,
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
                                  Divider(
                                    color: black,
                                  ),
                                ],
                              ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20, right: 15),
                        child: sselected == null
                            ? collegeTextField
                            : Column(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Icon(Icons.school),
                                      Text(
                                        sselected.name,
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      IconButton(
                                          icon: Icon(
                                            Icons.cancel,
                                            color: red,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              sselected = null;
                                            });
                                          })
                                    ],
                                  ),
                                  Divider(
                                    color: black,
                                  ),
                                ],
                              ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20.0),
                      ),
                      new TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: new InputDecoration(
                            icon: Icon(Icons.timer),
                            hintText: 'Year of completion',
                            labelText: 'Year',
                          ),
                          validator: validateYear,
                          onSaved: (String value) {
                            year = value;
                          }),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}

class DegreeSearch {
  int id;
  String name;

  DegreeSearch(this.id, this.name);
}

class CollegeSearch {
  int id;
  String name;

  CollegeSearch(this.id, this.name);
}
