import 'package:flutter/material.dart';
import 'package:getcure_doctor/Database/ExaminationTable.dart';

class ExaminationProvider extends ChangeNotifier {
  List<ParameterData> parametersList = [];
  List<String> references = [];
  List<String> bioReferences = [];
  addParameter(ParameterData parameterData) {
    parametersList.add(parameterData);
  }

  addReference(String reference) {
    references.add(reference);
    references = references.toSet().toList();
  }

  addBioReference(String reference) {
    bioReferences.add(reference);
    bioReferences = bioReferences.toSet().toList();
  }
}
