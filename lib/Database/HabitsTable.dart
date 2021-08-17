import 'dart:io';
import 'package:moor/moor.dart';
import 'package:moor/ffi.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'HabitsTable.g.dart';

enum HType { Allergy, LifeStyle }

class Habits extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get clinicDoctorId => integer().nullable()();
  IntColumn get doctorId => integer()();
  TextColumn get title => text()();
  IntColumn get type => intEnum<HType>()();
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  BoolColumn get isOnline => boolean().withDefault(Constant(false))();
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'getHabits.sqlite'));
    return VmDatabase(file);
  });
}

@UseMoor(tables: [Habits])
class HabitDB extends _$HabitDB {
  HabitDB() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future insert(Habit h) async {
    var q = await fetchTask(h.title);
    if (q.length == 0) {
      into(habits).insert(h);
    } else {

    }
  }

  Future<List<Habit>> fetchTask(String q) {
    dynamic query;
    if (q.length != 0) {
      query = select(habits)..where((t) => t.title.contains(q));
    } else {
      query = select(habits);
    }
    return query.get();
  }

  Stream<List<Habit>> watchAllTasks(String q, HType t) {
    dynamic query;
    if (q.length != 0) {
      query = select(habits)
        ..where((t) => t.title.contains(q))
        ..where((tbl) => tbl.type.equals(t.index));
    } else {
      query = select(habits)..where((tbl) => tbl.type.equals(t.index));
    }
    return query.watch();
  }

  Stream<List<Habit>> watchAllTask(String q) {
    dynamic query;
    if (q.length != 0) {
      query = select(habits)..where((t) => t.title.contains(q));
    } else {
      query = select(habits);
    }
    return query.watch();
  }

  Future updateStatus(int id) {
    var query = update(habits)..where((t) => t.id.equals(id));
    return query.write(HabitsCompanion(
      isOnline: Value(true),
    ));
  }

  insertAllergy(String allergyName, int docId) {
    Habit habit = Habit(
      doctorId: docId,
      title: allergyName,
      type: HType.Allergy,
    );
    into(habits).insert(habit);
  }

  insertLifeStyle(String lifeName, int docId) {
    Habit habit = Habit(
      doctorId: docId,
      title: lifeName,
      type: HType.LifeStyle,
    );
    into(habits).insert(habit);
  }

  Future<List<Habit>> getAllSync() {
    var query = select(habits)..where((t) => t.isOnline.equals(false));
    return query.get();
  }
  Future deleteallTask() => delete(habits).go();
}
