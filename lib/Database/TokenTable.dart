import 'dart:io';
import 'package:moor/moor.dart';
import 'package:moor/ffi.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:intl/intl.dart';
part 'TokenTable.g.dart';

class Tokens extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get tokenno => integer()();
  IntColumn get doctorid => integer()();
  IntColumn get clinicid => integer()();
  TextColumn get appointmentId => text().nullable()();
  DateTimeColumn get tokentime => dateTime()();
  TextColumn get name => text().nullable()();
  IntColumn get age => integer().nullable()();
  TextColumn get address => text().nullable()();
  IntColumn get mobileno => integer().nullable()();
  TextColumn get appointmenttype => text().nullable()();
  TextColumn get visittype => text().nullable()();
  TextColumn get bookedtype => text().nullable()();
  TextColumn get bookedBy => text().nullable()();
  TextColumn get bookedVia => text().nullable()();
  TextColumn get transactionId => text().nullable()();
  IntColumn get fees => integer()();
  BoolColumn get cancelled => boolean().withDefault(Constant(false))();
  BoolColumn get completed => boolean().withDefault(Constant(false))();
  BoolColumn get isPresent => boolean().withDefault(Constant(false))();
  BoolColumn get booked => boolean().withDefault(Constant(false))();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get bookedAt => dateTime().nullable()();
  DateTimeColumn get presentTime => dateTime().nullable()();
  BoolColumn get isOnline => boolean().withDefault(Constant(false))();
  TextColumn get guid => text().nullable()();
  TextColumn get gender => text().nullable()();
  BoolColumn get shift => boolean().withDefault(Constant(true))();
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'getToken.sqlite'));
    return VmDatabase(file);
  });
}

@UseMoor(tables: [Tokens])
class TokenDB extends _$TokenDB {
  TokenDB() : super(_openConnection());
  @override
  int get schemaVersion => 1;

  Future<List<Token>> getAllTasks(DateTime time, int clinicId) {
    final query = select(tokens)
      ..where((t) => t.tokentime.day.equals(time.day))
      ..where((tbl) => tbl.doctorid.equals(clinicId))
      ..where((t) => t.booked.equals(false));
    return query.get();
  }

  Future<List<Token>> getToken(DateTime time, int clinicid) {
    final query = select(tokens)
      ..where((t) => t.tokentime.equals(time))
      ..where((tbl) => tbl.doctorid.equals(clinicid));
    // ..where((t) => t.booked.equals(false));
    return query.get();
  }

  Future<List<Token>> getCancelledToken(int clinicid) {
    final query = select(tokens)
      ..where((tbl) => tbl.doctorid.equals(clinicid))
      ..where((tbl) => tbl.cancelled.equals(true))
      ..where((tbl) => tbl.isOnline.equals(false));
      // ..where((t) => t.booked.equals(false));
    return query.get();
  }

  Stream<List<Token>> watchAllTasks(String q, DateTime date) {
    dynamic query;

    if (q.isNotEmpty) {
      query = select(tokens)
        ..where((t) => t.name.contains(q) | t.address.contains(q))
        ..where((t) => (t.booked.equals(true) |
            t.cancelled.equals(true) & t.tokentime.day.equals(date.day)));
    } else {
      query = select(tokens)
        ..where((t) => t.booked.equals(true) | t.cancelled.equals(true))
        ..where((tbl) => tbl.tokentime.day.equals(date.day));
    }
    return query.watch();
  }

  Future<List<Token>> getAllbookedTasks(DateTime date) {
    dynamic query;
    query = select(tokens)
      ..where((t) => t.booked.equals(true))
      ..where((tbl) => tbl.tokentime.day.equals(date.day));
    // DateTime d = DateTime.parse(
    //     DateFormat('yyyy-MM-dd').format(DateTime.now()).toString() +
    //         " 00:00:00");
    // query = select(tokens)
    //   ..where((t) => t.booked.equals(true))
    //   ..where((t) => t.tokentime.isBiggerOrEqualValue(d));
    return query.get();
  }

  Future<List<Token>> getAll(String guid, DateTime date, DateTime bookedAt) {
    dynamic query;
    query = select(tokens)
      ..where((t) => t.booked.equals(true))
      ..where((tbl) => tbl.tokentime.equals(date))
      ..where((tbl) => tbl.guid.equals(guid));

    return query.get();
  }

  Future<List<Token>> getCancelledTokens(DateTime date, String guid) {
    dynamic query;
    query = select(tokens)
      ..where((t) => t.booked.equals(false))
      ..where((tbl) => tbl.cancelled.equals(true))
      ..where((tbl) => tbl.tokentime.equals(date))
      ..where((tbl) => tbl.guid.equals(guid));
    // DateTime d = DateTime.parse(
    //     DateFormat('yyyy-MM-dd').format(DateTime.now()).toString() +
    //         " 00:00:00");
    // query = select(tokens)
    //   ..where((t) => t.booked.equals(true))
    //   ..where((t) => t.tokentime.isBiggerOrEqualValue(d));
    return query.get();
  }

  Stream<List<Token>> watchAllbookedTasks(DateTime date) {
    dynamic query;
    query = select(tokens)
      ..where((t) => t.booked.equals(true))
      ..where((tbl) => tbl.tokentime.day.equals(date.day));
    // DateTime d = DateTime.parse(
    //     DateFormat('yyyy-MM-dd').format(DateTime.now()).toString() +
    //         " 00:00:00");
    // query = select(tokens)
    //   ..where((t) => t.booked.equals(true))
    //   ..where((t) => t.tokentime.isBiggerOrEqualValue(d));
    return query.watch();
  }

  Stream<List<Token>> watchAllEmergencyTasks(DateTime date) {
    dynamic query;
    query = select(tokens)
      ..where((t) => t.booked.equals(true))
      ..where((t) => t.appointmenttype.equals("emergency"))
      ..where((tbl) => tbl.tokentime.day.equals(date.day));
    // DateTime d = DateTime.parse(
    //     DateFormat('yyyy-MM-dd').format(DateTime.now()).toString() +
    //         " 00:00:00");
    // query = select(tokens)
    //   ..where((t) => t.booked.equals(true))
    //   ..where((t) =>   t.appointmenttype.equals("emergency") )
    //   ..where((t) => t.tokentime.isBiggerOrEqualValue(d));

    return query.watch();
  }
  
  Future<List<Token>> getAllEmergencyTasks(DateTime date){
    dynamic query;
    query = select(tokens)
      ..where((t) => t.booked.equals(true))
      ..where((t) => t.appointmenttype.equals("emergency"))
      ..where((tbl) => tbl.tokentime.day.equals(date.day));
    return query.get();
  }


  Future<List<Token>> getAllBookedTokens() async {
    var query;
    DateTime d = DateTime.parse(
        DateFormat('yyyy-MM-dd').format(DateTime.now()).toString() +
            " 00:00:00");
    query = select(tokens)
      ..where((t) => t.booked.equals(true))
      ..where((t) => t.tokentime.isBiggerOrEqualValue(d));
    // print(await query.get());
    return query.get();
  }

  Future<int> allBooked() async {
    dynamic query = select(tokens)..where((t) => t.booked.equals(true));
    return query.length;
  }

  Future<int> frontDesk() {
    final query = select(tokens)
      ..where((t) => t.booked.equals(true))
      ..where((p) => p.bookedtype.equals('walk in'));
    return query.watch().length;
  }

  Stream<List<Token>> watchondate(DateTime time, int clinicId) {
    final query = select(tokens)
      ..where((t) => t.tokentime.day.equals(time.day))
      ..where((t) => t.booked.equals(false))
      ..where((tbl) => tbl.doctorid.equals(clinicId))
      ..where((t) => t.cancelled.equals(false));
    return query.watch();
  }

  Future insertTask(Token token) => into(tokens).insert(token);
  Future updateTask(Token token) => update(tokens).replace(token);
  Future updateData(Token token) {
    var query = update(tokens)..where((t) => t.id.equals(token.id));
    return query.write(TokensCompanion(
        guid: Value(token.guid),
        gender: Value(token.gender),
        booked: Value(token.booked),
        cancelled: Value(token.cancelled),
        name: Value(token.name),
        address: Value(token.address),
        age: Value(token.age),
        isOnline: Value(token.isOnline),
        fees: Value(token.fees),
        appointmenttype: Value(token.appointmenttype),
        visittype: Value(token.visittype),
        bookedtype: Value(token.bookedtype),
        isPresent: Value(token.isPresent),
        bookedAt: Value(token.bookedAt),
        mobileno: Value(token.mobileno),
        appointmentId: Value(token.appointmentId),
        bookedBy: Value(token.bookedBy),
        presentTime: Value(token.presentTime)));
  }

  Future updateOnline(Token token) {
    var query = update(tokens)
      ..where((t) =>
          t.tokentime.equals(token.tokentime) &
          t.doctorid.equals(token.doctorid) &
          t.booked.equals(false) &
          t.cancelled.equals(false));
    return query.write(TokensCompanion(
        guid: Value(token.guid),
        updatedAt: Value(DateTime.now()),
        booked: Value(token.booked),
        cancelled: Value(token.cancelled),
        name: Value(token.name),
        address: Value(token.address),
        age: Value(token.age),
        fees: Value(token.fees),
        appointmenttype: Value(token.appointmenttype),
        visittype: Value(token.visittype),
        bookedtype: Value(token.bookedtype),
        presentTime: Value(token.presentTime),
        appointmentId: Value(token.appointmentId),
        isOnline: Value(token.isOnline),
        isPresent: Value(token.isPresent),
        bookedAt: Value(token.bookedAt),
        mobileno: Value(token.mobileno)));
  }

  Future<List<Token>> getcount(DateTime date) async {
    dynamic query;
    query = select(tokens)
      ..where((t) => t.booked.equals(true))
      ..where((tbl) => tbl.tokentime.day.equals(date.day));
    return query.get();
    // dynamic query;
    // DateTime d = DateTime.parse(
    //     DateFormat('yyyy-MM-dd').format(DateTime.now()).toString() +
    //         " 00:00:00");
    // query = select(tokens)
    //   ..where((t) => t.booked.equals(true))
    //   ..where((t) => t.tokentime.isBiggerOrEqualValue(d));
    // return query.get();
    // dynamic query;
    // DateTime d = DateTime.parse(
    //     DateFormat('yyyy-MM-dd').format(DateTime.now()).toString() +
    //         " 00:00:00");
    // query = (await select(tokens).get()).where((t) => (t.booked==true) & ((t.tokentime.compareTo(d))>=0) );
    // return query.length;
  }

  Future<List<Token>> getcountCompleted(DateTime date) async {
    dynamic query;
    query = select(tokens)
      ..where((t) => t.booked.equals(true))
      ..where((t) => t.completed.equals(true))
      ..where((tbl) => tbl.tokentime.day.equals(date.day));
    return query.get();
    // dynamic query;
    // DateTime d = DateTime.parse(
    //     DateFormat('yyyy-MM-dd').format(DateTime.now()).toString() +
    //         " 00:00:00");
    // query = (await select(tokens).get())
    //     .where((t) => ((t.booked == true) & (t.completed == true) & ((t.tokentime.compareTo(d))>=0)));
    // return query.length;
  }

  Future<List<Token>> getcountoncall(DateTime date) async {
    dynamic query;
    query = select(tokens)
      ..where((t) => t.booked.equals(true))
      ..where((t) => t.bookedtype.equals("on call"))
      ..where((tbl) => tbl.tokentime.day.equals(date.day));
    return query.get();
    // dynamic query;
    // DateTime d = DateTime.parse(
    //     DateFormat('yyyy-MM-dd').format(DateTime.now()).toString() +
    //         " 00:00:00");
    // query = (await select(tokens).get())
    //     .where((t) => t.bookedtype == "on call")
    //     .where((t) => t.booked == true & ((t.tokentime.compareTo(d))>=0));
    // return query.length;
  }

  Future<List<Token>> getcountonfront(DateTime date) async {
    dynamic query;
    query = select(tokens)
      ..where((t) => t.booked.equals(true))
      ..where((t) => t.bookedtype.equals("walk in"))
      ..where((tbl) => tbl.tokentime.day.equals(date.day));
    return query.get();
    // dynamic query;
    // DateTime d = DateTime.parse(
    //     DateFormat('yyyy-MM-dd').format(DateTime.now()).toString() +
    //         " 00:00:00");
    // query = (await select(tokens).get())
    //     .where((t) => t.bookedtype == "walk in")
    //     .where((t) => t.booked == true & ((t.tokentime.compareTo(d))>=0));
    // return query.length;
  }

  Future<List<Token>> getcountOnline(DateTime date) async {
    dynamic query;
    query = select(tokens)
      ..where((t) => t.booked.equals(true))
      ..where((t) => t.isOnline.equals(true))
      ..where((tbl) => tbl.tokentime.day.equals(date.day));
    return query.get();
    // dynamic query;
    // DateTime d = DateTime.parse(
    //     DateFormat('yyyy-MM-dd').format(DateTime.now()).toString() +
    //         " 00:00:00");
    // query = (await select(tokens).get())
    //     .where((t) => t.isOnline == true)
    //     .where((t) => t.booked == true & ((t.tokentime.compareTo(d))>=0));
    // return query.length;
  }

  Future<List<Token>> getcountPresent(DateTime date) async {
    dynamic query;
    query = select(tokens)
      ..where((t) => t.booked.equals(true))
      ..where((t) => t.isPresent.equals(true))
      ..where((tbl) => tbl.tokentime.day.equals(date.day));
    return query.get();
    // dynamic query;
    // DateTime d = DateTime.parse(
    //     DateFormat('yyyy-MM-dd').format(DateTime.now()).toString() +
    //         " 00:00:00");
    // query = (await select(tokens).get())
    //     .where((t) => ((t.booked == true) & (t.isPresent == true)& ((t.tokentime.compareTo(d))>=0)));
    // return query.length;
  }

  Future deleteTask(Token token) => delete(tokens).delete(token);
  Future deleteallbydate(DateTime time) =>
      (delete(tokens)..where((t) => t.tokentime.isSmallerThanValue(time))).go();
  Future deleteallTask() => delete(tokens).go();

  Stream<List<Token>> watchAllCompletedTasks(DateTime date) {
    dynamic query;
    query = select(tokens)
      ..where((t) => t.booked.equals(true))
      ..where((t) => t.completed.equals(true))
      ..where((tbl) => tbl.tokentime.day.equals(date.day));
    // DateTime d = DateTime.parse(
    //     DateFormat('yyyy-MM-dd').format(DateTime.now()).toString() +
    //         " 00:00:00");
    // query = select(tokens)
    //   ..where((t) => t.booked.equals(true) & t.completed.equals(true))
    //   ..where((t) => t.tokentime.isBiggerOrEqualValue(d));

    return query.watch();
  }

  Stream<List<Token>> watchAllPresentTasks(DateTime date) {
    dynamic query;
    query = select(tokens)
      ..where((t) => t.booked.equals(true))
      ..where((t) => t.isPresent.equals(true))
      ..where((tbl) => tbl.tokentime.day.equals(date.day));
    // DateTime d = DateTime.parse(
    //     DateFormat('yyyy-MM-dd').format(DateTime.now()).toString() +
    //         " 00:00:00");
    // query = select(tokens)
    //   ..where((t) => t.booked.equals(true) & t.isPresent.equals(true))
    //   ..where((t) => t.tokentime.isBiggerOrEqualValue(d));

    return query.watch();
  }

  Future updateguid(String previousId, String newId) {
    var query = update(tokens)..where((t) => t.guid.equals(previousId));
    return query.write(TokensCompanion(
      guid: Value(newId),
    ));
  }

  Future<List<Token>> getAllSync() {
    final query = select(tokens)
      ..where((tbl) => tbl.isOnline.equals(false))
      ..where((tbl) => tbl.booked.equals(true));
    return query.get();
  }

  Future updateStatus(int id) {
    var query = update(tokens)..where((t) => t.id.equals(id));
    return query.write(TokensCompanion(
      isOnline: Value(true),
    ));
  }

  Future updateCompleteStatus(String guid) {
    var query = update(tokens)..where((t) => t.guid.equals(guid));
    return query.write(TokensCompanion(
      completed: Value(true),
    ));
  }
}
