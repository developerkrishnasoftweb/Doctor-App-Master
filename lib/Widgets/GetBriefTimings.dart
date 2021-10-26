import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:getcure_doctor/Database/MedicinesTable.dart';
import 'package:getcure_doctor/Database/PatientsVisitTable.dart';
import 'package:getcure_doctor/Database/Recommendation.dart';
import 'package:getcure_doctor/Helpers/AppConfig/colors.dart';
import 'package:getcure_doctor/Models/PatientsVisitTableModels.dart';
import 'package:provider/provider.dart';

class GetTimings extends StatefulWidget {
  final String briefTitle;
  final String visibleTill;
  final PatientsVisitDB pv;
  final String pId;
  final String type;
  final int docId;
  final String allergyOrLifeType;
  final int id;

  const GetTimings(
      {Key key,
      this.briefTitle,
      this.visibleTill,
      this.pv,
      this.pId,
      this.type,
      this.docId,
      this.allergyOrLifeType,
      this.id})
      : super(key: key);

  @override
  _GetTimingsState createState() => _GetTimingsState();
}

class _GetTimingsState extends State<GetTimings> {
  String day = '0';
  String month = '0';
  String year = '0';
  String _radioValue = "Since";
  String choice;
  int days = 0;
  int months = 0;
  int years = 0;

  @override
  void dispose() {
    super.dispose();
  }

  void getTimeFun(String type, int days, int months, int years,
      RecommendationDB recom, MedicinesDB med) async {
    String setDate = '';
    if (days != 0) {
      setDate += '$days days ';
    }
    if (months != 0) {
      setDate += '$months months ';
    }
    if (years != 0) {
      setDate += '$years years';
    }
    switch (type) {
      case 'brief':
        List<BriefHistoryData> bhd = [
          BriefHistoryData(
            id: widget.id,
            date: setDate,
            title: widget.briefTitle,
            visibleTill: widget.visibleTill,
            isCured: _radioValue == "Since" ? false : true,
          )
        ];
        BriefHistorygenerated bh = BriefHistorygenerated(
          data: bhd,
        );
        var p = await widget.pv.checkPatient(widget.pId);
        widget.pv.updateBriefHistory(p.last, bh);

        /// Uncomment these line
        /// if diagnosis should be added while adding brief history
        ///
        // List<DignosisData> bhdd = [
        //   DignosisData(
        //     date: setDate,
        //     title: widget.briefTitle,
        //     visibleTill: widget.visibleTill,
        //     isCured: _radioValue == "Since" ? false : true,
        //   )
        // ];
        // Dignosisgenerated bht = Dignosisgenerated(data: bhdd);
        // var pp = await widget.pv.checkPatient(widget.pId);
        // widget.pv.updateDiagnosis(pp.last, bht, recom, med);
        break;
      case 'todayVisit':
        List<VisitReasonData> vhd = [
          VisitReasonData(
            id: widget.id,
            date: setDate,
            title: widget.briefTitle,
            visibleTill: widget.visibleTill,
            isCured: _radioValue == "Since" ? false : true,
          )
        ];
        VisitReasongenerated vh = VisitReasongenerated(data: vhd);

        var p = await widget.pv.checkPatient(widget.pId);

        widget.pv.updateVisitReason(p.last, vh);
        break;
      case 'diagnois':
        List<DignosisData> bhdd = [
          DignosisData(
            date: setDate,
            title: widget.briefTitle,
            visibleTill: widget.visibleTill,
            isCured: _radioValue == "Since" ? false : true,
          )
        ];
        Dignosisgenerated bht = Dignosisgenerated(data: bhdd);
        var pp = await widget.pv.checkPatient(widget.pId);

        widget.pv.updateDiagnosis(pp.last, bht, recom, med);
        break;
    }
  }

  void radioButtonChanges(String value) {
    setState(() {
      _radioValue = value;
      switch (value) {
        case 'Since':
          choice = value;
          break;
        case 'Cured':
          choice = value;
          break;
        default:
          choice = null;
      }
      debugPrint(choice); //Debug the choice in console
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final recom = Provider.of<RecommendationDB>(context);
    final med = Provider.of<MedicinesDB>(context);
    return SingleChildScrollView(
      child: AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(child: Text('Brief History')),
            InkWell(
                onTap: () => Navigator.pop(context), child: Icon(Icons.close))
          ],
        ),
        actions: <Widget>[
          SingleChildScrollView(
            child: Stack(
              // fit: StackFit.expand,
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height <= 640
                      ? MediaQuery.of(context).size.height * 0.76
                      : MediaQuery.of(context).size.height * 0.6,
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text('Since'),
                              Radio(
                                  activeColor: orangep,
                                  value: 'Since',
                                  groupValue: _radioValue,
                                  onChanged: radioButtonChanges),
                            ],
                          ),
                          SizedBox(
                            width: 15.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text('Cured'),
                              Radio(
                                  activeColor: orangep,
                                  value: 'Cured',
                                  groupValue: _radioValue,
                                  onChanged: radioButtonChanges),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Text('Days'),
                          SizedBox(
                            height: 10.0,
                          ),
                          Wrap(
                            children: <Widget>[
                              Container(
                                  height: 120.0,
                                  width: MediaQuery.of(context).size.width,
                                  child: GridView.builder(
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 10,
                                            mainAxisSpacing: 5.0,
                                            crossAxisSpacing: 5.0),
                                    itemCount: 32,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            days = index;
                                          });
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          height: 50.0,
                                          width: 50.0,
                                          decoration: BoxDecoration(
                                              color: days == index
                                                  ? orange
                                                  : white,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(30)),
                                              border:
                                                  Border.all(color: orange)),
                                          child: Text(index.toString()),
                                        ),
                                      );
                                    },
                                  )),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Text('Months'),
                          SizedBox(
                            height: 10.0,
                          ),
                          Wrap(
                            children: <Widget>[
                              Container(
                                  height: 70.0,
                                  width: MediaQuery.of(context).size.width,
                                  child: GridView.builder(
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 10,
                                            mainAxisSpacing: 5.0,
                                            crossAxisSpacing: 5.0),
                                    itemCount: 12,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            months = index;
                                          });
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          height: 50.0,
                                          width: 50.0,
                                          decoration: BoxDecoration(
                                              color: months == index
                                                  ? orange
                                                  : white,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(30)),
                                              border:
                                                  Border.all(color: orange)),
                                          child: Text(index.toString()),
                                        ),
                                      );
                                    },
                                  )),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Text('Years'),
                          SizedBox(
                            height: 10.0,
                          ),
                          Wrap(
                            children: <Widget>[
                              Container(
                                  height: 90.0,
                                  width: MediaQuery.of(context).size.width,
                                  child: GridView.builder(
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 10,
                                            mainAxisSpacing: 5.0,
                                            crossAxisSpacing: 5.0),
                                    itemCount: 22,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            years = index;
                                          });
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          height: 50.0,
                                          width: 50.0,
                                          decoration: BoxDecoration(
                                              color: index == years
                                                  ? orange
                                                  : white,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(30)),
                                              border:
                                                  Border.all(color: orange)),
                                          child: Text(index.toString()),
                                        ),
                                      );
                                    },
                                  )),
                            ],
                          ),
                        ],
                      ),
                      RaisedButton(
                        color: pcolor,
                        child: Text('Save'),
                        onPressed: () async {
                          getTimeFun(
                              widget.type, days, months, years, recom, med);
                          Fluttertoast.showToast(
                              msg: "${widget.briefTitle} added to list",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: green,
                              textColor: white,
                              fontSize: 16.0);
                          Navigator.pop(context);
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
