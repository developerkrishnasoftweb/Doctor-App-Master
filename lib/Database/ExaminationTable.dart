import 'dart:convert';
import 'dart:io';
import 'package:moor/moor.dart';
import 'package:moor_ffi/moor_ffi.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
part 'ExaminationTable.g.dart';

class Parameters2 {
  List<ParameterData> data;
  Parameters2({this.data});
  Parameters2.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<ParameterData>();
      json['data'].forEach((v) {
        data.add(new ParameterData.fromJson(v));
      });
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ParameterData {
  dynamic title;
  dynamic type;
  dynamic sample;
  dynamic method;
  List<dynamic> references;
  dynamic unit;
  List<dynamic> bioReference;

  ParameterData(
      {this.title,
      this.type,
      this.sample,
      this.method,
      this.references,
      this.unit,
      this.bioReference});

  ParameterData.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    type = json['type'];
    method = json['method'];
    sample = json['sample'];
    references = json['references'].cast<String>();
    unit = json['unit'];
    bioReference = json['bio_references'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['type'] = this.type;
    data['references'] = this.references;
    data['unit'] = this.unit;
    data['method'] = this.method;
    data['sample'] = this.sample;
    data['bio_references'] = this.bioReference;
    return data;
  }
}

class ParametersConverter extends TypeConverter<Parameters2, String> {
  const ParametersConverter();
  @override
  Parameters2 mapToDart(String fromDb) {
    if (fromDb == null) {
      return null;
    }
    return Parameters2.fromJson(json.decode(fromDb) as Map<String, dynamic>);
  }

  @override
  String mapToSql(Parameters2 value) {
    if (value == null) {
      return null;
    }

    return json.encode(value.toJson());
  }
}

class Examinations extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get clinicDoctorId => integer()();
  IntColumn get doctorId => integer()();
  TextColumn get title => text()();
  TextColumn get parameters =>
      text().map(const ParametersConverter()).nullable()();
  IntColumn get price => integer()();
  BoolColumn get isOnline => boolean().withDefault(Constant(false))();
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'getExamination.sqlite'));
    return VmDatabase(file, logStatements: true);
  });
}

@UseMoor(tables: [Examinations])
class ExaminationsDB extends _$ExaminationsDB {
  ExaminationsDB() : super(_openConnection());
  @override
  int get schemaVersion => 1;

  Future insertTask(Examination examination) async {
    var q = await fetchTask(examination.title);
    if (q.length == 0) {
      into(examinations).insert(examination);
    } else {
      print('Already Exists in table');
    }
  }

  Future<List<Examination>> fetchTask(String q) {
    dynamic query;
    if (q.length != 0) {
      query = select(examinations)..where((t) => t.title.contains(q));
    } else {
      query = select(examinations);
    }

    return query.get();
  }

  Stream<List<Examination>> watchAllTasks(String q) {
    dynamic query;
    if (q.length != 0) {
      query = select(examinations)..where((t) => t.title.contains(q));
    } else {
      query = select(examinations);
    }

    return query.watch();
  }

  Future<List<Examination>> getAllSync() {
    var query = select(examinations)..where((t) => t.isOnline.equals(false));
    return query.get();
  }

  Future deleteallTask() => delete(examinations).go();

  Future updateStatus(int id) {
    var query = update(examinations)..where((t) => t.id.equals(id));
    return query.write(ExaminationsCompanion(
      isOnline: Value(true),
    ));
  }
  // Future updateParams(Examination examination) {
  //   var query = update(examinations)..where((t) => t.id.equals(examination.id));
  //   Parameters params = examination.parameters;

  //   query.write(ExaminationsCompanion(parameters: ));
  // }
}
