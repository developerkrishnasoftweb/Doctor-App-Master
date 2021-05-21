import 'package:flutter/material.dart';
import 'package:getcure_doctor/Helpers/AppConfig/colors.dart';
import 'package:getcure_doctor/Models/Appointments/DoctorAppointmentHistoryModel.dart';
import 'package:intl/intl.dart';

class AppointmentHistoryDetails extends StatefulWidget {
  final HistoryData historyData;

  const AppointmentHistoryDetails({Key key, this.historyData})
      : super(key: key);

  @override
  _AppointmentHistoryDetailsState createState() =>
      _AppointmentHistoryDetailsState();
}

class _AppointmentHistoryDetailsState extends State<AppointmentHistoryDetails> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController patientNameCtrl; 
  TextEditingController ageCtrl;
  TextEditingController addressCtrl;
  TextEditingController mobileCtrl;
  TextEditingController appTypeCtrl;
  TextEditingController appIDCtrl;
  TextEditingController visitTypeCtrl;
  TextEditingController bookedTypeCtrl;
  TextEditingController appTimeCtrl;
  TextEditingController bookTimeCtrl;
  TextEditingController presentTimeCtrl;

  @override
  void initState() {
    super.initState();
    patientNameCtrl = TextEditingController();
    ageCtrl = TextEditingController();
    addressCtrl = TextEditingController();
    mobileCtrl = TextEditingController();
    appTypeCtrl = TextEditingController();
    appIDCtrl = TextEditingController();
    visitTypeCtrl = TextEditingController();
    bookedTypeCtrl = TextEditingController();
    appTimeCtrl = TextEditingController();
    bookTimeCtrl = TextEditingController();
    presentTimeCtrl = TextEditingController();

    setState(() {
      patientNameCtrl.text=widget.historyData.patient.name;
      ageCtrl.text=widget.historyData.patient.age.toString();
      addressCtrl.text = widget.historyData.patient.address;
      mobileCtrl.text=widget.historyData.patient.mobileNo;
      appTypeCtrl.text=widget.historyData.appointmentType;
      appIDCtrl.text=widget.historyData.appointmentId;
      visitTypeCtrl.text=widget.historyData.visitType;
      bookedTypeCtrl.text=widget.historyData.bookingType;
      appTimeCtrl.text=widget.historyData.appointmentTime == null
                              ? ''
                              : DateFormat('dd-MM-yyyy')
                                  .format((DateTime.parse(
                                      widget.historyData.appointmentTime)))
                                  .toString() + " " +DateFormat.Hms()
                                  .format((DateTime.parse(
                                      widget.historyData.appointmentTime)))
                                  .toString();
      bookTimeCtrl.text=widget.historyData.bookedAt == null
                              ? ''
                              : DateFormat('dd-MM-yyyy')
                                  .format((DateTime.parse(
                                      widget.historyData.bookedAt)))
                                  .toString() + " " +DateFormat.Hms()
                                  .format((DateTime.parse(
                                      widget.historyData.bookedAt)))
                                  .toString();
      presentTimeCtrl.text=widget.historyData.presentTime == null
                              ? ''
                              : DateFormat('dd-MM-yyyy')
                                  .format((DateTime.parse(
                                      widget.historyData.presentTime)))
                                  .toString() + " " +DateFormat.Hms()
                                  .format((DateTime.parse(
                                      widget.historyData.presentTime)))
                                  .toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
        child: AlertDialog(
      titlePadding: EdgeInsets.zero,
      // backgroundColor: pcolor,
      scrollable: true,
      title: Container(
        alignment: Alignment.center,
        color: orangep,
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Patient Details of\nGHID : ${widget.historyData.patientId}',
                style: TextStyle(color: white, fontSize: 16),
              ),
              IconButton(
                  icon: Icon(Icons.cancel),
                  onPressed: () {
                    Navigator.pop(context);
                  })
            ],
          ),
        ),
      ),

      actions: <Widget>[
        Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.7,
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  physics: ClampingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8),
                          child: TextFormField(
                            controller: patientNameCtrl,
                            autofocus: true,
                            enabled: false,
                            decoration: InputDecoration(
                              labelText: 'Patients name',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8.0, 2, 8, 2),
                          child: TextFormField(
                            controller: ageCtrl,
                            keyboardType: TextInputType.number,
                            enabled: false,
                            decoration: InputDecoration(
                              labelText: 'Age',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8.0, 2, 8, 2),
                          child: TextFormField(
                            controller: addressCtrl,
                            maxLines: 3,
                            enabled: false,
                            decoration: InputDecoration(
                              labelText: 'Address',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8.0, 2, 8, 2),
                          child: TextFormField(
                            controller: mobileCtrl,
                            keyboardType: TextInputType.number,
                            enabled: false,
                            decoration: InputDecoration(
                              labelText: 'Mobile Number',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                        ),
                        
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8.0, 2, 8, 2),
                          child: TextFormField(
                            controller: appTypeCtrl,
                            autofocus: true,
                            enabled: false,
                            decoration: InputDecoration(
                              labelText: 'Appointment Type',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8.0, 2, 8, 2),
                          child: TextFormField(
                            controller: appIDCtrl,
                            autofocus: true,
                            enabled: false,
                            decoration: InputDecoration(
                              labelText: 'Appointment ID',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8.0, 2, 8, 2),
                          child: TextFormField(
                            controller: visitTypeCtrl,
                            autofocus: true,
                            enabled: false,
                            decoration: InputDecoration(
                              labelText: 'Visit Type',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8.0, 2, 8, 2),
                          child: TextFormField(
                            controller: bookedTypeCtrl,
                            autofocus: true,
                            enabled: false,
                            decoration: InputDecoration(
                              labelText: 'Booked Type',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8.0, 2, 8, 2),
                          child: TextFormField(
                            controller: appTimeCtrl,
                            autofocus: true,
                            enabled: false,
                            decoration: InputDecoration(
                              labelText: 'Appointment Time',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8.0, 2, 8, 2),
                          child: TextFormField(
                            controller: bookTimeCtrl,
                            autofocus: true,
                            enabled: false,
                            decoration: InputDecoration(
                              labelText: 'Booked Time',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8.0, 2, 8, 2),
                          child: TextFormField(
                            controller: presentTimeCtrl,
                            autofocus: true,
                            enabled: false,
                            decoration: InputDecoration(
                              labelText: 'Present Time',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Visit Reasons:',
                              style: TextStyle(color: blue, fontSize: 16),
                            ),
                            SizedBox(
                              height: widget.historyData.visitReason == null ||
                                      widget.historyData.visitReason.length == 0
                                  ? 0
                                  : widget.historyData.visitReason.length <= 3
                                      ? 50
                                      : 100,
                              child: ListView.builder(
                                physics: ClampingScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: widget.historyData.visitReason ==
                                            null ||
                                        widget.historyData.visitReason.length ==
                                            0
                                    ? 0
                                    : widget.historyData.visitReason.length,
                                itemBuilder: (_, index) {
                                  return Text(widget
                                      .historyData.visitReason[index].title);
                                },
                              ),
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Brief History:',
                              style: TextStyle(color: blue, fontSize: 16),
                            ),
                            SizedBox(
                              height: widget.historyData.briefHistory == null ||
                                      widget.historyData.briefHistory.length ==
                                          0
                                  ? 0
                                  : widget.historyData.briefHistory.length <= 3
                                      ? 50
                                      : 100,
                              child: ListView.builder(
                                physics: ClampingScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: widget.historyData.briefHistory ==
                                            null ||
                                        widget.historyData.briefHistory
                                                .length ==
                                            0
                                    ? 0
                                    : widget.historyData.briefHistory.length,
                                itemBuilder: (_, index) {
                                  return Text(widget
                                      .historyData.briefHistory[index].title);
                                },
                              ),
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Allergies:',
                              style: TextStyle(color: blue, fontSize: 16),
                            ),
                            SizedBox(
                              height: widget.historyData.allergies == null ||
                                      widget.historyData.allergies.length == 0
                                  ? 0
                                  : widget.historyData.allergies.length <= 3
                                      ? 50
                                      : 100,
                              child: ListView.builder(
                                physics: ClampingScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: widget.historyData.allergies ==
                                            null ||
                                        widget.historyData.allergies.length == 0
                                    ? 0
                                    : widget.historyData.allergies.length,
                                itemBuilder: (_, index) {
                                  return Text(
                                      widget.historyData.allergies[index]);
                                },
                              ),
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'LifeStyle:',
                              style: TextStyle(color: blue, fontSize: 16),
                            ),
                            SizedBox(
                              height: widget.historyData.lifestyle == null ||
                                      widget.historyData.lifestyle.length == 0
                                  ? 0
                                  : widget.historyData.lifestyle.length <= 3
                                      ? 50
                                      : 100,
                              child: ListView.builder(
                                physics: ClampingScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: widget.historyData.lifestyle ==
                                            null ||
                                        widget.historyData.lifestyle.length == 0
                                    ? 0
                                    : widget.historyData.lifestyle.length,
                                itemBuilder: (_, index) {
                                  return Text(
                                      widget.historyData.lifestyle[index]);
                                },
                              ),
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Diagnosis:',
                              style: TextStyle(color: blue, fontSize: 16),
                            ),
                            SizedBox(
                              height: widget.historyData.diagnosis == null ||
                                      widget.historyData.diagnosis.length == 0
                                  ? 0
                                  : widget.historyData.diagnosis.length <= 3
                                      ? 50
                                      : 100,
                              child: ListView.builder(
                                physics: ClampingScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: widget.historyData.diagnosis ==
                                            null ||
                                        widget.historyData.diagnosis.length == 0
                                    ? 0
                                    : widget.historyData.diagnosis.length,
                                itemBuilder: (_, index) {
                                  return Text(widget
                                      .historyData.diagnosis[index].title);
                                },
                              ),
                            )
                          ],
                        ),
                        Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Medication:',
                              style: TextStyle(color: blue, fontSize: 16),
                            ),
                            SizedBox(
                              height: widget.historyData.medication == null ||
                                      widget.historyData.medication.length == 0
                                  ? 0
                                  : widget.historyData.medication.length <= 3
                                      ? 50
                                      : 100,
                              child: ListView.builder(
                                physics: ClampingScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: widget.historyData.medication ==
                                            null ||
                                        widget.historyData.medication.length ==
                                            0
                                    ? 0
                                    : widget.historyData.medication.length,
                                itemBuilder: (_, index) {
                                  return Text(widget
                                      .historyData.medication[index].disease);
                                },
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )),
        // Container(
        //     height: MediaQuery.of(context).size.height * 0.7,
        //     width: MediaQuery.of(context).size.width,
        //     child: SingleChildScrollView(
        //       physics: ClampingScrollPhysics(),
        //       child: Padding(
        //         padding:
        //             const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
        //         child: Column(
        //           mainAxisAlignment: MainAxisAlignment.spaceAround,
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             Row(
        //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //               children: [
        //                 Text(
        //                   'Patient Name:',
        //                   style: TextStyle(color: white, fontSize: 16),
        //                 ),
        //                 Text(
        //                   '${widget.historyData.patientName}',
        //                   style: TextStyle(color: black, fontSize: 16),
        //                 ),
        //               ],
        //             ),
        //             Row(
        //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //               children: [
        //                 Text(
        //                   'Age:',
        //                   style: TextStyle(color: white, fontSize: 16),
        //                 ),
        //                 Text(
        //                   widget.historyData.patient.age == null
        //                       ? ''
        //                       : '${widget.historyData.patient.age}',
        //                   style: TextStyle(color: black, fontSize: 16),
        //                 ),
        //               ],
        //             ),
        //             Wrap(
        //               // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //               children: [
        //                 Text(
        //                   'Address:',
        //                   style: TextStyle(color: white, fontSize: 16),
        //                 ),
        //                 Text(
        //                   '${widget.historyData.patient.address}',
        //                   style: TextStyle(color: black, fontSize: 16),
        //                 ),
        //               ],
        //             ),
        //             Row(
        //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //               children: [
        //                 Text(
        //                   'Mobile No.:',
        //                   style: TextStyle(color: white, fontSize: 16),
        //                 ),
        //                 Text(
        //                   '${widget.historyData.patient.mobileNo}',
        //                   style: TextStyle(color: black, fontSize: 16),
        //                 ),
        //               ],
        //             ),
        //             Row(
        //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //               children: [
        //                 Text(
        //                   'Appointment Type:',
        //                   style: TextStyle(color: white, fontSize: 16),
        //                 ),
        //                 Text(
        //                   '${widget.historyData.appointmentType}',
        //                   style: TextStyle(color: black, fontSize: 16),
        //                 ),
        //               ],
        //             ),
        //             Row(
        //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //               children: [
        //                 Text(
        //                   'Appointment ID:',
        //                   style: TextStyle(color: white, fontSize: 16),
        //                 ),
        //                 Text(
        //                   widget.historyData.appointmentId!=null?widget.historyData.appointmentId:'',
        //                   style: TextStyle(color: black, fontSize: 16),
        //                 ),
        //               ],
        //             ),
        //             Row(
        //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //               children: [
        //                 Text(
        //                   'Visit Type:',
        //                   style: TextStyle(color: white, fontSize: 16),
        //                 ),
        //                 Text(
        //                   '${widget.historyData.visitType}',
        //                   style: TextStyle(color: black, fontSize: 16),
        //                 ),
        //               ],
        //             ),
        //             Row(
        //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //               children: [
        //                 Text(
        //                   'Booked Type:',
        //                   style: TextStyle(color: white, fontSize: 16),
        //                 ),
        //                 Text(
        //                   '${widget.historyData.bookingType}',
        //                   style: TextStyle(color: black, fontSize: 16),
        //                 ),
        //               ],
        //             ),
        //             Row(
        //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //               children: [
        //                 Text(
        //                   'Booked Time:',
        //                   style: TextStyle(color: white, fontSize: 16),
        //                 ),
        //                 Text(
        //                   widget.historyData.appointmentTime == null
        //                       ? ''
        //                       : DateFormat('dd-MM-yyyy')
        //                           .format((DateTime.parse(
        //                               widget.historyData.appointmentTime)))
        //                           .toString() + " " +DateFormat.Hms()
        //                           .format((DateTime.parse(
        //                               widget.historyData.appointmentTime)))
        //                           .toString() ,
        //                   style: TextStyle(color: black, fontSize: 16),
        //                 ),
        //               ],
        //             ),
        //             Row(
        //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //               children: [
        //                 Text(
        //                   'Present Time:',
        //                   style: TextStyle(color: white, fontSize: 16),
        //                 ),
        //                 Text(
        //                   widget.historyData.presentTime == null
        //                       ? ''
        //                       : DateFormat('dd-MM-yyyy')
        //                           .format((DateTime.parse(
        //                               widget.historyData.presentTime)))
        //                           .toString(),
        //                   style: TextStyle(color: black, fontSize: 16),
        //                 ),
        //               ],
        //             ),
        //             Column(
        //               mainAxisAlignment: MainAxisAlignment.center,
        //               children: [
        //                 Text(
        //                   'Visit Reasons:',
        //                   style: TextStyle(color: white, fontSize: 16),
        //                 ),
        //                 SizedBox(
        //                   height: widget.historyData.visitReason == null ||
        //                           widget.historyData.visitReason.length == 0
        //                       ? 0
        //                       : widget.historyData.visitReason.length <= 3
        //                           ? 50
        //                           : 100,
        //                   child: ListView.builder(
        //                     physics: ClampingScrollPhysics(),
        //                     shrinkWrap: true,
        //                     scrollDirection: Axis.vertical,
        //                     itemCount: widget.historyData.visitReason == null ||
        //                             widget.historyData.visitReason.length == 0
        //                         ? 0
        //                         : widget.historyData.visitReason.length,
        //                     itemBuilder: (_, index) {
        //                       return Center(
        //                         child: Text(widget
        //                             .historyData.visitReason[index].title),
        //                       );
        //                     },
        //                   ),
        //                 )
        //               ],
        //             ),
        //             Column(
        //               mainAxisAlignment: MainAxisAlignment.center,
        //               children: [
        //                 Text(
        //                   'Brief History:',
        //                   style: TextStyle(color: white, fontSize: 16),
        //                 ),
        //                 SizedBox(
        //                   height: widget.historyData.briefHistory == null ||
        //                           widget.historyData.briefHistory.length == 0
        //                       ? 0
        //                       : widget.historyData.briefHistory.length <= 3
        //                           ? 50
        //                           : 100,
        //                   child: ListView.builder(
        //                     physics: ClampingScrollPhysics(),
        //                     shrinkWrap: true,
        //                     scrollDirection: Axis.vertical,
        //                     itemCount: widget.historyData.briefHistory ==
        //                                 null ||
        //                             widget.historyData.briefHistory.length == 0
        //                         ? 0
        //                         : widget.historyData.briefHistory.length,
        //                     itemBuilder: (_, index) {
        //                       return Center(
        //                         child: Text(widget
        //                             .historyData.briefHistory[index].title),
        //                       );
        //                     },
        //                   ),
        //                 )
        //               ],
        //             ),
        //             Column(
        //               mainAxisAlignment: MainAxisAlignment.center,
        //               children: [
        //                 Text(
        //                   'Allergies:',
        //                   style: TextStyle(color: white, fontSize: 16),
        //                 ),
        //                 SizedBox(
        //                   height: widget.historyData.allergies == null ||
        //                           widget.historyData.allergies.length == 0
        //                       ? 0
        //                       : widget.historyData.allergies.length <= 3
        //                           ? 50
        //                           : 100,
        //                   child: ListView.builder(
        //                     physics: ClampingScrollPhysics(),
        //                     shrinkWrap: true,
        //                     scrollDirection: Axis.vertical,
        //                     itemCount: widget.historyData.allergies == null ||
        //                             widget.historyData.allergies.length == 0
        //                         ? 0
        //                         : widget.historyData.allergies.length,
        //                     itemBuilder: (_, index) {
        //                       return Center(
        //                         child:
        //                             Text(widget.historyData.allergies[index]),
        //                       );
        //                     },
        //                   ),
        //                 )
        //               ],
        //             ),
        //             Column(
        //               mainAxisAlignment: MainAxisAlignment.center,
        //               children: [
        //                 Text(
        //                   'LifeStyle:',
        //                   style: TextStyle(color: white, fontSize: 16),
        //                 ),
        //                 SizedBox(
        //                   height: widget.historyData.lifestyle == null ||
        //                           widget.historyData.lifestyle.length == 0
        //                       ? 0
        //                       : widget.historyData.lifestyle.length <= 3
        //                           ? 50
        //                           : 100,
        //                   child: ListView.builder(
        //                     physics: ClampingScrollPhysics(),
        //                     shrinkWrap: true,
        //                     scrollDirection: Axis.vertical,
        //                     itemCount: widget.historyData.lifestyle == null ||
        //                             widget.historyData.lifestyle.length == 0
        //                         ? 0
        //                         : widget.historyData.lifestyle.length,
        //                     itemBuilder: (_, index) {
        //                       return Center(
        //                         child:
        //                             Text(widget.historyData.lifestyle[index]),
        //                       );
        //                     },
        //                   ),
        //                 )
        //               ],
        //             ),
        //             Column(
        //               mainAxisAlignment: MainAxisAlignment.center,
        //               children: [
        //                 Text(
        //                   'Diagnosis:',
        //                   style: TextStyle(color: white, fontSize: 16),
        //                 ),
        //                 SizedBox(
        //                   height: widget.historyData.diagnosis == null ||
        //                           widget.historyData.diagnosis.length == 0
        //                       ? 0
        //                       : widget.historyData.diagnosis.length <= 3
        //                           ? 50
        //                           : 100,
        //                   child: ListView.builder(
        //                     physics: ClampingScrollPhysics(),
        //                     shrinkWrap: true,
        //                     scrollDirection: Axis.vertical,
        //                     itemCount: widget.historyData.diagnosis == null ||
        //                             widget.historyData.diagnosis.length == 0
        //                         ? 0
        //                         : widget.historyData.diagnosis.length,
        //                     itemBuilder: (_, index) {
        //                       return Center(
        //                         child: Text(
        //                             widget.historyData.diagnosis[index].title),
        //                       );
        //                     },
        //                   ),
        //                 )
        //               ],
        //             ),
        //             Column(
        //               mainAxisAlignment: MainAxisAlignment.center,
        //               children: [
        //                 Text(
        //                   'Medication:',
        //                   style: TextStyle(color: white, fontSize: 16),
        //                 ),
        //                 SizedBox(
        //                   height: widget.historyData.medication == null ||
        //                           widget.historyData.medication.length == 0
        //                       ? 0
        //                       : widget.historyData.medication.length <= 3
        //                           ? 50
        //                           : 100,
        //                   child: ListView.builder(
        //                     physics: ClampingScrollPhysics(),
        //                     shrinkWrap: true,
        //                     scrollDirection: Axis.vertical,
        //                     itemCount: widget.historyData.medication == null ||
        //                             widget.historyData.medication.length == 0
        //                         ? 0
        //                         : widget.historyData.medication.length,
        //                     itemBuilder: (_, index) {
        //                       return Center(
        //                         child: Text(widget
        //                             .historyData.medication[index].disease),
        //                       );
        //                     },
        //                   ),
        //                 )
        //               ],
        //             ),
        //           ],
        //         ),
        //       ),
        //     ))
      ],
    ));
  }
}