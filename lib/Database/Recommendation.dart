import 'dart:convert';
import 'dart:io';
import 'package:moor/moor.dart';
import 'package:moor_ffi/moor_ffi.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'Recommendation.g.dart';

class MedicinesConverter extends TypeConverter<Medicinesgenerated, String> {
  const MedicinesConverter();
  @override
  Medicinesgenerated mapToDart(String fromDb) {
    if (fromDb == null) {
      return null;
    }
    return Medicinesgenerated.fromJson(
        json.decode(fromDb) as Map<String, dynamic>);
  }

  @override
  String mapToSql(Medicinesgenerated value) {
    if (value == null) {
      return null;
    }

    return json.encode(value.toJson());
  }
}

class Medicinesgenerated {
  List<String> medicines;

  Medicinesgenerated({this.medicines});

  Medicinesgenerated.fromJson(Map<String, dynamic> json) {
    medicines = json['medicines'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['medicines'] = this.medicines;
    return data;
  }
}

class Recommendation extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get clinicDoctorId => integer()();
  IntColumn get doctorId => integer()();
  TextColumn get disease => text()();
  IntColumn get totalCount => integer().withDefault(Constant(0))();
  IntColumn get cured => integer().withDefault(Constant(0))();
  IntColumn get partiallyCured => integer().withDefault(Constant(0))();
  IntColumn get notCured => integer().withDefault(Constant(0))();
  TextColumn get medicines =>
      text().map(const MedicinesConverter()).nullable()();
  IntColumn get symptomsIncreased => integer().withDefault(Constant(0))();
  DateTimeColumn get createdAt => dateTime().nullable()();
  BoolColumn get isOnline => boolean().withDefault(Constant(false))();
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'Recommendation.sqlite'));
    return VmDatabase(file);
  });
}

@UseMoor(tables: [Recommendation])
class RecommendationDB extends _$RecommendationDB {
  RecommendationDB() : super(_openConnection());
  @override
  int get schemaVersion => 1;
  Future insert(RecommendationData p) => into(recommendation).insert(p);

  Future updateData(String disease, String feedback, List<String> med,
      RecommendationData list) async {
    var query = update(recommendation)..where((tbl) => tbl.id.equals(list.id));
    // RecommendationData list = await check(disease,med);
    // list.medicines.medicines.addAll(med);
    // list.medicines.medicines =
    //     list.medicines.medicines.toSet().toList();
    RecommendationData newlist;
    switch (feedback) {
      case 'Cured Complete':
        newlist = list.copyWith(
          cured: list.cured + 1,
          totalCount: list.totalCount + 1,
        );
        break;
      case 'Partially Cured':
        newlist = list.copyWith(
          partiallyCured: list.partiallyCured + 1,
          totalCount: list.totalCount + 1,
        );
        break;
      case 'Not Cured':
        newlist = list.copyWith(
          notCured: list.notCured + 1,
          totalCount: list.totalCount + 1,
        );
        break;
      default:
        newlist = list.copyWith(
          symptomsIncreased: list.symptomsIncreased + 1,
          totalCount: list.totalCount + 1,
        );
    }

    // list.removeLast();
    // list.add(newlist);
    return query.write(RecommendationCompanion(
      clinicDoctorId: Value(newlist.clinicDoctorId),
      doctorId: Value(newlist.doctorId),
      cured: Value(newlist.cured),
      disease: Value(newlist.disease),
      id: Value(newlist.id),
      isOnline: Value(newlist.isOnline),
      createdAt: Value(newlist.createdAt),
      medicines: Value(newlist.medicines),
      notCured: Value(newlist.notCured),
      partiallyCured: Value(newlist.partiallyCured),
      symptomsIncreased: Value(newlist.symptomsIncreased),
      totalCount: Value(newlist.totalCount),
    ));
  }

  Future<RecommendationData> check(String disease, List<String> med) async {
    var query = select(recommendation)
      ..where((tbl) => tbl.disease.equals(disease));
    List<RecommendationData> list = await query.get();

    for (var j in list) {
      int k = 0;
      int flag = 0;
      for (var i in j.medicines.medicines) {
        if (j.medicines.medicines.length != med.length ||
            !med.contains(i) ||
            !i.contains(med[k])) {
          flag = 1;
          break;
        }
        k += 1;
      }
      if (flag == 0) {
        return j;
      }
    }

    return null;
  }

  Future recommend(String disease) async {
    var query = select(recommendation)
      ..where((tbl) => tbl.disease.equals(disease));
    List<RecommendationData> list = await query.get();
    list.sort((a, b) {
      double perA = (a.cured / a.totalCount) * 100;
      double perB = (b.cured / b.totalCount) * 100;
      return perA.compareTo(perB);
    });
    return list;
  }

  Future<List<RecommendationData>> getTotalCount(String disease) async{
    RecommendationData data ;
    var query = select(recommendation)
      ..where((tbl) => tbl.disease.equals(disease));
      List<RecommendationData> list = await query.get();
      return list;
      // print('Recommendation counts');
      // print(list);
      // return list.length;
  }
}
