import 'package:flutter/material.dart';
import 'package:getcure_doctor/Database/PatientsVisitTable.dart';
import 'package:getcure_doctor/Database/TokenTable.dart';
import 'package:getcure_doctor/Helpers/AppConfig/colors.dart';
import 'package:intl/intl.dart';

class PatientVisitDialog extends StatefulWidget {
  final Token token;
  final PatientsVisitDB pat;
  final List<PatientsVisitData> pd;
  const PatientVisitDialog({Key key, this.token, this.pat,this.pd}) : super(key: key);
  @override
  _PatientVisitDialogState createState() => _PatientVisitDialogState();
}

class _PatientVisitDialogState extends State<PatientVisitDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 24,
      titlePadding: EdgeInsets.zero,
      title: Container(
        width: MediaQuery.of(context).size.width,
        color: green,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Patient Visit Details",
                style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold, color: white),
              ),
            ),
            IconButton(
                icon: Icon(Icons.cancel),
                onPressed: () => Navigator.pop(context))
          ],
        ),
      ),
      content: FutureBuilder(
        future: widget.pat.getDiagnosis(widget.token.guid),
        builder: (BuildContext context,
            AsyncSnapshot<List<PatientsVisitData>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(),
              );
              break;
            case ConnectionState.done:
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  height: MediaQuery.of(context).size.height*0.65,
                  width: MediaQuery.of(context).size.width,
                  child: PageView.builder(
                    itemBuilder: (context, index) {
                      return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              DateFormat.yMEd().format(
                                  snapshot.data[index].appointmentsTime),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Center(
                                child: Text("Noticeable",textAlign: TextAlign.center,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                            ),
                            Wrap(
                              alignment: WrapAlignment.spaceBetween,
                              // crossAxisAlignment: WrapCrossAlignment.start,
                              children: 
                              [...List.generate(
                                  (widget.pd.length == 0)
                                      ? 0
                                      : (widget.pd.last.visitReason == null)
                                          ? (0)
                                          : (widget.pd.last.visitReason.data.length == 0
                                              ? (0)
                                              : widget.pd.last.visitReason.data.length),
                                  (index) => Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 2.0),
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
                                                                      "${widget.pd.last.visitReason.data[index].title} ",
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
                                       double.parse(widget.pd.last.temperature) > 99 ||
                                      double.parse(widget.pd.last.temperature) < 97
                                  ? RichText(
                                      text: TextSpan(
                                          text: "Temp- ",
                                          style: TextStyle(
                                              fontSize: 15.0, color: black),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: (widget.pd.length == 0)
                                                  ? "0"
                                                  : "${widget.pd.last.temperature}",
                                              style: TextStyle(
                                                  fontSize: 15.0,
                                                  color: orangef),
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
                                          text: "B.P- ",
                                          style: TextStyle(
                                              fontSize: 15.0, color: black),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: (widget.pd.length == 0)
                                                  ? "0"
                                                  : "${widget.pd.last.bp}",
                                              style: TextStyle(
                                                  fontSize: 15.0,
                                                  color: orangef),
                                            )
                                          ]),
                                    )
                                  : Container(),

                             (widget.pd.last.pulse!=null && widget.pd.last.pulse!="")?  int.parse(widget.pd.last.pulse) > 100 ||
                                      int.parse(widget.pd.last.pulse) < 60
                                  ? RichText(
                                      text: TextSpan(
                                          text: "Pulse- ",
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
                                          text: "Weight- ",
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
                                  text: "Allergies: ",
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
                                                                  color: black),
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
                                  text: "LifeStyle: ",
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
                                                                  color: black),
                                                            ),
                                                          ),
                                          ),
                                        )),]
                              )
                                      ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Center(
                                child: Text("Diagnosis",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                            ),
                            ListView.builder(
                              itemCount:snapshot.data[index].diagnosis==null?0:
                                  snapshot.data[index].diagnosis.data.length,
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              itemBuilder: (BuildContext context, int dIndex) {
                                return RichText(
                                  text: TextSpan(
                                    text: snapshot.data[index].diagnosis.data[dIndex]
                                          .title,
                                          style: TextStyle(
                                            color:black,
                                            fontSize: 15
                                          ),             
                                    children: [
                                      TextSpan(
                                        text: "  (" +
                                      snapshot.data[index].diagnosis
                                          .data[dIndex].date +
                                      ")",
                                      style: TextStyle(
                                        color: orangef
                                      )

                                      )
                                    ]                     
                                  ),
                                );
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Center(
                                child: Text("Medication",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                            ),
                            ListView.builder(
                              itemCount:snapshot.data[index].medication==null?0:
                                  snapshot.data[index].medication.data.length,
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              itemBuilder: (BuildContext context, int mIndex) {
                                return ListView.builder(
                                  itemCount: snapshot.data[index].medication
                                      .data[mIndex].medicines.length,
                                  shrinkWrap: true,
                                  physics: ScrollPhysics(),
                                  itemBuilder:
                                      (BuildContext context, int pmIndex) {
                                    return ListTile(
                                      title: Text(
                                        snapshot
                                            .data[index]
                                            .medication
                                            .data[mIndex]
                                            .medicines[pmIndex]
                                            .title,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400),
                                        maxLines: 2,
                                      ),
                                      subtitle: Text(snapshot
                                              .data[index]
                                              .medication
                                              .data[mIndex]
                                              .medicines[pmIndex]
                                              .dose +
                                          snapshot
                                              .data[index]
                                              .medication
                                              .data[mIndex]
                                              .medicines[pmIndex]
                                              .direction +
                                          snapshot
                                              .data[index]
                                              .medication
                                              .data[mIndex]
                                              .medicines[pmIndex]
                                              .duration +
                                          snapshot
                                              .data[index]
                                              .medication
                                              .data[mIndex]
                                              .medicines[pmIndex]
                                              .frequency +
                                          snapshot
                                              .data[index]
                                              .medication
                                              .data[mIndex]
                                              .medicines[pmIndex]
                                              .route +
                                          snapshot
                                              .data[index]
                                              .medication
                                              .data[mIndex]
                                              .medicines[pmIndex]
                                              .unit,
                                              style: TextStyle(
                                                color:blue
                                              ),
                                              ),
                                    );
                                  },
                                );
                              },
                            ),
                          ]);
                    },
                    itemCount: snapshot.data.length,
                  ),
                ),
              );
              break;
            default:
              return Text("Something went wrong");
          }
        },
      ),
    );
  }
}
