import 'dart:io';
import 'package:getcure_doctor/Database/AdviceTable.dart';
import 'package:getcure_doctor/Database/ExaminationTable.dart';
import 'package:getcure_doctor/Database/MedicinesTable.dart';
import 'package:getcure_doctor/Database/Recommendation.dart';
import 'package:getcure_doctor/Models/PatientsVisitTableModels.dart';
import 'package:getcure_doctor/Screens/Treatment/Medication.dart';
import 'package:moor/moor.dart';
import 'package:moor_ffi/moor_ffi.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'PatientsVisitTable.g.dart';

class PatientsVisit extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get appointmentId => text().nullable()();

  IntColumn get mobileNo => integer()();

  IntColumn get age => integer().nullable()();

  TextColumn get patientName => text()();

  TextColumn get temperature => text().withDefault(Constant('98'))();

  TextColumn get bp => text().withDefault(Constant('80/120'))();

  TextColumn get pulse => text().withDefault(Constant('72'))();

  TextColumn get weight => text().withDefault(Constant('0'))();

  IntColumn get fee => integer().withDefault(Constant(100))();

  TextColumn get patientId => text()();

  IntColumn get clinicDoctorId => integer().nullable()();

  TextColumn get appointmentType => text().nullable()();

  TextColumn get visitType => text().nullable()();

  TextColumn get bookingType => text().nullable()();

  TextColumn get bookedBy => text().nullable()();

  TextColumn get bookedVia => text().nullable()();

  DateTimeColumn get appointmentsTime => dateTime().nullable()();

  DateTimeColumn get presentTime => dateTime().nullable()();

  BoolColumn get completed => boolean().withDefault(Constant(false))();

  BoolColumn get isDoctorFeedBack => boolean().withDefault(Constant(false))();

  BoolColumn get isPatientFeedBack => boolean().withDefault(Constant(false))();

  TextColumn get briefHistory =>
      text().map(const BriefHistoryConverter()).nullable()();

  TextColumn get visitReason =>
      text().map(const VisitReasonConverter()).nullable()();

  TextColumn get examination =>
      text().map(const ExaminationConverter()).nullable()();

  TextColumn get diagnosis =>
      text().map(const DignosisConverter()).nullable()();

  TextColumn get medication =>
      text().map(const MedicationConverter()).nullable()();

  TextColumn get feedBack =>
      text().map(const MedicationConverter()).nullable()();

  TextColumn get allergies => text().map(const AllergyConverter()).nullable()();

  TextColumn get lifestyle =>
      text().map(const LifeStyleConverter()).nullable()();

  TextColumn get advices => text().map(const AdviceConverter()).nullable()();

  BoolColumn get isOnline => boolean().withDefault(Constant(false))();
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'getPatientVisit.sqlite'));
    return VmDatabase(file, logStatements: true);
  });
}

@UseMoor(tables: [PatientsVisit])
class PatientsVisitDB extends _$PatientsVisitDB {
  PatientsVisitDB() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  Future insert(PatientsVisitData p) => into(patientsVisit).insert(p);

  Future<List<PatientsVisitData>> getAll() {
    var query = select(patientsVisit)
      ..where((tbl) => tbl.isOnline.equals(false));
    return query.get();
  }

  Future<List<PatientsVisitData>> checkPatient(String patientId) {
    try {
      var query = select(patientsVisit)
        ..where((pat) => pat.patientId.equals(patientId));
      // ..limit(1);
      return query.get();
    } catch (e) {
      print("Error" + e);
      return null;
    }
  }

  //Updating Data
  Future updateBriefHistory(PatientsVisitData data, BriefHistorygenerated bh) {
    var query = update(patientsVisit)..where((t) => t.id.equals(data.id));
    List<BriefHistoryData> list = [];
    // List<DignosisData> listd = [];
    // if (data.diagnosis != null) {
    //   listd = data.diagnosis.data;
    // }
    // var resd = listd.where((element) => element.title == bh.data[0].title);
    if (data.briefHistory != null) {
      list = data.briefHistory.data;
    }
    var res = list.where((element) => element.title == bh.data[0].title);
    // if (res.length == 0) {
    //   list.add(bh.data[0]);
    //   bh.data = list;
    // } else {
    //   bh.data = list;
    // }
    if (res.length == 0) {
      list.add(bh.data[0]);
      bh.data = list;
    } else {
      bh.data = list;
    }
    return query.write(PatientsVisitCompanion(briefHistory: Value(bh)));
  }

  Future updateDiagnosis(PatientsVisitData data, Dignosisgenerated bh,
      RecommendationDB rec, MedicinesDB md) async {
    var query = update(patientsVisit)..where((t) => t.id.equals(data.id));
    List<DignosisData> list = [];
    // list = data.briefHistory.data;
    if (data.diagnosis != null) {
      list = data.diagnosis.data;
    }
    var res = list.where((element) => element.title == bh.data[0].title);
    if (res.length == 0) {
      list.add(bh.data[0]);
      bh.data = list;
    } else {
      bh.data = list;
    }
    for (var j in bh.data) {
      List<RecommendationData> listRecom = await rec.recommend(j.title);

      if (listRecom.length != 0) {
        print(j.title);
        for (var i in listRecom[0].medicines.medicines) {
          List<Medicine> listMd = await md.getMed(i);
          PrescribedMedicines pm = PrescribedMedicines(
              title: i,
              direction: listMd.first.defaultDirection,
              dose: listMd.first.defaultDose,
              duration: listMd.first.defaultDuration,
              frequency: listMd.first.defaultFrequency,
              medicineId: listMd.first.id,
              route: listMd.first.defaultRoute,
              unit: listMd.first.defaultUnit);
          updateMedication(data, j.title, pm);
        }
      }
    }

    return query.write(PatientsVisitCompanion(diagnosis: Value(bh)));
  }

  Future updateExamination(PatientsVisitData data, Examinationgenerated ex) {
    var query = update(patientsVisit)..where((t) => t.id.equals(data.id));
    List<ExaminationData> list = [];
    if (data.examination != null) {
      list = data.examination.data;
    }
    var res = list.where((element) => element.title == ex.data.last.title);

    if (res.length == 0) {
      list.add(ex.data.last);
      ex.data = list;
    } else {
      ex.data = list;
    }
    return query.write(PatientsVisitCompanion(examination: Value(ex)));
  }

  Future updateMedication(
      PatientsVisitData data, String disease, PrescribedMedicines pm) {
    var query = update(patientsVisit)..where((t) => t.id.equals(data.id));
    List<MedicationData> list = [];
    if (data.medication != null) {
      list = data.medication.data;
    }
    var r = list.where((element) => element.disease == disease);
    if (r.length == 0) {
      list.add(
          new MedicationData(disease: disease, symptomId: 0, medicines: [pm]));
    } else {
      var tr = r.elementAt(0);
      var res = tr.medicines.where((element) => element.title == pm.title);
      if (res.length == 0) {
        tr.medicines.add(pm);
        list.removeWhere((element) => element.disease == disease);
        list.add(tr);
      } else {
        // ex.data = list;
      }
    }
    return query.write(PatientsVisitCompanion(
        medication: Value(Medicationgenerated(data: list))));
  }

  Future insertAdvice(List<AdviceData> advices, PatientsVisitData data) {
    var query = update(patientsVisit)..where((tbl) => tbl.id.equals(data.id));
    return query.write(PatientsVisitCompanion(advices: Value(AdvicesGenerated(advices: advices))));
  }

  //Fetch Data
  Future<List<PatientsVisitData>> getBriefHistoryFuture(String id) {
    dynamic query;
    query = select(patientsVisit)..where((tbl) => tbl.patientId.equals(id));
    return query.get();
  }

  //Fetch Data
  Stream<List<PatientsVisitData>> getBriefHistory(String id) {
    dynamic query;
    query = select(patientsVisit)..where((tbl) => tbl.patientId.equals(id));
    return query.watch();
  }

  Future<List<PatientsVisitData>> getDiagnosis(String id) {
    dynamic query;
    query = select(patientsVisit)..where((tbl) => tbl.patientId.equals(id));
    return query.get();
  }

  //delete briefhistory
  Future deleteBrief(PatientsVisitData pvd, String title) {
    var query = update(patientsVisit)..where((t) => t.id.equals(pvd.id));
    pvd.briefHistory.data.removeWhere((element) => element.title == title);

    return query
        .write(PatientsVisitCompanion(briefHistory: Value(pvd.briefHistory)));
  }

//delete medication
  Future deleteMedicine(PatientsVisitData pvd, String d, String m) {
    var query = update(patientsVisit)..where((t) => t.id.equals(pvd.id));
    var medicineList =
        pvd.medication.data.where((element) => element.disease == d).first;
    medicineList.medicines.removeWhere((element) => element.title == m);
    pvd.medication.data.removeWhere((element) => element.disease == d);
    pvd.medication.data.add(medicineList);
    return query
        .write(PatientsVisitCompanion(medication: Value(pvd.medication)));
  }

  Future deleteExam(PatientsVisitData pvd, String title) {
    var query = update(patientsVisit)..where((t) => t.id.equals(pvd.id));
    pvd.examination.data.removeWhere((element) => element.title == title);
    return query
        .write(PatientsVisitCompanion(examination: Value(pvd.examination)));
  }

  Future deleteDiagnosis(PatientsVisitData pvd, String title) {
    var query = update(patientsVisit)..where((t) => t.id.equals(pvd.id));
    pvd.diagnosis.data.removeWhere((element) => element.title == title);

    return query.write(PatientsVisitCompanion(diagnosis: Value(pvd.diagnosis)));
  }

  Future updateVisitReason(PatientsVisitData data, VisitReasongenerated vh) {
    var query = update(patientsVisit)..where((t) => t.id.equals(data.id));
    List<VisitReasonData> list = [];
    if (data.visitReason != null) {
      list = data.visitReason.data;
    }
    var res = list.where((element) => element.title == vh.data[0].title);
    if (res.length == 0) {
      list.add(vh.data[0]);
      vh.data = list;
    } else {
      vh.data = list;
    }
    return query.write(PatientsVisitCompanion(visitReason: Value(vh)));
  }

  Stream<List<PatientsVisitData>> getVisitReason(String id) {
    dynamic query;
    query = select(patientsVisit)..where((tbl) => tbl.patientId.equals(id));
    return query.watch();
  }

  Future deleteVisit(PatientsVisitData pvd, String title) {
    var query = update(patientsVisit)..where((t) => t.id.equals(pvd.id));
    pvd.visitReason.data.removeWhere((element) => element.title == title);
    return query
        .write(PatientsVisitCompanion(visitReason: Value(pvd.visitReason)));
  }

  Future deleteFeedBack(PatientsVisitData pvd) {
    var query = update(patientsVisit)..where((t) => t.id.equals(pvd.id));
    pvd.feedBack.data.clear();
    return query.write(PatientsVisitCompanion(feedBack: Value(pvd.feedBack)));
  }

  Stream<List<PatientsVisitData>> getAllergies(String id) {
    dynamic query;
    query = select(patientsVisit)..where((tbl) => tbl.patientId.equals(id));
    return query.watch();
  }

  Future updateAllergy(PatientsVisitData data, Allergy bh) {
    var query = update(patientsVisit)..where((t) => t.id.equals(data.id));
    List<AllergyData> list = [];
    // list = data.briefHistory.data;
    if (data.allergies != null) {
      list = data.allergies.data;
    }
    var res = list.where((element) => element.title == bh.data[0].title);
    if (res.length == 0) {
      list.add(bh.data[0]);
      bh.data = list;
    } else {
      bh.data = list;
    }

    return query.write(PatientsVisitCompanion(allergies: Value(bh)));
  }

  Future deleteallergy(PatientsVisitData pvd, String title) {
    var query = update(patientsVisit)..where((t) => t.id.equals(pvd.id));
    // List<AllergyData> list = [];
    pvd.allergies.data.removeWhere((element) => element.title == title);

    return query.write(PatientsVisitCompanion(allergies: Value(pvd.allergies)));
  }

  Stream<List<PatientsVisitData>> getLifeStyle(String id) {
    dynamic query;
    query = select(patientsVisit)..where((tbl) => tbl.patientId.equals(id));
    return query.watch();
  }

  Future updateLifeStyle(PatientsVisitData data, LifeStyle bh) {
    var query = update(patientsVisit)..where((t) => t.id.equals(data.id));
    List<LifeStyleData> list = [];
    // list = data.briefHistory.data;
    if (data.lifestyle != null) {
      list = data.lifestyle.data;
    }
    var res = list.where((element) => element.title == bh.data[0].title);
    if (res.length == 0) {
      list.add(bh.data[0]);
      bh.data = list;
    } else {
      bh.data = list;
    }

    return query.write(PatientsVisitCompanion(lifestyle: Value(bh)));
  }

  Future deleteLifeStyle(PatientsVisitData pvd, String title) {
    var query = update(patientsVisit)..where((t) => t.id.equals(pvd.id));
    // List<LifeStyleData> list = [];
    pvd.lifestyle.data.removeWhere((element) => element.title == title);

    return query.write(PatientsVisitCompanion(lifestyle: Value(pvd.lifestyle)));
  }

  // void updateTemp(PatientsVisitData pvd, String temp) {
  //   var query = update(patientsVisit)..where((t) => t.id.equals(pvd.id));
  //   query.write(PatientsVisitCompanion(temperature: Value(int.parse(temp))));
  // }

  void updateBP(PatientsVisitData pvd, String bp, String pulse, String temp,
      String weight) {
    var query = update(patientsVisit)..where((t) => t.id.equals(pvd.id));
    query.write(PatientsVisitCompanion(
        bp: Value(
          bp,
        ),
        pulse: Value(pulse),
        weight: Value(weight),
        temperature: Value(temp)));
  }

  // void updatePulse(PatientsVisitData pvd, String pulse) {
  //   var query = update(patientsVisit)..where((t) => t.id.equals(pvd.id));
  //   query.write(PatientsVisitCompanion(pulse: Value(int.parse(pulse))));
  // }

  // void updateWeight(PatientsVisitData pvd, String weight) {
  //   var query = update(patientsVisit)..where((t) => t.id.equals(pvd.id));
  //   query.write(PatientsVisitCompanion(weight: Value(int.parse(weight))));
  // }

  Future updateExaminationParams(
      PatientsVisitData data, int eid, ParameterData pd, String text) {
    print(pd.title);
    print(text);
    var query = update(patientsVisit)..where((t) => t.id.equals(data.id));
    List<ExaminationData> list = [];
    // list = data.briefHistory.data;
    if (data.examination != null) {
      list = data.examination.data;
    }
    var res = list.where((element) => element.examinationId == eid);
    print(res.last.title);

    var par = res.last.parameters;

    for (var x in par) {
      if (x.title == pd.title) {
        print(x.result);
        if (x.result.isEmpty) {
          x.result.add(text);
        } else {
          x.result.last = text;
        }
        print(x.result);
      }
    }

    bool flag = false;
    for (var x in par) {
      if (x.title == pd.title) {
        if (x.result.isEmpty) {
          flag = true;
          break;
        }
      }
    }
    if (flag == false) {
      res.last.status = "Completed";
    }

    // if (res.length == 0) {
    //   list.add(ex.data[0]);
    //   ex.data = list;
    // } else {
    //   ex.data = list;
    // }

    return query.write(PatientsVisitCompanion(
        examination: Value(Examinationgenerated(data: list))));
  }

  Future updateguid(String previousId, String newId) {
    var query = update(patientsVisit)
      ..where((t) => t.patientId.equals(previousId));
    return query.write(PatientsVisitCompanion(
      patientId: Value(newId),
    ));
  }

  Future updateStatus(int id) {
    var query = update(patientsVisit)..where((t) => t.id.equals(id));
    return query.write(PatientsVisitCompanion(
      isOnline: Value(true),
    ));
  }

  Future updateCompleteStatus(String patientId) {
    var query = update(patientsVisit)
      ..where((t) => t.patientId.equals(patientId));
    return query.write(PatientsVisitCompanion(
      completed: Value(true),
    ));
  }
}
