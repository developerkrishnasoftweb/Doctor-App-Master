import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:getcure_doctor/Database/AdviceTable.dart';
import 'package:getcure_doctor/Database/TokenTable.dart';
import 'package:getcure_doctor/Models/Appointments/BriefHistoryMode.dart';
import 'package:getcure_doctor/Models/Appointments/DoctorAppointmentHistoryModel.dart';
import 'package:getcure_doctor/Models/Appointments/DoctorInvoiceModel.dart';
import 'package:getcure_doctor/Models/ClinicsByState.dart';
import 'package:getcure_doctor/Models/DiseaseAnalysisModel.dart';
import 'package:getcure_doctor/Models/DoctorLogin.dart';
import 'package:getcure_doctor/Models/FeedbackAnalysis.dart';
import 'package:getcure_doctor/Models/ImageDataModel.dart';
import 'package:getcure_doctor/Models/MYProfileModel.dart';
import 'package:getcure_doctor/Models/MedicineAnalysisModel.dart';
import 'package:getcure_doctor/Models/SendHolidayUpdateModel.dart';
import 'package:getcure_doctor/Models/SpecialitySearchSuggestion.dart' as ts;
import 'package:getcure_doctor/Models/StateSearchSuggestion.dart';
import 'package:getcure_doctor/Models/SyncModels/CancelledTokens.dart';
import 'package:getcure_doctor/Models/TimingAddModel.dart';
import 'package:getcure_doctor/Models/TokenMode.dart';
import 'package:getcure_doctor/Models/pdf_config_model.dart';
import 'package:getcure_doctor/Widgets/DoctorHoliday.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Apis.dart';
import 'package:intl/intl.dart';
import 'package:getcure_doctor/Database/PatientsTable.dart' as pot;
import 'package:getcure_doctor/Database/PatientsVisitTable.dart';

Future<bool> updatedetails(id, name, age, gender, degree, mob, email, lang,
    experience, designation) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  String tk = pref.getString('docToken');
  var response = await http.put(DOCTORENJOYDAYE, headers: {
    HttpHeaders.authorizationHeader: tk
  }, body: {
    "name": name,
    "age": age,
    "gender": gender,
    "degree": degree,
    "mobile_no": mob,
    "email": email,
    "language": lang,
    "experience": experience,
    "designation": designation
  });
  if (response.statusCode == 200) {
    GetMyProfile getMyProfile =
        GetMyProfile.fromJson(json.decode(response.body));
    SharedPreferences pref = await SharedPreferences.getInstance();
    //print(getMyProfile.toJson());
    pref.setString('docDataResponse', json.encode(getMyProfile.data));
    String docResponse = pref.getString('docDataResponse');
    DoctorLoginData doctor = DoctorLoginData.fromJson(json.decode(docResponse));
    pref.reload();
    return true;
  } else {
    return false;
  }
}

Future<bool> updateFees(String clinicDoctorId, opdFees, emergencyFees) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  String tk = pref.getString('docToken');
  var response = await http.put(FEESUPDATE + clinicDoctorId, headers: {
    HttpHeaders.authorizationHeader: tk
  }, body: {
    "consultation_fee": opdFees,
    "emergency_fee": emergencyFees,
  });
  if (response.statusCode == 200) {
    var res = await http.get(GETDOCTOR, headers: {"Authorization": tk});
    GetMyProfile getMyProfile = GetMyProfile.fromJson(json.decode(res.body));
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('docDataResponse', json.encode(getMyProfile.data));
    String docResponse = pref.getString('docDataResponse');
    DoctorLoginData doctor = DoctorLoginData.fromJson(json.decode(docResponse));
    pref.reload();
    return true;
  } else {
    return false;
  }
}

Future<bool> loginDoctor(mobNo, pass) async {
  try {
    var response = await http
        .post(LOGINDOCTOR, body: {"emailOrPhone": mobNo, "password": pass});
    if (response.statusCode == 200) {
      DoctorLogin doctor = DoctorLogin.fromJson(json.decode(response.body));
      SharedPreferences pref = await SharedPreferences.getInstance();
      // print(doctor.token.toString());
      pref.setString('docToken', doctor.token);
      pref.setString('dresponse', json.encode(doctor));
      pref.setString('docDataResponse', json.encode(doctor.data));
      pref.setString('category', json.encode(doctor.data.clinicDoctor));
      pref.setString('docId', doctor.data.id.toString());
      return true;
    }
    return false;
  } catch (_) {
    throw (_);
  }
}

Future<List<StateData>> getStateinfo() async {
  var response = await http.get(GETSTATES);
  if (response.statusCode == 200) {
    StateSearch stateSearch = StateSearch.fromJson(json.decode(response.body));
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('stateModel', json.encode(stateSearch));
    return stateSearch.data;
  } else {
    return null;
  }
}

Future<PdfConfig> getPdfConfig() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  try {
    String docId = pref.getString('docId');
    if (docId != null) {
      var response = await http.get(GET_PDF_CONFIG + docId);
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        PdfConfig pdfConfig;
        if (jsonResponse['data'] != null) {
          if (jsonResponse['data'][0] != null) {
            pdfConfig = PdfConfig.fromJson(jsonResponse['data'][0]);
            pref.setString('pdfConfig', json.encode(jsonResponse['data'][0]));
          }
        }
        return pdfConfig;
      } else {
        return null;
      }
    } else {
      return null;
    }
  } catch (e) {
    throw ('Error in config $e');
    var configData = pref.getString('pdfConfig');
    if (configData != null) {
      return PdfConfig.fromJson(jsonDecode(configData));
    } else {
      return null;
    }
  }
}

Future<List<StateData>> activeStates() async {
  var response = await http.get(ACTIVESTATES);
  if (response.statusCode == 200) {
    StateSearch stateSearch = StateSearch.fromJson(json.decode(response.body));
    // SharedPreferences pref = await SharedPreferences.getInstance();
    // pref.setString('stateModel', json.encode(stateSearch));
    return stateSearch.data;
  } else {
    return null;
  }
}

Future<List<ClinicsByStateData>> clinicsByState(String id) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('signtoken');
  var response = await http.get(
    CLINICSBYSTATES + id,
    headers: {"Authorization": token},
  );
  if (response.statusCode == 200) {
    ClinicsByState stateSearch =
        ClinicsByState.fromJson(json.decode(response.body));
    // SharedPreferences pref = await SharedPreferences.getInstance();
    // pref.setString('stateModel', json.encode(stateSearch));
    return stateSearch.data;
  } else {
    return [];
  }
}

Future<bool> addClinicByCode(String gcc) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('signtoken');
  var response = await http.post(ADDCLINICBYCODE,
      headers: {"Authorization": token}, body: {"clinic_code": gcc});
  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

Future<List<ts.SpecialityData>> getSpeciality() async {
  var response = await http.get(GETSPECIAL);

  if (response.statusCode == 200) {
    ts.SpecialitySearch specialitySearch =
        ts.SpecialitySearch.fromJson(json.decode(response.body));
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('specialitymodel', json.encode(specialitySearch));
    return specialitySearch.data;
  } else {
    return null;
  }
}

// Future<String> clinicDoctors() async {
//   SharedPreferences pref = await SharedPreferences.getInstance();
//   String token = pref.getString('docToken');
//   var response =
//       await http.get(MYCLINICS + '/1', headers: {'Authorization': token});
//   print("Clinic doctor = " + response.statusCode.toString());
//   if (response.statusCode == 200) {
//     ClinicDoctorModel docmodel =
//         ClinicDoctorModel.fromJson(json.decode(response.body));
//     pref.setString('clinicresponse', json.encode(docmodel));
//     return response.body;
//   }
// }

Future<List<String>> getBriefHistories() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  String token = pref.getString('docToken');
  var response =
      await http.get(BRIEFHISTORY, headers: {"Authorization": token});

  BriefHistoryModel brief =
      BriefHistoryModel.fromJson(jsonDecode(response.body));
  List<String> data = [];
  for (var x in brief.data) {
    data.add(x.title);
  }
  // if (data.length > 0) {
  return data;
  // }
}

void getAdvices(BuildContext context) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  final adviceProvider = Provider.of<AdvicesDatabase>(context, listen: false);
  String token = pref.getString('docToken');
  String docId = pref.getString('docId');
  if (token != null && docId != null) {
    var response = await http.get(GET_ADVICES + '/$docId');
    final jsonResponse = jsonDecode(response.body);
    if (jsonResponse['data'] != null) {
      jsonResponse['data'].forEach((advice) async {
        String symptoms = '';
        advice['symptoms'].forEach((v) async {
          symptoms += "$v, ";
        });
        symptoms = symptoms.substring(0, symptoms.length - 2);
        await adviceProvider.truncate();
        await adviceProvider
            .insertAdvice(Advice(advice: advice['title'], symptoms: symptoms));
      });
    }
  }
}

Future addAdvices(String title, String symptoms) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  String token = pref.getString('signtoken');
  String docId = pref.getString('docId');
  if (token != null && docId != null) {
    var response = await http.post(GET_ADVICES,
        headers: {"Authorization": token, "Content-Type": "application/json"},
        body: jsonEncode({
          "title": title,
          "symptoms": symptoms.split(", "),
          "doctor_id": docId
        }));

    return true;
    // final jsonResponse = jsonDecode(response.body);
    // if (jsonResponse['data'] != null) {
    //   jsonResponse['data'].forEach((advice) async {
    //     String symptoms = '';
    //     advice['symptoms'].forEach((v) async {
    //       symptoms += "$v, ";
    //     });
    //     symptoms = symptoms.substring(0, symptoms.length - 2);
    //   });
    // }
  }
}

// Future<List<String>> getVisitReason() async {
// SharedPreferences pref = await SharedPreferences.getInstance();
// String token = pref.getString('docToken');
// var response =
//     await http.get(BRIEFHISTORY, headers: {"Authorization": token});
//     print("hello");
//
// BriefHistoryModel brief =
//     BriefHistoryModel.fromJson(jsonDecode(response.body));
// List<String> data = [];
// for (var x in brief.data) {
//   data.add(x.title);
// }
// print(data);
// // if (data.length > 0) {
//   return data;
// // }
// }
Future<String> generateOtp(mobno) async {
  var response = await http.post(OTP, body: {"mobile_no": mobno});


  if (response.statusCode == 200) {
    return response.body;
  }
  return null;
}

getToken() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  String token = pref.getString('docToken');
  return token;
}

Future<bool> signupDoctor(mobno, otp, password) async {
  var response = await http.post(SIGNUP,
      body: {"mobile_no": mobno, "password": password, "otp": otp});

  if (response.statusCode == 200) {
    DoctorLogin doctor = DoctorLogin.fromJson(json.decode(response.body));
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('signtoken', doctor.token);
    pref.setString('signdresponse', json.encode(doctor));
    return true;
  } else {
    return false;
  }
}

Future<bool> updateDoctor(
    name, email, city, speciality, gender, education, yearexp) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String t = json.encode(speciality);
  String token = prefs.getString('signtoken');
  var response = await http.put(UPDATEDOCTOR, headers: {
    "Authorization": token
  }, body: {
    "name": name,
    "email": email,
    "gender": gender.toLowerCase(),
    "experience": yearexp,
    "specialities": json.encode(speciality)
  });

  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

// Future<bool> login(url, mobno, password) async {
//   var response =
//       await http.post(url, body: {"emailOrPhone": mobno, "password": password});
//
//   if (response.statusCode == 200) {
//     DoctorUser doctor = DoctorUser.fromJson(json.decode(response.body));
//     SharedPreferences pref = await SharedPreferences.getInstance();
//     pref.setString('dtoken', doctor.token);
//     pref.setString('dresponse', json.encode(doctor));
//     return true;
//   } else {
//     return false;
//   }
// }

// Future<String> loginError(url, mobno, password) async {
//   var response =
//       await http.post(url, body: {"emailOrPhone": mobno, "password": password});
//
//   if (response.statusCode == 200) {
//     if (url == LOGINDOCTOR) {
//       DoctorUser doctor = DoctorUser.fromJson(json.decode(response.body));
//       SharedPreferences pref = await SharedPreferences.getInstance();
//       pref.setString('token', doctor.token);
//       pref.setString('dresponse', json.encode(doctor));
//     } else {
//       FrontDeskUser frontDeskUser =
//           FrontDeskUser.fromJson(json.decode(response.body));
//       SharedPreferences pref = await SharedPreferences.getInstance();
//       pref.setString('token', frontDeskUser.token);
//       pref.setString('fresponse', json.encode(frontDeskUser));
//     }
//     return response.body;
//   }
// }

Future<bool> addClinic(clinicName, type, eoy, nob, nod, cityId, cityName,
    pincode, spec, address, timings, phoneNo) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('signtoken');
  var response = await http.post(
    ADDCLINIC,
    headers: {"Authorization": token},
    body: {
      "name": clinicName.toString(),
      "state_id": cityId.toString(),
      "state": cityName.toString(),
      "address": address.toString(),
      "type": type.toString(),
      "established_year": eoy.toString(),
      "no_of_beds": nob.toString(),
      "no_of_doctors": nod.toString(),
      "pin_code": pincode.toString(),
      "phone_no": phoneNo.toString(),
      "timings": timings.toString(),
      "specialities": json.encode(spec),
    },
  );


  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

Future<String> bookToken(name, age, mobileno, address, vtype, atype, tno, ttime,
    tdate, btype, docid, gender, fee) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token');
  var response = await http.post(TOKENSBOOKING, headers: {
    "Authorization": token
  }, body: {
    "patient[name]": name,
    "patient[age]": age.toString(),
    "patient[gender]": gender,
    "patient[address]": address,
    "patient[mobile_no]": mobileno.toString(),
    "fees": fee,
    "visit_type": vtype,
    "booking_type": btype,
    "appointment_type": atype,
    "date": DateFormat('yyyy-MM-dd').format(tdate).toString(),
    "time": DateFormat.Hms().format(tdate).toString(),
    "token_no": tno.toString(),
    "clinic_doctor_id": docid.toString(),
    "is_present": 'true'
  });

  if (response.statusCode == 200) {
    return json.decode(response.body)["data"]["patient_id"];
  } else {
    return 'NIL';
  }
}

Future<bool> fetchCancelledTokens(
    String id, DateTime date, TokenDB db, int clinicid) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('docToken');
  var response = await http.get(
    CANCELTOKENFETCH +
        id +
        "?date=${DateFormat('yyyy-MM-dd').format(date).toString()}",
    headers: {"Authorization": token},
  );

  if (response.statusCode == 200) {
    CancelledTokens cancelledTokens =
        CancelledTokens.fromJson(json.decode(response.body));
    for (var i in cancelledTokens.data) {
      var tok = await db.getAll(i.patientId,
          DateTime.parse(i.date + " " + i.time), DateTime.parse(i.bookedAt));
      if (tok.length != 0) {
        var token = tok.last;
        db.updateData(
            token.copyWith(
              booked: false,
            ),
            i.patientName);

        db.insertTask(Token(
            clinicid: clinicid,
            name: token.name,
            guid: token.guid,
            tokenno: token.tokenno,
            doctorid: token.doctorid,
            fees: token.fees,
            mobileno: token.mobileno,
            address: token.address,
            age: token.age,
            tokentime: token.tokentime,
            appointmenttype: token.appointmenttype,
            visittype: token.visittype,
            bookedtype: token.bookedtype,
            booked: false,
            cancelled: true,
            isOnline: true));
      } else {
        var cancelled = await db.getCancelledTokens(
            DateTime.parse(i.date + " " + i.time), i.patientId);
        if (cancelled.length == 0) {
          var tokn = await db.getToken(
              DateTime.parse(i.date + " " + i.time), clinicid);
          db.insertTask(Token(
            clinicid: clinicid,
            name: i.patientName,
            guid: i.patientId,
            tokenno: tokn.first.tokenno,
            doctorid: int.parse(id),
            fees: i.fees,
            tokentime: DateTime.parse(i.date + " " + i.time),
            appointmenttype: i.appointmentType,
            visittype: i.visitType,
            bookedtype: i.bookingType,
            booked: false,
            isOnline: true,
            cancelled: true,
          ));
        }
      }
    }
    return true;
  } else {
    return false;
  }
}

Future<void> getTokens(date, TokenDB db, String clinicDocid,
    pot.PatientsDB patientDatabse, BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final patient = Provider.of<PatientsVisitDB>(context, listen: false);
  String token = prefs.getString('docToken');
  // print(DateFormat('yyyy-MM-dd').format(date).toString());
  var response = await http.get(
    GETTOKENSBYDATE +
        clinicDocid +
        "?${DateFormat('yyyy-MM-dd').format(date).toString()}",
    headers: {"Authorization": token},
  );

  if (response.statusCode == 200) {
    TokenModel tokens = TokenModel.fromJson(json.decode(response.body));
    for (final i in tokens.data) {
      if (i.bookingType != "cancelled") {
        final token = Token(
            doctorid: i.clinicDoctorId,
            clinicid: i.clinicDoctorId,
            appointmentId: i.appointmentId,
            booked: true,
            name: i.patientName,
            tokentime: DateTime.parse(
                DateFormat("yyyy-MM-dd").format(DateTime.parse(i.date)) +
                    " " +
                    i.time),
            isPresent: i.isPresent,
            bookedBy: i.bookedBy,
            bookedAt: DateTime.parse(i.bookedAt),
            isOnline: true,
            bookedVia: i.bookedVia,
            presentTime: i.presentTime,
            gender: i.patient.gender,
            tokenno: i.tokenNo,
            address: i.patient.address,
            age: i.patient.age,
            fees: i.fees == null ? 100 : i.fees,
            appointmenttype: i.appointmentType,
            bookedtype: i.bookingType,
            updatedAt: DateTime.now(),
            mobileno: int.parse(i.patient.mobileNo),
            visittype: i.visitType,
            guid: i.patientId,
            cancelled: false);
        db.updateOnline(token);

        var pat = pot.Patient(
            mobileNo: int.parse(i.patient.mobileNo),
            name: i.patient.name,
            isOnline: true,
            gender: i.patient.gender == 'male'
                ? pot.Gender.Male
                : pot.Gender.Female,
            age: i.patient.age,
            address: i.patient.address);
        var responsePatient = patientDatabse.createPatient2(pat);

        List<PatientsVisitData> result =
            await patient.checkPatient(i.patientId);

        if (result.isEmpty) {
          final p = PatientsVisitData(
              fee: i.fees,
              appointmentId: i.appointmentId,
              bookedBy: i.bookedBy,
              bookedVia: i.bookedVia,
              isOnline: true,
              presentTime: i.presentTime,
              mobileNo: int.parse(i.patient.mobileNo),
              patientName: i.patient.name,
              patientId: i.patientId,
              age: i.patient.age,
              appointmentType: i.appointmentType,
              bookingType: i.bookingType,
              visitType: i.visitType,
              appointmentsTime: DateTime.parse(i.date + " " + i.time),
              clinicDoctorId: i.clinicDoctorId);
          patient.insert(p);
        } else {

          PatientsVisitData r = result.last;
          final p = PatientsVisitData(
            fee: i.fees,
            appointmentId: i.appointmentId,
            bookedBy: i.bookedBy,
            bookedVia: i.bookedVia,
            isOnline: true,
            presentTime: i.presentTime,
            mobileNo: r.mobileNo,
            patientName: r.patientName,
            temperature: r.temperature,
            pulse: r.pulse,
            patientId: r.patientId,
            visitReason: r.visitReason,
            age: r.age,
            briefHistory: r.briefHistory,
            allergies: r.allergies,
            clinicDoctorId: r.clinicDoctorId,
            diagnosis: r.diagnosis,
            examination: r.examination,
            lifestyle: r.lifestyle,
            medication: r.medication,
            feedBack: r.medication,
            weight: r.weight,
            appointmentType: i.appointmentType,
            bookingType: i.bookingType,
            visitType: i.visitType,
            appointmentsTime: DateTime.parse(i.date + " " + i.time),
          );
          patient.insert(p);
          // print(tokenno);
        }
      }
    }
  }
}

getDiseaseAnalysis(int docId, DateTime st, DateTime et) async {
  String token = await getToken();
  var response = await http.get(
    DISANALYSIS + docId.toString(),
    headers: {"Authorization": token},
  );

  DiseaseAnalysisModel dis =
      DiseaseAnalysisModel.fromJson(json.decode(response.body));
  return dis;
}

getMedicineAnalysis(int docId, DateTime st, DateTime et) async {
  String token = await getToken();
  var response = await http.get(
    MEDANALYSIS + docId.toString(),
    headers: {"Authorization": token},
  );

  MedicineAnalysisModel dis =
      MedicineAnalysisModel.fromJson(json.decode(response.body));
  return dis;
}

getFeedBackAnalysis(int docId, DateTime st, DateTime et) async {
  String token = await getToken();
  var response = await http.get(
    PATIENTFEEDBACK + docId.toString(),
    headers: {"Authorization": token},
  );

  FeedbackAnalysis dis = FeedbackAnalysis.fromJson(json.decode(response.body));
  return dis;
}

Future doctorTimings(SendTime st, clinicdocId) async {
  var body = st.toJson();
  SharedPreferences pref = await SharedPreferences.getInstance();
  String token = pref.getString('docToken');
  var response =
      await http.put(DOCTORTIMING + clinicdocId.toString(), headers: {
    "Authorization": token
  }, body: {
    "doctor_timings": json.encode(body),
  });


  if (response.statusCode == 200) {
    var res = await http.get(GETDOCTOR, headers: {"Authorization": token});
    if (res.statusCode == 200) {
      GetMyProfile getMyProfile = GetMyProfile.fromJson(json.decode(res.body));
      pref.setString('docDataResponse', json.encode(getMyProfile.data));
      return true;
    }
  } else {
    return false;
  }
}

Future<bool> sendHolidays(DocHoli ans, docId) async {
  var body = ans.toJson();
  String sendHO = json.encode(body['holidays']);
  SharedPreferences pref = await SharedPreferences.getInstance();
  String token = pref.getString('docToken');
  var response = await http.put(DOCTORENJOYDAYE,
      headers: {"Authorization": token}, body: {"holidays": sendHO});


  if (response.statusCode == 200) {
    SenHolidayUpdateModel docData =
        SenHolidayUpdateModel.fromJson(json.decode(response.body));
    pref.setString('docDataResponse', json.encode(docData.data));
    pref.reload();
    return true;
  } else {
    return false;
  }
}

Future<DoctorAppointmentHistoryModel> appointmenthistoryfetch(
    String sd, String ed, int docid, query) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  String token = pref.getString("docToken");
  var response;
  if (sd == ed) {
    response = await http.get(
        DOCTORAPPOINTMENTHISTORY +
            docid.toString() +
            '?start_date=' +
            '&end_date=' +
            "&query=" +
            query,
        headers: {"Authorization": token});
  } else {
    response = await http.get(
        DOCTORAPPOINTMENTHISTORY +
            docid.toString() +
            '?start_date=' +
            sd +
            '&end_date=' +
            ed +
            "&query=" +
            query,
        headers: {"Authorization": token});
  }

  if (response.statusCode == 200) {
    DoctorAppointmentHistoryModel def =
        DoctorAppointmentHistoryModel.fromJson(json.decode(response.body));
    return def;
  } else {
    return null;
  }
}

Future<DoctorInvoiceModel> getDocVoice(clinicDocId, startDate, endDate) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  String token = pref.getString("docToken");
  var response = await http.get(
      DOCTORINVOICEAPI +
          clinicDocId.toString() +
          "/doctor" +
          "?start_date=" +
          startDate +
          "&end_date=" +
          endDate,
      headers: {"Authorization": token});

  if (response.statusCode == 200) {
    DoctorInvoiceModel doc =
        DoctorInvoiceModel.fromJson(json.decode(response.body));
    return doc;
  } else {
    throw Exception('Failed to Load Data');
  }
}

Future<DoctorLoginData> docinfo() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.reload();
  String resp = pref.getString("docDataResponse");
  DoctorLoginData user = DoctorLoginData.fromJson(json.decode(resp));
  return user;
}

Future<MyDoctorProfile> getMyProfileDat() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  String token = pref.getString("docToken");
  var response =
      await http.get(DOCTORENJOYDAYE, headers: {"Authorization": token});
  if (response.statusCode == 200) {
    MyDoctorProfile profile =
        MyDoctorProfile.fromJson(json.decode(response.body));
    return profile;
  } else {
    throw Exception("Some Error");
  }
}

Future<bool> sendImagesUrl(SendImageDataModel send) async {
  String ans = json.encode(send.toJson()['identity_verification_url']);
  SharedPreferences pref = await SharedPreferences.getInstance();
  String token = pref.getString("signtoken");
  var response = await http.put(DOCTORENJOYDAYE,
      headers: {"Authorization": token},
      body: {"identity_verification_url": ans});




  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}
