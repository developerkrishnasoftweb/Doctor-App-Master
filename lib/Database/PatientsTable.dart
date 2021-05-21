import 'dart:convert';
import 'dart:io';
import 'package:getcure_doctor/Models/DoctorLogin.dart';
import 'package:moor/moor.dart';
import 'package:moor_ffi/moor_ffi.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:shared_preferences/shared_preferences.dart';

part 'PatientsTable.g.dart';

enum Gender { Male, Female }

class Patients extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get mobileNo => integer()();
  IntColumn get age => integer().nullable()();
  TextColumn get name => text()();
  IntColumn get gender => intEnum<Gender>()();
  TextColumn get address => text().nullable()();
  TextColumn get patientId => text()();
  IntColumn get clinicDoctorId => integer().nullable()();
  BoolColumn get isOnline => boolean().withDefault(Constant(false))();
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'getPatients.sqlite'));
    return VmDatabase(file);
  });
}

@UseMoor(tables: [Patients])
class PatientsDB extends _$PatientsDB {
  PatientsDB() : super(_openConnection());
  @override
  int get schemaVersion => 1;

  Future insert(Patient h) async {
    var q = await fetchTask(h.patientId);
    if (q.length == 0) {
      into(patients).insert(h);
    }
  }

  Future<List<Patient>> fetchTask(String q) {
    dynamic query;
    if (q.length != 0) {
      query = select(patients)..where((t) => t.patientId.equals(q));
    } else {
      query = select(patients);
    }
    return query.get();
  }

  Future<List<String>> showFamily(dynamic p) async {
    List<String> names = [];
    for (var patients in p) {
      names.add(patients.patientId.toString());
    }
    return names;
  }

  Future<List<Patient>> showFamilyPatient(int mobileNo, String name) async {
    String mob = mobileNo.toString();
    dynamic ans = select(patients)..where((u) => u.patientId.like("%$mob"));
    return ans.get();
  }

  Future<List<Patient>> isPatient(int mobileNo, String name) async {
    dynamic ans = select(patients)
      ..where((u) => u.mobileNo.equals(mobileNo) & u.name.equals(name));
    return ans.get();
  }

  Future<List<Patient>> getAll() {
    final query = select(patients);
    return query.get();
  }

  Future<List<Patient>> getAllSync() {
    final query = select(patients)..where((tbl) => tbl.isOnline.equals(false));
    return query.get();
  }

  Future<List<Patient>> checkPatient(String patientId) {
    try {
      var query = select(patients)
        ..where((pat) => pat.patientId.contains(patientId));
      return query.get();
    } catch (e) {
      return null;
    }
  }

  Future createPatient2(Patient patient) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString('dresponse');
    DoctorLogin doctorLogin = DoctorLogin.fromJson(json.decode(token));
    String uniqueId = "A" + patient.mobileNo.toString();

    Patient pat;
    List<Patient> family =
        await this.showFamilyPatient(patient.mobileNo, patient.name);
    List<Patient> ispat = await this.isPatient(patient.mobileNo, patient.name);
    if (ispat.length != 0) {
      uniqueId = ispat[0].patientId;
      pat = ispat[0];
    } else {
      String ch = uniqueId[0];
      uniqueId = uniqueId.replaceAll(
          ch, String.fromCharCode(ch.codeUnitAt(0) + family.length));
      pat = Patient(
          mobileNo: patient.mobileNo,
          name: patient.name,
          gender: patient.gender,
          patientId: uniqueId,
          address: patient.address,
          age: patient.age);
      into(patients).insert(pat);
    }

    List<Patient> part = await checkPatient(pat.patientId);
    //  if (pat.patientId.toString() != part.patientId) {
    // }
    return uniqueId;
  }

  Future deleteallTask() => delete(patients).go();
  Future updateguid(String previousId, String newId) {
    var query = update(patients)..where((t) => t.patientId.equals(previousId));
    return query.write(
        PatientsCompanion(patientId: Value(newId), isOnline: Value(true)));
  }
}
