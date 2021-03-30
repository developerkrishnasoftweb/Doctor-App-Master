import 'package:flutter/material.dart';

class DoctorProvider extends ChangeNotifier{

  String selectedValuesJsonBrief = 'Nothing to show';
  String selectedValuesJsonVisit = 'Nothing to show';
  // List<AddItemsDoctor> itemsBreif = [];
  // List<AddItemsDoctor> itemsVisit = [];

  // addItems( AddItemsDoctor obj){
  //   itemsBreif.add(obj);
  //   notifyListeners();
  // }

  addStringValues(String str){
    selectedValuesJsonBrief =str;
    notifyListeners();
    return selectedValuesJsonBrief;
  }
  addStringValuesVisit(String str){
    selectedValuesJsonVisit =str;
    notifyListeners();
    return selectedValuesJsonVisit;
  }

  // addItemsVisit(AddItemsDoctor obj){
  //   itemsVisit.add(obj);
  //   notifyListeners();
  // }
          
} 