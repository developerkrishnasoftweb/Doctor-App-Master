import 'dart:convert';
import 'dart:io';
import 'package:moor/moor.dart';
import 'package:moor_ffi/moor_ffi.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
part 'MedicinesTable.g.dart';

class InteractionDrugConverter
    extends TypeConverter<InteractionDruggenerated, String> {
  const InteractionDrugConverter();
  @override
  InteractionDruggenerated mapToDart(String fromDb) {
    if (fromDb == null) {
      return null;
    }
    return InteractionDruggenerated.fromJson(
        json.decode(fromDb) as Map<String, dynamic>);
  }

  @override
  String mapToSql(InteractionDruggenerated value) {
    if (value == null) {
      return null;
    }

    return json.encode(value.toJson());
  }
}

class InteractionDruggenerated {
  List<String> interactionDrug;

  InteractionDruggenerated({this.interactionDrug});

  InteractionDruggenerated.fromJson(Map<String, dynamic> json) {
    interactionDrug = json['interaction_drug'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['interaction_drug'] = this.interactionDrug;
    return data;
  }
}

class Medicines extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get clinicDoctorId => integer()();
  IntColumn get doctorId => integer()();
  TextColumn get title => text()();
  TextColumn get defaultUnit => text()();
  TextColumn get defaultRoute => text()();
  TextColumn get defaultFrequency => text()();
  TextColumn get defaultDirection => text()();
  TextColumn get defaultDuration => text()();
  TextColumn get salt => text()();
  TextColumn get interactionDrugs =>
      text().map(const InteractionDrugConverter()).nullable()();
  TextColumn get category => text()();
  TextColumn get defaultDose => text()();
  BoolColumn get isOnline => boolean().withDefault(Constant(false))();
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'getMedicines.sqlite'));
    return VmDatabase(file, logStatements: true);
  });
}

@UseMoor(tables: [Medicines])
class MedicinesDB extends _$MedicinesDB {
  MedicinesDB() : super(_openConnection());
  @override
  int get schemaVersion => 1;
  Future insert(Medicine m) => into(medicines).insert(m);
  Future insertHttp(Medicine m) async {
    var q = await fetchTask(m.title);
    if (q.length == 0) {
      into(medicines).insert(m);
    } else {
      print('Already Exists in table');
    }
  }

  Stream<List<Medicine>> watchAllTask(String q) {
    dynamic query;
    if (q.length != 0) {
      query = select(medicines)..where((t) => t.title.like("%$q%"));
    } else {
      query = select(medicines);
    }
    return query.watch();
  }

  Future<List<Medicine>> fetchTask(String q) {
    dynamic query;
    if (q.length != 0) {
      query = select(medicines)..where((t) => t.title.like("%$q%"));
    } else {
      query = select(medicines);
    }
    return query.get();
  }

  Future updateStatus(int id) {
    var query = update(medicines)..where((t) => t.id.equals(id));
    return query.write(MedicinesCompanion(
      isOnline: Value(true),
    ));
  }

  Future<List<Medicine>> getMed(String q) {
    var query = select(medicines)..where((t) => t.title.equals(q));

    return query.get();
  }

  Future<List<Medicine>> getAllSync() {
    var query = select(medicines)..where((t) => t.isOnline.equals(false));
    return query.get();
  }

  Stream<List<Medicine>> searchCategory(String q) {
    dynamic query;
    if (q.length != 0) {
      query = select(medicines)..where((t) => t.category.like("%$q%"));
    } else {
      query = select(medicines);
    }
    return query.watch();
  }
  Future deleteallTask() => delete(medicines).go();
}
