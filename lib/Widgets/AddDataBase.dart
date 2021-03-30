import 'package:flutter/material.dart';
import 'package:getcure_doctor/Helpers/AppConfig/colors.dart';
import 'package:getcure_doctor/Widgets/AddToDatabaseTables/AddAllergy&Lifestyle.dart';
import 'package:getcure_doctor/Widgets/AddToDatabaseTables/AddSymptoms.dart';
import 'package:getcure_doctor/Widgets/ExaminationSearchBar.dart';
import 'AddMedicine.dart';

class AddDataBase extends StatelessWidget {
  final int docId;
  final int clinicDocId;
  const AddDataBase({Key key, this.docId,this.clinicDocId }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add DataBase'),
        backgroundColor: orangef,
      ),
      body: ListView(
        children: [
          ListTile(
              title: Text('Symptom Table'),
              trailing: IconButton(
                icon: Icon(Icons.arrow_forward_ios),
              ),
              onTap: () {
                print("add database line 29");
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AddToSymptoms(docId: docId,
                    clinicDocId: clinicDocId, );
                  },
                );
              }),
          ListTile(
              title: Text('Habit Table'),
              trailing: IconButton(icon: Icon(Icons.arrow_forward_ios)),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AddAllergyLifestyle(docId: docId);
                  },
                );
              }),
          ListTile(
              title: Text('Examination Table'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                print(docId);
                showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context) {
                    return ExaminationSearchBar(
                      docId: docId,
                    );
                  },
                );
              }),
          ListTile(
              title: Text('Medicine Table'),
              trailing: IconButton(
                  icon: Icon(Icons.arrow_forward_ios), onPressed: null),
              onTap: () {
                print(docId);
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AddMedicine(
                      docId: docId,
                    );
                  },
                );
              }),
        ],
      ),
    );
  }
}
