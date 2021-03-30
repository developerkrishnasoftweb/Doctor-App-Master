import 'package:flutter/material.dart';
import 'package:getcure_doctor/Helpers/AppConfig/colors.dart';
import 'package:getcure_doctor/Helpers/Navigation.dart';
import 'package:getcure_doctor/Helpers/Network/Requesthttp.dart';
import 'package:getcure_doctor/Models/StateSearchSuggestion.dart';
import 'AddClinic.dart';
import 'CreateClinic.dart';

class ClinicDetails extends StatefulWidget {
  final List<StateData> states;

  ClinicDetails({Key key, this.states}) : super(key: key);

  @override
  _ClinicDetailsState createState() => _ClinicDetailsState();
}

class _ClinicDetailsState extends State<ClinicDetails> {
  List<StateData> suggestions = [];
  Future<List<StateData>> getSuggestions() async {
    suggestions = await getStateinfo();
    return suggestions;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        title: new Text('ADD CLINIC'),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: RichText(
                text: TextSpan(
                    text: 'Add clinic to your profile\n\n',
                    style: TextStyle(
                        color: black,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                    children: <TextSpan>[
                      TextSpan(
                        text:
                            'Clinic owner will have to provide proof of ownership.\n\n',
                        style: TextStyle(
                            color: black,
                            fontSize: 18,
                            fontWeight: FontWeight.w300),
                      ),
                      TextSpan(
                        text:
                            'Visiting consultants will not be able to edit information for their clinics.',
                        style: TextStyle(
                            color: black,
                            fontSize: 18,
                            fontWeight: FontWeight.w300),
                      )
                    ]),
              ),
            ),
          ),
          SizedBox(
            height: 150,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 40,
              width: MediaQuery.of(context).size.width,
              child: FlatButton(
                  child: Text(
                    'ADD CLINIC',
                    style: TextStyle(
                        color: white,
                        fontSize: 18,
                        fontWeight: FontWeight.w300),
                  ),
                  color: orangep,
                  onPressed: () => changeScreen(
                      context,
                      AddClinic(
                        suggestionsstate: widget.states,
                      ))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 40,
              width: MediaQuery.of(context).size.width,
              child: FlatButton(
                child: Text(
                  'ADD EXISTING CLINIC',
                  style: TextStyle(
                      color: white, fontSize: 18, fontWeight: FontWeight.w300),
                ),
                color: orangep,
                onPressed: () => changeScreen(
                    context, CreateClinic(suggestionsstate: suggestions)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
