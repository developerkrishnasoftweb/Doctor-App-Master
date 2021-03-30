import 'package:flutter/material.dart';
import 'package:getcure_doctor/Database/PatientsVisitTable.dart';
import 'package:getcure_doctor/Database/TokenTable.dart';
import 'package:getcure_doctor/Helpers/AppConfig/colors.dart';

class DiagnosisNotice extends StatefulWidget {
  final Token token;
  final PatientsVisitDB patientVisit;
  final List<PatientsVisitData> pd;
  const DiagnosisNotice({Key key, this.token, this.patientVisit, this.pd})
      : super(key: key);
  @override
  _DiagnosisNoticeState createState() => _DiagnosisNoticeState();
}

class _DiagnosisNoticeState extends State<DiagnosisNotice> {
  // List<PatientsVisitData> pd = [];
  // getData() async {
  //   print("General Details");
  //   pd = await widget.patientVisit.checkPatient(widget.token.guid);
  //   print(pd);
  //   setState(() {});
  // }

  @override
  void initState() {
    // getData();
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
                        'Noticable',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        child: Wrap(
                          alignment: WrapAlignment.spaceBetween,
                          // crossAxisAlignment: WrapCrossAlignment.start,
                          children: List.generate(
                              (widget.pd.length == 0)
                                  ? 0
                                  : (widget.pd.last.visitReason == null)
                                      ? (0)
                                      : (widget.pd.last.visitReason.data.length == 0
                                          ? (0)
                                          : widget.pd.last.visitReason.data.length),
                              (index) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: Container(
                                      child: (widget.pd.length == 0)
                                          ? 0
                                          : (widget.pd.last.visitReason.data == null)
                                              ? 0
                                              : widget.pd.last.visitReason.data
                                                          .length ==
                                                      0
                                                  ? Text('No Data')
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
            height: 5.0,
            decoration:
                BoxDecoration(border: Border(bottom: BorderSide(color: black))),
          ),
          Expanded(
            flex: 3,
            child: Container(
              color: Colors.grey[300],
              width: MediaQuery.of(context).size.width,
              child: FittedBox(
                child: Column(
                  children: [
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        width: MediaQuery.of(context).size.width,
                        child: Wrap(
                            alignment: WrapAlignment.spaceBetween,
                            children: [
                              double.parse(widget.pd.last.temperature) > 99 ||
                                      double.parse(widget.pd.last.temperature) < 97
                                  ? RichText(
                                      text: TextSpan(
                                          text: "•Temp- ",
                                          style: TextStyle(
                                              fontSize: 15.0, color: black),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: (widget.pd.length == 0)
                                                  ? "0"
                                                  : "${widget.pd.last.temperature}",
                                              style: TextStyle(
                                                  fontSize: 15.0,
                                                  color: orangep),
                                            )
                                          ]),
                                    )
                                  : Container(),
                              int.parse(widget.pd.last.bp.split('/')[0]) > 120 ||
                                      int.parse(widget.pd.last.bp.split('/')[0]) <
                                          90 ||
                                      int.parse(widget.pd.last.bp.split('/')[1]) >
                                          80 ||
                                      int.parse(widget.pd.last.bp.split('/')[1]) < 60
                                  ? RichText(
                                      text: TextSpan(
                                          text: "•B.P- ",
                                          style: TextStyle(
                                              fontSize: 15.0, color: black),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: (widget.pd.length == 0)
                                                  ? "0"
                                                  : "${widget.pd.last.bp}",
                                              style: TextStyle(
                                                  fontSize: 15.0,
                                                  color: orangep),
                                            )
                                          ]),
                                    )
                                  : Container(),

                             (widget.pd.last.pulse!=null && widget.pd.last.pulse!="")?  int.parse(widget.pd.last.pulse) > 100 ||
                                      int.parse(widget.pd.last.pulse) < 60
                                  ? RichText(
                                      text: TextSpan(
                                          text: "•Pulse- ",
                                          style: TextStyle(
                                              fontSize: 15.0, color: black),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: (widget.pd.length == 0)
                                                  ? "0"
                                                  : "${widget.pd.last.pulse.toString()}",
                                              style: TextStyle(
                                                  fontSize: 15.0,
                                                  color: orangep),
                                            )
                                          ]),
                                    )
                                  : Container():Container(),
                              (widget.pd.last.weight!=null && widget.pd.last.weight!="" &&int.parse(widget.pd.last.weight)!=0) ?(int.parse(widget.pd.last.weight) > 99 ||
                                      int.parse(widget.pd.last.weight) < 40) 
                                  ? RichText(
                                      text: TextSpan(
                                          text: "•Weight- ",
                                          style: TextStyle(
                                              fontSize: 15.0, color: black),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: (widget.pd.length == 0)
                                                  ? "0"
                                                  : "${widget.pd.last.weight.toString()}",
                                              style: TextStyle(
                                                  fontSize: 15.0,
                                                  color: orangep),
                                            )
                                          ]),
                                    )
                                  : Container():Container(),
                              
                           Wrap(
                                alignment: WrapAlignment.start,
                                // crossAxisAlignment: WrapCrossAlignment.start,
                                children: [
                                  widget.pd.length == 0 ||  widget.pd.last.allergies == null?   Container():
                          RichText(
                                text: TextSpan(
                                  text: "•Allergies- ",
                                  style:
                                      TextStyle(fontSize: 15.0, color: black),
                                ),
                              ),
                                  ...List.generate(
                                    (widget.pd.length == 0)
                                        ? 0
                                        : (widget.pd.last.allergies == null)

                                            ? 0
                                            : (widget.pd.last.allergies.data.length ==
                                                    0
                                                ? 0
                                                : widget.pd.last.allergies.data
                                                    .length),
                                    (index) => Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10.0),
                                          child: Container(
                                            child: (widget.pd.length == 0)
                                                ? 0
                                                : (widget.pd.last.allergies.data ==
                                                        null)
                                                    ? 0
                                                    : widget.pd.last.allergies.data
                                                                .length ==
                                                            0
                                                        ? Text('No Data')
                                                        : RichText(
                                                            text: TextSpan(
                                                              text:
                                                                  "•${widget.pd.last.allergies.data[index].title} ",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      15.0,
                                                                  color: orangef),
                                                            ),
                                                          ),
                                          ),
                                        )),]
                              ),
                              
                          
                              Wrap(
                                alignment: WrapAlignment.spaceBetween,
                                // crossAxisAlignment: WrapCrossAlignment.start,
                                children:[ 
                                  widget.pd.length == 0 || widget.pd.last.lifestyle == null?Container(): RichText(
                                text: TextSpan(
                                  text: "•LifeStyle- ",
                                  style:
                                      TextStyle(fontSize: 15.0, color: black),
                                ),
                              ),
                                  ...List.generate(
                                    (widget.pd.length == 0)
                                        ? 0
                                        : (widget.pd.last.lifestyle == null)

                                            ? 0
                                            : (widget.pd.last.lifestyle.data.length ==
                                                    0
                                                ? 0
                                                : widget.pd.last.lifestyle.data
                                                    .length),
                                    (index) => Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 3.0),
                                          child: Container(
                                            child: (widget.pd.length == 0)
                                                ? 0
                                                : (widget.pd.last.lifestyle.data ==
                                                        null)
                                                    ? 0
                                                    : widget.pd.last.lifestyle.data
                                                                .length ==
                                                            0
                                                        ? Text('No Data')
                                                        : RichText(
                                                            text: TextSpan(
                                                              text:
                                                                  "•${widget.pd.last.lifestyle.data[index].title} ",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      15.0,
                                                                  color: orangef),
                                                            ),
                                                          ),
                                          ),
                                        )),]
                              )
                              //       Container(
                              // width: MediaQuery.of(context).size.width,
                              // child: ),
                            ]))
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
