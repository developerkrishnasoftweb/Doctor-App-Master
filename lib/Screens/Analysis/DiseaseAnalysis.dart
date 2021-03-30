import 'package:flutter/material.dart';
import 'package:getcure_doctor/Helpers/AppConfig/colors.dart';
import 'package:getcure_doctor/Widgets/DiseaseAnalysisWidget.dart';
import 'package:getcure_doctor/Widgets/MedicineAnalysisWidget.dart';
import 'package:getcure_doctor/Widgets/PatientAnalysisWidget.dart';

class DiseaseAnalysis extends StatefulWidget {
  final int docId;
  DiseaseAnalysis({Key key, this.docId}) : super(key: key);

  @override
  _DiseaseAnalysisState createState() => _DiseaseAnalysisState();
}

class _DiseaseAnalysisState extends State<DiseaseAnalysis> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: orange,
          bottom: TabBar(
            tabs: [
              Tab(
                child: Text("Disease"),
              ),
              Tab(
                child: Text("Medicine"),
              ),
              Tab(
                child: Text("Patient Feedback"),
              ),
            ],
          ),
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
              ),
              onPressed: () => Navigator.pop(context)),
          title: Text('Analysis'),
        ),
        body: TabBarView(
          children: [
           DiseaseAnalysisWidget(docId:widget.docId),
           MedicineAnalysisWidget(docId:widget.docId),
           PatientAnalysisWidget(docId:widget.docId),
           
          ],
        ),
      ),
    );
  }
}
