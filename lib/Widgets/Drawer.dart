import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getcure_doctor/Database/SymptomsTable.dart';
import 'package:getcure_doctor/Database/TokenTable.dart';
import 'package:getcure_doctor/Helpers/AppConfig/colors.dart';
import 'package:getcure_doctor/Helpers/Navigation.dart';
import 'package:getcure_doctor/Models/DoctorLogin.dart';
import 'package:getcure_doctor/Screens/Analysis/DiseaseAnalysis.dart';
import 'package:getcure_doctor/Screens/Appointments/AppointmentsHistory.dart';
import 'package:getcure_doctor/Screens/Appointments/DoctorInvoice.dart';
import 'package:getcure_doctor/Screens/Appointments/ListDocPatients.dart';
import 'package:getcure_doctor/Screens/DoctorRegistration/UpdateProfile.dart';
import 'package:getcure_doctor/Screens/login.dart';
import 'package:getcure_doctor/Widgets/DoctorHoliday.dart';
import 'package:getcure_doctor/Widgets/Image%20save/im.dart';
import 'package:getcure_doctor/Widgets/TimingGeneration.dart';
import 'package:getcure_doctor/provider/UserProvider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'AddDataBase.dart';

class DrawerWidget extends StatelessWidget {
  final String name;
  final String clinicid;
  final String id;
  final int docId;
  final List<ClinicDoctor> clinicDoctor;
  final DateTime date;
  final VoidCallback getDoctors;
  final int clinicDocId;
  final DoctorLoginData docUser;
  const DrawerWidget(
      {Key key,
        this.name,
        this.clinicid,
        this.docId,
        this.clinicDoctor,
        this.id,
        this.date, this.getDoctors, this.clinicDocId, this.docUser})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<TokenDB>(context);
    final symptomDatabase = Provider.of<SymptomsDB>(context);
    //print(clinicid);
    print(docId.toString());
    return Drawer(
      child: new ListView(
        children: <Widget>[
          new UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: orangef),
            accountEmail: Text(docUser.email),
            currentAccountPicture:
            Container(child: CircleAvatar(
              backgroundImage: docUser.imageUrl !=
                  null
                  ? NetworkImage(
                  docUser.imageUrl)
                  : NetworkImage(
                  "https://img.icons8.com/windows/452/person-male.png"),
              maxRadius: 50.0,
            ),
            ),
            accountName: new Text(
              "Dr. $name",
              style: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
            ),

          ),
          ListTile(
            title: Text('Doctor Section'),
            trailing: Icon(Icons.art_track),
            onTap: () {
              Navigator.of(context).pop();
              changeScreen(
                  context,
                  ChangeNotifierProvider(
                    create: (context) => DoctorProvider(),
                    child: ListDocPatients(
                      databse: symptomDatabase,
                      docId: docId,
                      topi: database,
                      date: date,
                      clinicDocId: clinicDocId,
                    ),
                  ));
            },
          ),

          ListTile(
            title: Text('Add Database'),
            trailing: Icon(Icons.data_usage),
            onTap: () {
              Navigator.of(context).pop();
              changeScreen(
                  context,
                  AddDataBase(
                    clinicDocId: clinicDocId,
                    docId: int.parse(id),
                  ));
            },
          ),
          ListTile(
            title: Text('Analysis'),
            trailing: Icon(Icons.insert_chart),
            onTap: () {
              Navigator.of(context).pop();
              changeScreen(context, DiseaseAnalysis(docId: docId));
            },
          ),
          ListTile(
            title: Text('Appointments History'),
            trailing: Icon(Icons.inbox),
            onTap: () {
              Navigator.of(context).pop();
              changeScreen(context,
                  DoctorAppointmentHistory(
                    clinicDoctor: clinicDoctor,
                    docUser: docUser,
                  ));
            },
          ),
          ListTile(
            title: Text('Doctor Invoice'),
            trailing: Icon(Icons.inbox),
            onTap: () {
              Navigator.of(context).pop();
              changeScreen(
                  context,
                  DoctorInvoice(
                    id: id,
                    name: name,
                  ));
            },
          ),
          ListTile(
            title: Text('Account Setttings'),
            trailing: Icon(Icons.settings),
            onTap: () {
              Navigator.of(context).pop();
              changeScreen(
                  context,
                  UpdateProfile(
                    docid: docId.toString(),
                    clinicDoctors: clinicDoctor,
                  ));
            },
          ),
          ListTile(
            trailing: Icon(
              Icons.home,
              color: grey,
            ),
            title: Text('Doctor Holidays'),
            onTap: () {
              Navigator.of(context).pop();
              changeScreen(
                  context,
                  ChangeNotifierProvider(
// <<<<<<< not-good
//                       create: (context) => Holiday(), child: DoctorHolidays(docId: docId,clinicDoctor: clinicDoctor)));
// =======
                      create: (context) => Holiday(),
                      child: DoctorHolidays(
                        docId: docId,

                      )));
// >>>>>>> master
            },
          ),
          ListTile(
            trailing: Icon(
              Icons.access_time,
              color: grey,
            ),
            title: Text('Doctor Timings'),
            onTap: () {
              // String id = docId.toString();
              Navigator.of(context).pop();
              changeScreen(
                  context,
                  ChangeNotifierProvider(
                    create: (context) => Addingtime(),
                    child: TimingGeneration(
                      clinicDoctorId: id,
                      getdoctors: getDoctors,
                    ),
                  ));
            },
          ),
          ListTile(
            trailing: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () async {
              SharedPreferences pref = await SharedPreferences.getInstance();
              pref.clear();
              database.deleteallTask();
              changeScreenRepacement(context, LoginPage());
            },
          ),
        ],
      ),
    );
  }
}
