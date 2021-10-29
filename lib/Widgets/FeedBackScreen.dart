import 'package:flutter/material.dart';
import 'package:getcure_doctor/Database/FeedBackTable.dart';
import 'package:getcure_doctor/Database/PatientsVisitTable.dart';
import 'package:getcure_doctor/Database/Recommendation.dart';
import 'package:getcure_doctor/Database/TokenTable.dart';
import 'package:getcure_doctor/Helpers/AppConfig/colors.dart';
import 'package:getcure_doctor/Models/PatientsVisitTableModels.dart';
import 'package:provider/provider.dart';

class FeedBackScreen extends StatefulWidget {
  final Token token;
  final PatientsVisitData pat;
  final PatientsVisitDB patient;
  final BuildContext context;
  const FeedBackScreen(
      {Key key, this.token, this.pat, this.patient, this.context})
      : super(key: key);

  @override
  _FeedBackScreenState createState() => _FeedBackScreenState();
}

class _FeedBackScreenState extends State<FeedBackScreen> {
  List<String> feedback;
  @override
  void initState() {
    feedback = new List(widget.pat.feedBack.data.length);
    super.initState();
  }

  fback(FeedBackDB feed, RecommendationDB recom) async {
    for (int i = 0; i < widget.pat.feedBack.data.length; i++) {
      List<String> med = [];
      for (var ind in widget.pat.feedBack.data[i].medicines) {
        med.add(ind.title);
      }
      FeedBackData object = FeedBackData(
          clinicDoctorId: widget.pat.clinicDoctorId,
          doctorId: widget.token.doctorid,
          medication: widget.pat.feedBack.data[i],
          option: feedback[i],
          appointmentTime: widget.token.tokentime,
          patientVisitIid: widget.pat.patientId,
          question: widget.pat.feedBack.data[i].disease,
          createdAt: DateTime.now());

      RecommendationData check =
      await recom.check(widget.pat.feedBack.data[i].disease,med);
      if (check != null) {
        recom.updateData(widget.pat.feedBack.data[i].disease,feedback[i],med,check);
      } else {
        RecommendationData recommendationData = RecommendationData(
          clinicDoctorId: widget.pat.clinicDoctorId,
          doctorId: widget.token.doctorid,
          disease: widget.pat.feedBack.data[i].disease,
          cured: feedback[i] == 'Cured Complete' ? 1 : 0,
          partiallyCured: feedback[i] == 'Partially Cured' ? 1 : 0,
          notCured: feedback[i] == 'Not Cured' ? 1 : 0,
          symptomsIncreased: feedback[i] == 'Symptoms Increased' ? 1 : 0,
          totalCount: 1,
          medicines: Medicinesgenerated(medicines: med),
          isOnline: false,
          createdAt: DateTime.now(),
        );
        recom.insert(recommendationData);
      }
      feed.insert(object);
    }
    widget.patient.deleteFeedBack(widget.pat);
  }

  @override
  Widget build(BuildContext context) {
    final feed = Provider.of<FeedBackDB>(context);
    final recom = Provider.of<RecommendationDB>(context);
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: SimpleDialog(
        title: ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Text("FeedBack"),
          trailing: IconButton(
              icon: Icon(Icons.close), onPressed: () => Navigator.pop(context)),
        ),
        children: [
          Container(
              height: MediaQuery.of(context).size.height * 0.7,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                itemCount: widget.pat.feedBack.data.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return ResponseInput(
                    data: widget.pat.feedBack.data[index],
                    feedback: feedback,
                    index: index,
                  );
                },
              )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FlatButton(
              onPressed: () {
                print(feedback);
                fback(feed, recom);
                // for (int i = 0; i < widget.pat.feedBack.data.length; i++) {
                //   FeedBackData object = FeedBackData(
                //       clinicDoctorId: widget.pat.clinicDoctorId,
                //       doctorId: widget.token.doctorid,
                //       medication: widget.pat.feedBack.data[i],
                //       option: feedback[i],
                //       patientVisitIid: widget.pat.id,
                //       question: widget.pat.feedBack.data[i].disease,
                //       createdAt: DateTime.now());
                //   feed.insert(object);
                // }
                Navigator.pop(context);
              },
              child: Text("Save"),
              textColor: white,
              color: green,
            ),
          )
        ],
      ),
    );
  }
}

class ResponseInput extends StatefulWidget {
  final MedicationData data;
  List<String> feedback;
  int index;
  ResponseInput({Key key, this.data, this.feedback, this.index})
      : super(key: key);

  @override
  _ResponseInputState createState() => _ResponseInputState();
}

class _ResponseInputState extends State<ResponseInput> {
  @override
  void initState() {
    setState(() {
      _radioValue = "Not Cured";
      widget.feedback[widget.index] = "Not Cured";
    });
    super.initState();
  }

  String _radioValue;
  String choice;

  void radioButtonChanges(String value) {
    setState(() {
      _radioValue = value;
      switch (value) {
        case 'Cured Complete':
          choice = value;
          break;
        case 'Partially Cured':
          choice = value;
          break;
        case 'Not Cured':
          choice = value;
          break;
        default:
          choice = 'Symptoms Increased';
      }
      widget.feedback[widget.index] = choice;
      debugPrint(choice);
    });
    print(widget.feedback);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 150,
      // child: Text('data'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Text(
              widget.data.disease,
              style: TextStyle(color: blue),
            ),
          ),
          Column(
            children: [
              Row(
                children: <Widget>[
                  Radio(
                    value: 'Cured Complete',
                    groupValue: _radioValue,
                    onChanged: radioButtonChanges,
                  ),
                  Text(
                    "Cured Complete",
                  ),
                  Radio(
                    value: 'Partially Cured',
                    groupValue: _radioValue,
                    onChanged: radioButtonChanges,
                  ),
                  Text(
                    "Partially Cured",
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Radio(
                    value: 'Not Cured',
                    groupValue: _radioValue,
                    onChanged: radioButtonChanges,
                  ),
                  Text(
                    "Not Cured",
                  ),
                  Radio(
                    value: 'Symptoms Increased',
                    groupValue: _radioValue,
                    onChanged: radioButtonChanges,
                  ),
                  Text(
                    "Symptoms Increased",
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
