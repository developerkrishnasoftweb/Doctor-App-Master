import 'dart:convert';
import 'package:getcure_doctor/Database/ExaminationTable.dart';
import 'package:getcure_doctor/Database/FeedBackTable.dart';
import 'package:getcure_doctor/Database/HabitsTable.dart';
import 'package:getcure_doctor/Database/MedicinesTable.dart';
import 'package:getcure_doctor/Database/PatientsTable.dart';
import 'package:getcure_doctor/Database/PatientsVisitTable.dart';
import 'package:getcure_doctor/Database/SymptomsTable.dart';
import 'package:getcure_doctor/Database/TokenTable.dart';
import 'package:getcure_doctor/Helpers/Network/Apis.dart';
import 'package:getcure_doctor/Models/DoctorLogin.dart';
import 'package:getcure_doctor/Models/PatientsVisitTableModels.dart';
import 'package:getcure_doctor/Models/SyncModels/ExamSync.dart';
import 'package:getcure_doctor/Models/SyncModels/ExaminationSync.dart';
import 'package:getcure_doctor/Models/SyncModels/FeedBackDataSync.dart';
import 'package:getcure_doctor/Models/SyncModels/HabitSync.dart';
import 'package:getcure_doctor/Models/SyncModels/MediciensSync.dart';
import 'package:getcure_doctor/Models/SyncModels/ParameterUpdate.dart';
import 'package:getcure_doctor/Models/SyncModels/PatientDataSyncModel.dart';
import 'package:getcure_doctor/Models/SyncModels/PatientVisitModel.dart';
import 'package:getcure_doctor/Models/SyncModels/SymptomsSync.dart';
import 'package:getcure_doctor/Models/SyncModels/SyncCancelled.dart';
import 'package:getcure_doctor/Models/SyncModels/TokensSync.dart';
import 'package:getcure_doctor/Models/SyncModels/UGIDUpdateModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Requesthttp.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

syncTokens(TokenDB tokenDB, int clinicDocId) async {
  String token = await getToken();
  List<Token> list = await tokenDB.getAllSync();
  List<TokenSyncData> li = [];
  if (list.length == 0) {
    return true;
  }
  for (var i in list) {
    print(i.name);
    print(i.presentTime);
    li.add(TokenSyncData(
      appointmentId: i.appointmentId,
      patientId: i.guid,
      patientName: i.name,
      tokenNo: i.tokenno,
      fees: i.fees,
      appointmentType: i.appointmenttype,
      bookingType: i.bookedtype,
      isPresent: i.isPresent,
      clinicDoctorId: clinicDocId,
      visitType: i.visittype,
      date: DateFormat('yyyy-MM-dd').format(i.tokentime),
      time: DateFormat.Hms().format(i.tokentime),
      bookedAt: DateFormat('yyyy-MM-dd').format(i.bookedAt),
      bookedBy: i.bookedBy,
      bookedVia: i.bookedVia,
      presentTime:
          i.presentTime != null ? DateFormat.Hms().format(i.presentTime) : null,
    ));
  }
  print(li.length);

  TokenSync tokenSync = TokenSync(data: li);
  var response = await http.post(
      BASEURL + "/sync-tokens/" + clinicDocId.toString(),
      headers: {"Authorization": token},
      body: {"tokens": json.encode(tokenSync.toJson()['data'])});
  print(json.encode(tokenSync.toJson()['data']));
  print(response.body);
  if (response.statusCode == 200) {
    for (var i in list) {
      tokenDB.updateStatus(i.id);
    }
    return true;
  } else {
    print("Tokens sync failed");
    return false;
  }
}

syncPatient(PatientsDB patientsDB, TokenDB tokenDB,
    PatientsVisitDB patientsVisitDB) async {
  String token = await getToken();
  List<Patient> list = await patientsDB.getAllSync();
  List<PatientDataSyncData> li = [];
  if (list.length == 0) {
    return true;
  }
  for (var i in list) {
    li.add(PatientDataSyncData(
      age: i.age,
      gender: i.gender == Gender.Male ? 'male' : 'female',
      mobileNo: i.mobileNo.toString(),
      address: i.address,
      name: i.name.trim(),
      patientId: i.patientId,
    ));
  }

  PatientDataSync patientDataSync = PatientDataSync(data: li);
  print(json.encode(patientDataSync.toJson()['data']));
  var response = await http.post(PATIENTDATASYNC,
      headers: {"Authorization": token},
      body: {"patients": json.encode(patientDataSync.toJson()['data'])});
  print(response.body);

  if (response.statusCode == 200) {
    print("Sync patient line 109 completed");
    GuidUpdating guidUpdate = GuidUpdating.fromJson(json.decode(response.body));
    for (var id in guidUpdate.patientIds) {
      tokenDB.updateguid(id.previousId, id.newId);
      patientsDB.updateguid(id.previousId, id.newId);
      patientsVisitDB.updateguid(id.previousId, id.newId);
    }
    return true;
  } else {
    print("Sync patient line 118 Failed");
    return false;
  }
}

syncCancelled(TokenDB tokenDB, int id) async {
  List<Token> tokenList = await tokenDB.getCancelledToken(id);
  SyncCancelledTokens syncToken = SyncCancelledTokens(tokens: []);
  for (var i in tokenList) {
    syncToken.tokens.add(CancelledTokens(
        appointmentType: i.appointmenttype,
        date: DateFormat('yyyy-MM-dd').format(i.tokentime),
        time: DateFormat.Hms().format(i.tokentime),
        patientId: i.guid,
        patientName: i.name,
        visitType: i.visittype));
  }
  print(json.encode(syncToken.toJson()['tokens']));
  String token = await getToken();
  var response = await http.post(CANCELBULK + id.toString(),
      headers: {"Authorization": token},
      body: {"tokens": json.encode(syncToken.toJson()['tokens'])});
  print(response.body);
  if (response.statusCode == 200) {
    for (var i in tokenList) {
      tokenDB.updateStatus(i.id);
    }
    print("Cancelled Synced complete page data sync line 145");
  } else {
    print("Cancelled Synced failed page data sync line 147");
  }
}

syncExamination(ExaminationsDB examinationsDB) async {
  String token = await getToken();
  List<Examination> list = await examinationsDB.getAllSync();
  List<ExaminationsDataSync> li = [];
  if (list.length == 0) {
    return true;
  }
  for (var i in list) {
    li.add(ExaminationsDataSync(
      doctorId: i.doctorId,
      parameters: i.parameters.data,
      title: i.title,
    ));
  }
  ExaminationSync examinationSync = ExaminationSync(examinations: li);
  var response = await http.post(EXAMINATIONSYNC, headers: {
    "Authorization": token
  }, body: {
    "examinations": json.encode(examinationSync.toJson()['examinations'])
  });
  print(json.encode(examinationSync.toJson()['examinations']));
  print(response.body);
  if (response.statusCode == 200) {
    print("Sync examination line 170 completed");

    for (var i in list) {
      examinationsDB.updateStatus(i.id);
    }
    return true;
  } else {
    print("Examination sync failed");
    return false;
  }
}

syncHabit(HabitDB habitDB) async {
  String token = await getToken();
  List<Habit> list = await habitDB.getAllSync();
  List<HabitsSyncData> li = [];
  if (list.length == 0) {
    return true;
  }
  for (var i in list) {
    li.add(HabitsSyncData(
        title: i.title,
        doctorId: i.doctorId,
        type: i.type == HType.Allergy ? 'allergy' : "lifestyle"));
  }
  HabitsSync patientDataSync = HabitsSync(habits: li);
  var response = await http.post(HABITSYNC,
      headers: {"Authorization": token},
      body: {"habits": json.encode(patientDataSync.toJson()['habits'])});
  print(json.encode(patientDataSync.toJson()['habits']));
  print(response.body);
  if (response.statusCode == 200) {
    for (var i in list) {
      habitDB.updateStatus(i.id);
    }
    return true;
  } else {
    print("Habit sync failed");
    return false;
  }
}

getVisibility(VisibilityPeriod p) {
  switch (p) {
    case VisibilityPeriod.Always:
      return "always";
      break;
    case VisibilityPeriod.FiveYear:
      return "five year";
      break;
    case VisibilityPeriod.OneYear:
      return "one year";
      break;
    case VisibilityPeriod.SixMonth:
      return "six month";
      break;
    case VisibilityPeriod.ThreeMonth:
      return "three month";
      break;
    default:
      return "one month";
  }
}

syncSymptom(SymptomsDB symptomsDB) async {
  String token = await getToken();
  List<Symptom> list = await symptomsDB.getAllSync();
  List<SymptomDataSync> li = [];
  if (list.length == 0) {
    return true;
  }
  for (var i in list) {
    li.add(SymptomDataSync(
        title: i.title,
        doctorId: i.doctorId,
        visibilityPeriod: getVisibility(i.visibilityPeriod)));
  }
  SymptomSync patientDataSync = SymptomSync(symptoms: li);
  var response = await http.post(SYMPTOMSSYNC,
      headers: {"Authorization": token},
      body: {"symptoms": json.encode(patientDataSync.toJson()['symptoms'])});
  print(json.encode(patientDataSync.toJson()['symptoms']));
  print(response.body);
  if (response.statusCode == 200) {
    for (var i in list) {
      symptomsDB.updateStatus(i.id);
    }
    return true;
  } else {
    print("Symptoms sync failed");
    return false;
  }
}

syncMedicines(MedicinesDB medicinesDB) async {
  String token = await getToken();
  List<Medicine> list = await medicinesDB.getAllSync();
  List<MedicinesSync> li = [];
  if (list.length == 0) {
    return true;
  }
  for (var i in list) {
    li.add(MedicinesSync(
        category: i.category,
        defaultDirection: i.defaultDirection,
        defaultDose: i.defaultDose,
        defaultDuration: i.defaultDuration,
        defaultFrequency: i.defaultFrequency,
        defaultRoute: i.defaultRoute,
        defaultUnit: i.defaultUnit,
        doctorId: i.doctorId,
        interactionDrugs: [
          // i.interactionDrugs
        ], //TODO: string to array  interaction drug
        salt: i.salt,
        title: i.title));
  }
  MedicineDataSync medicineSync = MedicineDataSync(medicines: li);
  var response = await http.post(MEDICINESYNC,
      headers: {"Authorization": token},
      body: {"medicines": json.encode(medicineSync.toJson()['medicines'])});
  print(json.encode(medicineSync.toJson()['medicines']));
  print(response.body);
  if (response.statusCode == 200) {
    for (var i in list) {
      medicinesDB.updateStatus(i.id);
    }
    return true;
  } else {
    print("Sync Medication line 300 failed");

    return false;
  }
}

syncFeedBack(FeedBackDB feedBackDB) async {
  String token = await getToken();
  List<FeedBackData> list = await feedBackDB.getAllSync();
  print(list);
  if (list.length == 0) {
    return true;
  }
  List<Feedbacks> li = [];
  for (var i in list) {
    int ind =
        li.indexWhere((l) => l.appointmentTime == i.appointmentTime.toString());
    if (ind != -1) {
      Feedback temp = Feedback(
          option: i.option,
          medicine: i.medication.medicines,
          question: i.question);
      li[ind].feedback.add(temp);
    } else {
      Feedback temp = Feedback(
          option: i.option,
          medicine: i.medication.medicines,
          question: i.question);
      li.add(Feedbacks(
          appointmentTime: i.appointmentTime.toString().split(".")[0],
          clinicDoctorId: i.clinicDoctorId,
          patientId: i.patientVisitIid,
          feedback: [temp]));
    }
  }
  FeedBackSync patientDataSync = FeedBackSync(feedbacks: li);
  print(patientDataSync);
  var response = await http.post(FEEDBACKSYNC,
      headers: {"Authorization": token},
      body: {"feedbacks": json.encode(patientDataSync.toJson()['feedbacks'])});
  print(json.encode(patientDataSync.toJson()['feedbacks']));
  print(response.body);
  if (response.statusCode == 200) {
    for (var i in list) {
      feedBackDB.updateStatus(i.id);
    }
    return true;
  } else {
    print("Sync FeedBack line 348 failed");

    return false;
  }
}

syncPatientVisit(PatientsVisitDB patientsVisitDB) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  String token = pref.getString('dresponse');
  DoctorLogin doctorLogin = DoctorLogin.fromJson(json.decode(token));
  List<PatientsVisitData> list = await patientsVisitDB.getAll();
  List<PatientVisitSyncData> li = [];
  if (list.length == 0) {
    return true;
  }
  for (var i in list) {
    li.add(PatientVisitSyncData(
      allergies: i.allergies == null
          ? []
          : i.allergies.data.map((e) => e.title).toList(),
      appointmentTime: i.appointmentsTime.toString(),
      appointmentType: i.appointmentType,
      bloodPressure: i.bp.toString(),
      bookedBy: i.bookedBy,
      bookedVia: i.bookedVia,
      fee: i.fee,
      bookingType: i.bookingType,
      briefHistory: i.briefHistory == null ? [] : i.briefHistory.data,
      clinicDoctorId: i.clinicDoctorId,
      diagnosis: i.diagnosis == null ? [] : i.diagnosis.data,
      examination: i.examination == null ? [] : i.examination.data,
      isDoctorFeedback: i.isDoctorFeedBack,
      isPatientFeedback: i.isPatientFeedBack,
      lifestyle: i.lifestyle == null
          ? []
          : i.lifestyle.data.map((e) => e.title).toList(),
      medication: i.medication == null ? [] : i.medication.data,
      patientId: i.patientId,
      patientName: i.patientName,
      presentTime: i.presentTime,
      pulse: int.parse(i.pulse),
      temperature: int.parse(i.temperature),
      visitReason: i.visitReason == null ? [] : i.visitReason.data,
      visitType: i.visitType,
      weight: int.parse(i.weight),
      bookedAt: 'Demo',
    ));
  }
  PatientVisitSync patientVisitSync = PatientVisitSync(data: li);

  var response = await http.post(PATIENTVISITSYNC,
      headers: {"Authorization": doctorLogin.token},
      body: {"patient_visits": json.encode(patientVisitSync.toJson()['data'])});
  print(json.encode(patientVisitSync.toJson()['data']));
  print(response.body);
  if (response.statusCode == 200) {
    print("syncPatientVisit line 397 completed");

    for (var i in list) {
      patientsVisitDB.updateStatus(i.id);
    }
    return true;
  } else {
    print("syncPatientVisit line 397 failed");

    return false;
  }
}

setVisibility(String p) {
  switch (p) {
    case "always":
      return VisibilityPeriod.Always;
      break;
    case "five year":
      return VisibilityPeriod.FiveYear;
      break;
    case "one year":
      return VisibilityPeriod.OneYear;
      break;
    case "six month":
      return VisibilityPeriod.SixMonth;
      break;
    case "three month":
      return VisibilityPeriod.ThreeMonth;
      break;
    default:
      return VisibilityPeriod.OneMonth;
  }
}

fetchData(int docId, SymptomsDB symptomsDB, int clinicDocId) async {
  String token = await getToken();
  var response = await http.get(
    BASEURL + "/symptoms",
    headers: {"Authorization": token},
  );
  if (response.statusCode == 200) {
    SymptomSync symptomSync = SymptomSync.fromJson(json.decode(response.body));
    print(response.body);
    print(symptomSync.symptoms.first.title);
    for (var i in symptomSync.symptoms) {
      symptomsDB.addBrief(i.title, setVisibility(i.visibilityPeriod), docId, clinicDocId);
    }
  }
}

fetchExamination(String docId, ExaminationsDB examinationsDB) async {
  String token = await getToken();
  var response = await http.get(
    BASEURL + "/examinations",
    headers: {"Authorization": token},
  );
  if (response.statusCode == 200) {
    SyncExam symptomSync = SyncExam.fromJson(json.decode(response.body));
    print(response.body);
    for (var i in symptomSync.data) {
      var exm = Examination(
        clinicDoctorId: i.doctorId,
        doctorId: i.doctorId,
        isOnline: true,
        price: i.price == null ? 0 : i.price,
        title: i.title,
        parameters: Parameters2(data: i.parameters),
      );
      examinationsDB.insertTask(exm);
    }
  }
}

fetchMedication(String docId, MedicinesDB medicinesDB) async {
  String token = await getToken();
  print(docId);
  var response = await http.get(
    BASEURL + "/medicines/" + docId,
    headers: {"Authorization": token},
  );
  if (response.statusCode == 200) {
    MedicineDataSync symptomSync =
        MedicineDataSync.fromJson(json.decode(response.body));
    print(response.body);
    for (var i in symptomSync.medicines) {
      var med = Medicine(
          clinicDoctorId: i.doctorId,
          doctorId: i.doctorId,
          title: i.title,
          defaultUnit: i.defaultUnit,
          defaultRoute: i.defaultRoute,
          defaultFrequency: i.defaultFrequency,
          defaultDirection: i.defaultDirection,
          defaultDuration: i.defaultDuration,
          salt: i.salt,
          interactionDrugs: InteractionDruggenerated(
              interactionDrug:
                  i.interactionDrugs.length == 0 ? [] : i.interactionDrugs),
          category: i.category,
          defaultDose: i.defaultDose,
          isOnline: true);
      medicinesDB.insertHttp(med);
    }
  }
}

fetchHabits(String docId, HabitDB habitDB) async {
  String token = await getToken();
  print(docId);
  var response = await http.get(
    BASEURL + "/habits/" + docId,
    headers: {"Authorization": token},
  );
  if (response.statusCode == 200) {
    HabitsSync habitSync = HabitsSync.fromJson(json.decode(response.body));
    print(response.body);
    print(habitSync.toJson());
    for (var i in habitSync.habits) {
      var hb = Habit(
          doctorId: i.doctorId,
          title: i.title,
          type: i.type == "allergy" ? HType.Allergy : HType.LifeStyle,
          isOnline: true);
      habitDB.insert(hb);
    }
  }
}

fetchFeedback(String clinicDocId, FeedBackDB feedDB, int doctorId) async {
  String token = await getToken();
  print(clinicDocId);
  var response = await http.get(
    BASEURL + "/feedbacks/" + clinicDocId,
    headers: {"Authorization": token},
  );
  if (response.statusCode == 200) {
    FeedbackAPISync feedSync =
        FeedbackAPISync.fromJson(json.decode(response.body));
    print(response.body);
    print(feedSync.toJson());
    for (var i in feedSync.feedbacks) {
      var fh = FeedBackData(
          doctorId: doctorId,
          clinicDoctorId: i.clinicDoctorId,
          patientVisitIid: i.patientVisitId.toString(),
          option: i.option,
          question: i.question,
          medication:
              MedicationData(disease: i.question, medicines: i.medicine),
          isOnline: true);
      feedDB.insert(fh);
    }
  }
}

fetchPatientsVisit(String clinicDocId, PatientsVisitDB pvDB) async {
  String token = await getToken();
  print(clinicDocId);
  var response = await http.get(
    BASEURL + "/visits/clinic-doctor/" + clinicDocId,
    headers: {"Authorization": token},
  );

  if (response.statusCode == 200) {
    print(response.body);

    PatientVisitSync pvs =
        PatientVisitSync.fromJson(json.decode(response.body));
    print(pvs.toJson());

    for (var i in pvs.data) {
      var pvi = PatientsVisitData(
          mobileNo: int.parse(i.patient.mobileNo),
          patientName: i.patientName,
          temperature: i.temperature.toString(),
          bp: i.bloodPressure,
          pulse: i.pulse.toString(),
          weight: i.weight.toString(),
          fee: i.fee,
          patientId: i.patientId,
          appointmentType: i.appointmentType,
          appointmentsTime: DateTime.parse(i.appointmentTime),
          bookingType: i.bookingType,
          bookedVia: i.bookedBy,
          visitType: i.visitType,
          age: i.patient.age,
          presentTime: i.presentTime,
          bookedBy: i.bookedBy,
          isDoctorFeedBack: i.isDoctorFeedback,
          isPatientFeedBack: i.isPatientFeedback,
          clinicDoctorId: i.clinicDoctorId,
          briefHistory: BriefHistorygenerated(data: i.briefHistory),
          diagnosis: Dignosisgenerated(data: i.diagnosis),
          examination: Examinationgenerated(data: i.examination),
          visitReason: VisitReasongenerated(data: i.visitReason),
          medication: Medicationgenerated(data: i.medication),
          isOnline: true);
      pvDB.insert(pvi);
    }
  }
}

fetchPatients(String clinicDocId, PatientsDB patientsDB) async {
  String token = await getToken();
  var response = await http.get(
    BASEURL + "/patients/doctor",
    headers: {"Authorization": token},
  );
  print(clinicDocId);
  if (response.statusCode == 200) {
    print(response.body);
    PatientDataSync patientSync =
        PatientDataSync.fromJson(json.decode(response.body));
    print(patientSync.toJson());
    for (var i in patientSync.data) {
      var x = Patient(
          mobileNo: int.parse(i.mobileNo),
          name: i.name,
          gender: i.gender == "male" ? Gender.Male : Gender.Female,
          patientId: i.patientId,
          clinicDoctorId: int.parse(clinicDocId),
          address: i.address,
          age: i.age,
          isOnline: true);
      patientsDB.insert(x);
    }
  }
}

fetchParameters(String id) async {
  String token = await getToken();
  SharedPreferences pref = await SharedPreferences.getInstance();

  var response = await http.get(
    PARAMETERS + id,
    headers: {"Authorization": token},
  );
  print(response.body);
  if (response.statusCode == 200) {
    ParametersUpdate parametersUpdate =
        ParametersUpdate.fromJson(json.decode(response.body));
    for (var i = 0; i < parametersUpdate.data.category.length; i++) {
      parametersUpdate.data.category[i].isOnline = true;
    }
    for (var i = 0; i < parametersUpdate.data.direction.length; i++) {
      parametersUpdate.data.direction[i].isOnline = true;
    }
    for (var i = 0; i < parametersUpdate.data.duration.length; i++) {
      parametersUpdate.data.duration[i].isOnline = true;
    }
    for (var i = 0; i < parametersUpdate.data.dose.length; i++) {
      parametersUpdate.data.dose[i].isOnline = true;
    }
    for (var i = 0; i < parametersUpdate.data.unit.length; i++) {
      parametersUpdate.data.unit[i].isOnline = true;
    }
    for (var i = 0; i < parametersUpdate.data.frequency.length; i++) {
      parametersUpdate.data.frequency[i].isOnline = true;
    }
    for (var i = 0; i < parametersUpdate.data.route.length; i++) {
      parametersUpdate.data.route[i].isOnline = true;
    }
    pref.setString("parameters", json.encode(parametersUpdate));
    print(pref.getString("parameters"));
  }
}

syncParameters(String id) async {
  String token = await getToken();
  SharedPreferences pref = await SharedPreferences.getInstance();
  String parameters = pref.getString('parameters');
  ParametersUpdate parametersUpdate =
      ParametersUpdate.fromJson(json.decode(parameters));
  ParameterSync parameterSync = new ParameterSync(params: []);
  print(parameters);
  for (var i in parametersUpdate.data.category) {
    print(i.isOnline);
    if (!i.isOnline) {
      parameterSync.params
          .add(Params(name: i.title, type: i.type, value: i.value));
    }
  }
  for (var i in parametersUpdate.data.direction) {
    if (!i.isOnline) {
      parameterSync.params
          .add(Params(name: i.title, type: i.type, value: i.value));
    }
  }
  for (var i in parametersUpdate.data.dose) {
    if (!i.isOnline) {
      parameterSync.params
          .add(Params(name: i.title, type: i.type, value: i.value));
    }
  }
  for (var i in parametersUpdate.data.duration) {
    if (!i.isOnline) {
      parameterSync.params
          .add(Params(name: i.title, type: i.type, value: i.value));
    }
  }
  for (var i in parametersUpdate.data.frequency) {
    if (!i.isOnline) {
      parameterSync.params
          .add(Params(name: i.title, type: i.type, value: i.value));
    }
  }
  for (var i in parametersUpdate.data.route) {
    if (!i.isOnline) {
      parameterSync.params
          .add(Params(name: i.title, type: i.type, value: i.value));
    }
  }
  for (var i in parametersUpdate.data.unit) {
    if (!i.isOnline) {
      parameterSync.params
          .add(Params(name: i.title, type: i.type, value: i.value));
    }
  }
  print(token);
// String ansSend =
  var response = await http.post(PARAMETERS + id + "/bulk",
      headers: {"Authorization": token},
      body: {"params": json.encode(parameterSync.params)});
  print(response.body);
  print(json.encode(parameterSync));
  if (response.statusCode == 200) {
    print("Parameter Sync Success line 671 page datasyncfunction");
    for (var i = 0; i < parametersUpdate.data.category.length; i++) {
      parametersUpdate.data.category[i].isOnline = true;
    }
    for (var i = 0; i < parametersUpdate.data.direction.length; i++) {
      parametersUpdate.data.direction[i].isOnline = true;
    }
    for (var i = 0; i < parametersUpdate.data.duration.length; i++) {
      parametersUpdate.data.duration[i].isOnline = true;
    }
    for (var i = 0; i < parametersUpdate.data.dose.length; i++) {
      parametersUpdate.data.dose[i].isOnline = true;
    }
    for (var i = 0; i < parametersUpdate.data.unit.length; i++) {
      parametersUpdate.data.unit[i].isOnline = true;
    }
    for (var i = 0; i < parametersUpdate.data.frequency.length; i++) {
      parametersUpdate.data.frequency[i].isOnline = true;
    }
    for (var i = 0; i < parametersUpdate.data.route.length; i++) {
      parametersUpdate.data.route[i].isOnline = true;
    }
    pref.setString("parameters", json.encode(parametersUpdate));
    print(pref.getString("parameters"));
  } else {
    print("Parameter Sync failed line 673 page datasyncfunction");
  }
}
