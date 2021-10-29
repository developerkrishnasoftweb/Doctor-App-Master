import 'package:flutter/material.dart';
import 'package:getcure_doctor/Database/PatientsVisitTable.dart';
import 'package:getcure_doctor/Database/TokenTable.dart';
import 'package:getcure_doctor/Helpers/AppConfig/colors.dart';

class ExamNotice extends StatefulWidget {
  final Token token;
  final PatientsVisitDB patientVisit;
  final List<PatientsVisitData> pd;

  const ExamNotice({Key key, this.token, this.patientVisit,this.pd}) : super(key: key);
  @override
  _ExamNoticeState createState() => _ExamNoticeState();
}

class _ExamNoticeState extends State<ExamNotice> {
  // List<PatientsVisitData> pd = [];


  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: 50.0,
        maxHeight: 120,
        maxWidth: MediaQuery.of(context).size.width,
      ),
      child: Container(
        // height: 150.0,
        child: Column(children: <Widget>[
          Expanded(
            flex: 3,
            child: Container(
              color: white,
              width: MediaQuery.of(context).size.width,
              child: FittedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Center(
                      child: Text(
                        'Brief History',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        child: Wrap(
                          alignment: WrapAlignment.spaceBetween,
                          // crossAxisAlignment: WrapCrossAlignment.start,
                          children: List.generate(
                              (widget.pd.isEmpty)
                                  ? (0)
                                  :  (widget.pd.last.briefHistory == null)? (0)
                                  : (widget.pd.last.briefHistory.data.length == 0)
                                  ? (0)
                                  : (widget.pd.last.briefHistory.data.length) ,
                                  (index) => Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Container(
                                  child: (widget.pd.length == 0)
                                      ? 0
                                      : (widget.pd.last.briefHistory.data == null)
                                      ? 0
                                      : widget.pd.last.briefHistory.data
                                      .length ==
                                      0
                                      ? Text('No Data')
                                      : !widget.pd.last.briefHistory
                                      .data[index].isCured
                                      ? RichText(
                                    text: TextSpan(
                                        text:
                                        "•${widget.pd.last.briefHistory.data[index].title} ",
                                        style: TextStyle(
                                            fontSize:
                                            15.0,
                                            color: black),
                                        children: <
                                            TextSpan>[
                                          TextSpan(
                                            text:
                                            "(${widget.pd.last.briefHistory.data[index].date.trim()})",
                                            style: TextStyle(
                                                fontSize:
                                                15.0,
                                                color:
                                                orangef),
                                          )
                                        ]),
                                  )
                                      : Container(),
                                ),
                              )),
                        ))
                  ],
                ),
              ),
            ),
          ),
          Container(
            height:1.0,
            decoration:
            BoxDecoration(border: Border(bottom: BorderSide(color: black))),
          ),
          Expanded(
            flex: 3,
            child: Container(
              color: Colors.white,
              width: MediaQuery.of(context).size.width,
              child: FittedBox(
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        "Today's Visit Reason",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        child: Wrap(
                          alignment: WrapAlignment.spaceBetween,
                          children: List.generate(
                              (widget.pd.isEmpty)
                                  ? (0)
                                  :  (widget.pd.last.visitReason == null)
                                  ? (0)
                                  : (widget.pd.last.visitReason.data.length == 0)
                                  ? (0)
                                  : (widget.pd.last.visitReason.data.length) ,

                                  (index) => Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Container(
                                  child: (widget.pd.length == 0) ? 0 : (widget.pd.last.visitReason.data == null) ? 0 : widget.pd.last.visitReason.data.length == 0 ? Text('No Visit')
                                      : !widget.pd.last.visitReason
                                      .data[index].isCured
                                      ? RichText(
                                    text: TextSpan(
                                        text:
                                        "•${widget.pd.last.visitReason.data[index].title} ",
                                        style: TextStyle(
                                            fontSize:
                                            15.0,
                                            color: black),
                                        children: <
                                            TextSpan>[
                                          TextSpan(
                                            text:
                                            "(${widget.pd.last.visitReason.data[index].date.trim()})",
                                            style: TextStyle(
                                                fontSize:
                                                15.0,
                                                color:
                                                orangep),
                                          )
                                        ]),
                                  )
                                      : Container(),
                                  // Text(
                                  //     "•${pd.last.visitReason.data[index].title} ( ${pd.last.visitReason.data[index].date})",
                                  //     style: TextStyle(
                                  //         fontSize: 15.0,
                                  //         color: black),
                                  //   ),
                                ),
                              )),
                        ))
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
