import 'dart:io';

import 'package:moor/moor.dart';
import 'package:moor_ffi/moor_ffi.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'AdviceTable.g.dart';

class Advices extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get advice => text().withLength(min: 1, max: 300)();

  TextColumn get symptoms => text().withLength(min: 1, max: 300)();
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'getAdvices.sqlite'));
    return VmDatabase(file, logStatements: true);
  });
}

@UseMoor(tables: [Advices])
class AdvicesDatabase extends _$AdvicesDatabase {
  AdvicesDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<List<Advice>> getAllAdvices() => select(advices).get();

  Stream<List<Advice>> watchAllAdvices() => select(advices).watch();

  Future insertAdvice(Advice advice) => into(advices).insert(advice);

  Future updateAdvice(Advice advice) => update(advices).replace(advice);

  Future deleteAdvice(Advice advice) => delete(advices).delete(advice);

  truncate() async {
    List<Advice> advices = await getAllAdvices();
    for (var advice in advices) {
      await deleteAdvice(advice);
    }
  }
}
