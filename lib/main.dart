import 'package:flutter/material.dart';
import 'package:getcure_doctor/Database/ExaminationTable.dart';
import 'package:getcure_doctor/Database/FeedBackTable.dart';
import 'package:getcure_doctor/Database/HabitsTable.dart';
import 'package:getcure_doctor/Database/MedicinesTable.dart';
import 'package:getcure_doctor/Database/PatientsTable.dart';
import 'package:getcure_doctor/Database/PatientsVisitTable.dart';
import 'package:getcure_doctor/Database/Recommendation.dart';
import 'package:getcure_doctor/Database/SymptomsTable.dart';
import 'package:getcure_doctor/Database/TokenTable.dart';
import 'package:getcure_doctor/Screens/Appointments/Appointment.dart';
import 'package:getcure_doctor/Screens/login.dart';
import 'package:getcure_doctor/provider/ExaminationProvider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(providers: [
    Provider<TokenDB>(
      create: (context) => TokenDB(),
      dispose: (context, db) => db.close(),
    ),
    ChangeNotifierProvider.value(value: ExaminationProvider()),
    Provider<PatientsVisitDB>(
      create: (context) => PatientsVisitDB(),
      dispose: (context, db) => db.close(),
    ),
    Provider<PatientsDB>(
      create: (context) => PatientsDB(),
      dispose: (context, db) => db.close(),
    ),
    Provider<MedicinesDB>(
      create: (context) => MedicinesDB(),
      dispose: (context, db) => db.close(),
    ),
    Provider<SymptomsDB>(
      create: (context) => SymptomsDB(),
      dispose: (context, db) => db.close(),
    ),
    Provider<ExaminationsDB>(
      create: (context) => ExaminationsDB(),
      dispose: (context, db) => db.close(),
    ),
    Provider<FeedBackDB>(
      create: (context) => FeedBackDB(),
      dispose: (context, db) => db.close(),
    ),
    Provider<RecommendationDB>(
      create: (context) => RecommendationDB(),
      dispose: (context, db) => db.close(),
    ),
    Provider<HabitDB>(
      create: (context) => HabitDB(),
      dispose: (context, db) => db.close(),
    )
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(accentColor: Colors.orange),
      home: SafeArea(child: SController()),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SController extends StatefulWidget {
  @override
  _SControllerState createState() => _SControllerState();
}

class _SControllerState extends State<SController> {
  String p;

  isLoggedin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString('docToken');
    print(token);
    if (token == null) {
      setState(() {
        p = 'login';
      });
    } else {
      setState(() {
        p = 'home';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    isLoggedin();
  }

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<TokenDB>(context);
    final patientDatabase = Provider.of<PatientsDB>(context);

    switch (p) {
      case 'login':
        return LoginPage(
          database: database,
          patientDatabase: patientDatabase,
        );
      case 'home':
        return Appointments(
          database: database,
          patientDatabase: patientDatabase,
        );
      default:
        return LoginPage(
          database: database,
          patientDatabase: patientDatabase,
        );
    }
  }
}
