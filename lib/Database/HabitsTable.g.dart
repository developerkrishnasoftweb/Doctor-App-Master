// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'HabitsTable.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Habit extends DataClass implements Insertable<Habit> {
  final int id;
  final int clinicDoctorId;
  final int doctorId;
  final String title;
  final HType type;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isOnline;
  Habit(
      {@required this.id,
      this.clinicDoctorId,
      @required this.doctorId,
      @required this.title,
      @required this.type,
      this.createdAt,
      this.updatedAt,
      @required this.isOnline});
  factory Habit.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    final boolType = db.typeSystem.forDartType<bool>();
    return Habit(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      clinicDoctorId: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}clinic_doctor_id']),
      doctorId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}doctor_id']),
      title:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}title']),
      type: $HabitsTable.$converter0.mapToDart(
          intType.mapFromDatabaseResponse(data['${effectivePrefix}type'])),
      createdAt: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at']),
      updatedAt: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}updated_at']),
      isOnline:
          boolType.mapFromDatabaseResponse(data['${effectivePrefix}is_online']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || clinicDoctorId != null) {
      map['clinic_doctor_id'] = Variable<int>(clinicDoctorId);
    }
    if (!nullToAbsent || doctorId != null) {
      map['doctor_id'] = Variable<int>(doctorId);
    }
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    if (!nullToAbsent || type != null) {
      final converter = $HabitsTable.$converter0;
      map['type'] = Variable<int>(converter.mapToSql(type));
    }
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime>(createdAt);
    }
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    if (!nullToAbsent || isOnline != null) {
      map['is_online'] = Variable<bool>(isOnline);
    }
    return map;
  }

  HabitsCompanion toCompanion(bool nullToAbsent) {
    return HabitsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      clinicDoctorId: clinicDoctorId == null && nullToAbsent
          ? const Value.absent()
          : Value(clinicDoctorId),
      doctorId: doctorId == null && nullToAbsent
          ? const Value.absent()
          : Value(doctorId),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      type: type == null && nullToAbsent ? const Value.absent() : Value(type),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
      isOnline: isOnline == null && nullToAbsent
          ? const Value.absent()
          : Value(isOnline),
    );
  }

  factory Habit.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Habit(
      id: serializer.fromJson<int>(json['id']),
      clinicDoctorId: serializer.fromJson<int>(json['clinicDoctorId']),
      doctorId: serializer.fromJson<int>(json['doctorId']),
      title: serializer.fromJson<String>(json['title']),
      type: serializer.fromJson<HType>(json['type']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      isOnline: serializer.fromJson<bool>(json['isOnline']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'clinicDoctorId': serializer.toJson<int>(clinicDoctorId),
      'doctorId': serializer.toJson<int>(doctorId),
      'title': serializer.toJson<String>(title),
      'type': serializer.toJson<HType>(type),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'isOnline': serializer.toJson<bool>(isOnline),
    };
  }

  Habit copyWith(
          {int id,
          int clinicDoctorId,
          int doctorId,
          String title,
          HType type,
          DateTime createdAt,
          DateTime updatedAt,
          bool isOnline}) =>
      Habit(
        id: id ?? this.id,
        clinicDoctorId: clinicDoctorId ?? this.clinicDoctorId,
        doctorId: doctorId ?? this.doctorId,
        title: title ?? this.title,
        type: type ?? this.type,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        isOnline: isOnline ?? this.isOnline,
      );
  @override
  String toString() {
    return (StringBuffer('Habit(')
          ..write('id: $id, ')
          ..write('clinicDoctorId: $clinicDoctorId, ')
          ..write('doctorId: $doctorId, ')
          ..write('title: $title, ')
          ..write('type: $type, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isOnline: $isOnline')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          clinicDoctorId.hashCode,
          $mrjc(
              doctorId.hashCode,
              $mrjc(
                  title.hashCode,
                  $mrjc(
                      type.hashCode,
                      $mrjc(createdAt.hashCode,
                          $mrjc(updatedAt.hashCode, isOnline.hashCode))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Habit &&
          other.id == this.id &&
          other.clinicDoctorId == this.clinicDoctorId &&
          other.doctorId == this.doctorId &&
          other.title == this.title &&
          other.type == this.type &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.isOnline == this.isOnline);
}

class HabitsCompanion extends UpdateCompanion<Habit> {
  final Value<int> id;
  final Value<int> clinicDoctorId;
  final Value<int> doctorId;
  final Value<String> title;
  final Value<HType> type;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<bool> isOnline;
  const HabitsCompanion({
    this.id = const Value.absent(),
    this.clinicDoctorId = const Value.absent(),
    this.doctorId = const Value.absent(),
    this.title = const Value.absent(),
    this.type = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isOnline = const Value.absent(),
  });
  HabitsCompanion.insert({
    this.id = const Value.absent(),
    this.clinicDoctorId = const Value.absent(),
    @required int doctorId,
    @required String title,
    @required HType type,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isOnline = const Value.absent(),
  })  : doctorId = Value(doctorId),
        title = Value(title),
        type = Value(type);
  static Insertable<Habit> custom({
    Expression<int> id,
    Expression<int> clinicDoctorId,
    Expression<int> doctorId,
    Expression<String> title,
    Expression<int> type,
    Expression<DateTime> createdAt,
    Expression<DateTime> updatedAt,
    Expression<bool> isOnline,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (clinicDoctorId != null) 'clinic_doctor_id': clinicDoctorId,
      if (doctorId != null) 'doctor_id': doctorId,
      if (title != null) 'title': title,
      if (type != null) 'type': type,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (isOnline != null) 'is_online': isOnline,
    });
  }

  HabitsCompanion copyWith(
      {Value<int> id,
      Value<int> clinicDoctorId,
      Value<int> doctorId,
      Value<String> title,
      Value<HType> type,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<bool> isOnline}) {
    return HabitsCompanion(
      id: id ?? this.id,
      clinicDoctorId: clinicDoctorId ?? this.clinicDoctorId,
      doctorId: doctorId ?? this.doctorId,
      title: title ?? this.title,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isOnline: isOnline ?? this.isOnline,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (clinicDoctorId.present) {
      map['clinic_doctor_id'] = Variable<int>(clinicDoctorId.value);
    }
    if (doctorId.present) {
      map['doctor_id'] = Variable<int>(doctorId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (type.present) {
      final converter = $HabitsTable.$converter0;
      map['type'] = Variable<int>(converter.mapToSql(type.value));
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (isOnline.present) {
      map['is_online'] = Variable<bool>(isOnline.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HabitsCompanion(')
          ..write('id: $id, ')
          ..write('clinicDoctorId: $clinicDoctorId, ')
          ..write('doctorId: $doctorId, ')
          ..write('title: $title, ')
          ..write('type: $type, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isOnline: $isOnline')
          ..write(')'))
        .toString();
  }
}

class $HabitsTable extends Habits with TableInfo<$HabitsTable, Habit> {
  final GeneratedDatabase _db;
  final String _alias;
  $HabitsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _clinicDoctorIdMeta =
      const VerificationMeta('clinicDoctorId');
  GeneratedIntColumn _clinicDoctorId;
  @override
  GeneratedIntColumn get clinicDoctorId =>
      _clinicDoctorId ??= _constructClinicDoctorId();
  GeneratedIntColumn _constructClinicDoctorId() {
    return GeneratedIntColumn(
      'clinic_doctor_id',
      $tableName,
      true,
    );
  }

  final VerificationMeta _doctorIdMeta = const VerificationMeta('doctorId');
  GeneratedIntColumn _doctorId;
  @override
  GeneratedIntColumn get doctorId => _doctorId ??= _constructDoctorId();
  GeneratedIntColumn _constructDoctorId() {
    return GeneratedIntColumn(
      'doctor_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _titleMeta = const VerificationMeta('title');
  GeneratedTextColumn _title;
  @override
  GeneratedTextColumn get title => _title ??= _constructTitle();
  GeneratedTextColumn _constructTitle() {
    return GeneratedTextColumn(
      'title',
      $tableName,
      false,
    );
  }

  final VerificationMeta _typeMeta = const VerificationMeta('type');
  GeneratedIntColumn _type;
  @override
  GeneratedIntColumn get type => _type ??= _constructType();
  GeneratedIntColumn _constructType() {
    return GeneratedIntColumn(
      'type',
      $tableName,
      false,
    );
  }

  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  GeneratedDateTimeColumn _createdAt;
  @override
  GeneratedDateTimeColumn get createdAt => _createdAt ??= _constructCreatedAt();
  GeneratedDateTimeColumn _constructCreatedAt() {
    return GeneratedDateTimeColumn(
      'created_at',
      $tableName,
      true,
    );
  }

  final VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  GeneratedDateTimeColumn _updatedAt;
  @override
  GeneratedDateTimeColumn get updatedAt => _updatedAt ??= _constructUpdatedAt();
  GeneratedDateTimeColumn _constructUpdatedAt() {
    return GeneratedDateTimeColumn(
      'updated_at',
      $tableName,
      true,
    );
  }

  final VerificationMeta _isOnlineMeta = const VerificationMeta('isOnline');
  GeneratedBoolColumn _isOnline;
  @override
  GeneratedBoolColumn get isOnline => _isOnline ??= _constructIsOnline();
  GeneratedBoolColumn _constructIsOnline() {
    return GeneratedBoolColumn('is_online', $tableName, false,
        defaultValue: Constant(false));
  }

  @override
  List<GeneratedColumn> get $columns => [
        id,
        clinicDoctorId,
        doctorId,
        title,
        type,
        createdAt,
        updatedAt,
        isOnline
      ];
  @override
  $HabitsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'habits';
  @override
  final String actualTableName = 'habits';
  @override
  VerificationContext validateIntegrity(Insertable<Habit> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('clinic_doctor_id')) {
      context.handle(
          _clinicDoctorIdMeta,
          clinicDoctorId.isAcceptableOrUnknown(
              data['clinic_doctor_id'], _clinicDoctorIdMeta));
    }
    if (data.containsKey('doctor_id')) {
      context.handle(_doctorIdMeta,
          doctorId.isAcceptableOrUnknown(data['doctor_id'], _doctorIdMeta));
    } else if (isInserting) {
      context.missing(_doctorIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title'], _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    context.handle(_typeMeta, const VerificationResult.success());
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at'], _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at'], _updatedAtMeta));
    }
    if (data.containsKey('is_online')) {
      context.handle(_isOnlineMeta,
          isOnline.isAcceptableOrUnknown(data['is_online'], _isOnlineMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Habit map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Habit.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $HabitsTable createAlias(String alias) {
    return $HabitsTable(_db, alias);
  }

  static TypeConverter<HType, int> $converter0 =
      const EnumIndexConverter<HType>(HType.values);
}

abstract class _$HabitDB extends GeneratedDatabase {
  _$HabitDB(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $HabitsTable _habits;
  $HabitsTable get habits => _habits ??= $HabitsTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [habits];
}
