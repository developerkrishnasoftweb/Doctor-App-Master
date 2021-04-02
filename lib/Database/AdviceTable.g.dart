// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AdviceTable.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Advice extends DataClass implements Insertable<Advice> {
  final int id;
  final String advice;
  final String symptoms;
  Advice({@required this.id, @required this.advice, @required this.symptoms});
  factory Advice.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return Advice(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      advice:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}advice']),
      symptoms: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}symptoms']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || advice != null) {
      map['advice'] = Variable<String>(advice);
    }
    if (!nullToAbsent || symptoms != null) {
      map['symptoms'] = Variable<String>(symptoms);
    }
    return map;
  }

  AdvicesCompanion toCompanion(bool nullToAbsent) {
    return AdvicesCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      advice:
          advice == null && nullToAbsent ? const Value.absent() : Value(advice),
      symptoms: symptoms == null && nullToAbsent
          ? const Value.absent()
          : Value(symptoms),
    );
  }

  factory Advice.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Advice(
      id: serializer.fromJson<int>(json['id']),
      advice: serializer.fromJson<String>(json['advice']),
      symptoms: serializer.fromJson<String>(json['symptoms']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'advice': serializer.toJson<String>(advice),
      'symptoms': serializer.toJson<String>(symptoms),
    };
  }

  Advice copyWith({int id, String advice, String symptoms}) => Advice(
        id: id ?? this.id,
        advice: advice ?? this.advice,
        symptoms: symptoms ?? this.symptoms,
      );
  @override
  String toString() {
    return (StringBuffer('Advice(')
          ..write('id: $id, ')
          ..write('advice: $advice, ')
          ..write('symptoms: $symptoms')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      $mrjf($mrjc(id.hashCode, $mrjc(advice.hashCode, symptoms.hashCode)));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Advice &&
          other.id == this.id &&
          other.advice == this.advice &&
          other.symptoms == this.symptoms);
}

class AdvicesCompanion extends UpdateCompanion<Advice> {
  final Value<int> id;
  final Value<String> advice;
  final Value<String> symptoms;
  const AdvicesCompanion({
    this.id = const Value.absent(),
    this.advice = const Value.absent(),
    this.symptoms = const Value.absent(),
  });
  AdvicesCompanion.insert({
    this.id = const Value.absent(),
    @required String advice,
    @required String symptoms,
  })  : advice = Value(advice),
        symptoms = Value(symptoms);
  static Insertable<Advice> custom({
    Expression<int> id,
    Expression<String> advice,
    Expression<String> symptoms,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (advice != null) 'advice': advice,
      if (symptoms != null) 'symptoms': symptoms,
    });
  }

  AdvicesCompanion copyWith(
      {Value<int> id, Value<String> advice, Value<String> symptoms}) {
    return AdvicesCompanion(
      id: id ?? this.id,
      advice: advice ?? this.advice,
      symptoms: symptoms ?? this.symptoms,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (advice.present) {
      map['advice'] = Variable<String>(advice.value);
    }
    if (symptoms.present) {
      map['symptoms'] = Variable<String>(symptoms.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AdvicesCompanion(')
          ..write('id: $id, ')
          ..write('advice: $advice, ')
          ..write('symptoms: $symptoms')
          ..write(')'))
        .toString();
  }
}

class $AdvicesTable extends Advices with TableInfo<$AdvicesTable, Advice> {
  final GeneratedDatabase _db;
  final String _alias;
  $AdvicesTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _adviceMeta = const VerificationMeta('advice');
  GeneratedTextColumn _advice;
  @override
  GeneratedTextColumn get advice => _advice ??= _constructAdvice();
  GeneratedTextColumn _constructAdvice() {
    return GeneratedTextColumn('advice', $tableName, false,
        minTextLength: 1, maxTextLength: 300);
  }

  final VerificationMeta _symptomsMeta = const VerificationMeta('symptoms');
  GeneratedTextColumn _symptoms;
  @override
  GeneratedTextColumn get symptoms => _symptoms ??= _constructSymptoms();
  GeneratedTextColumn _constructSymptoms() {
    return GeneratedTextColumn('symptoms', $tableName, false,
        minTextLength: 1, maxTextLength: 300);
  }

  @override
  List<GeneratedColumn> get $columns => [id, advice, symptoms];
  @override
  $AdvicesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'advices';
  @override
  final String actualTableName = 'advices';
  @override
  VerificationContext validateIntegrity(Insertable<Advice> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('advice')) {
      context.handle(_adviceMeta,
          advice.isAcceptableOrUnknown(data['advice'], _adviceMeta));
    } else if (isInserting) {
      context.missing(_adviceMeta);
    }
    if (data.containsKey('symptoms')) {
      context.handle(_symptomsMeta,
          symptoms.isAcceptableOrUnknown(data['symptoms'], _symptomsMeta));
    } else if (isInserting) {
      context.missing(_symptomsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Advice map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Advice.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $AdvicesTable createAlias(String alias) {
    return $AdvicesTable(_db, alias);
  }
}

abstract class _$AdvicesDatabase extends GeneratedDatabase {
  _$AdvicesDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $AdvicesTable _advices;
  $AdvicesTable get advices => _advices ??= $AdvicesTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [advices];
}
