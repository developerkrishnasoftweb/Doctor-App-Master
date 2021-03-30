// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SymptomsTable.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Symptom extends DataClass implements Insertable<Symptom> {
  final int id;
  final int clinicDoctorId;
  final int doctorId;
  final String title;
  final Type type;
  final VisibilityPeriod visibilityPeriod;
  final DateTime createdAt;
  final bool isOnline;
  Symptom(
      {@required this.id,
      @required this.clinicDoctorId,
      @required this.doctorId,
      @required this.title,
      @required this.type,
      @required this.visibilityPeriod,
      this.createdAt,
      @required this.isOnline});
  factory Symptom.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    final boolType = db.typeSystem.forDartType<bool>();
    return Symptom(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      clinicDoctorId: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}clinic_doctor_id']),
      doctorId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}doctor_id']),
      title:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}title']),
      type: $SymptomsTable.$converter0.mapToDart(
          intType.mapFromDatabaseResponse(data['${effectivePrefix}type'])),
      visibilityPeriod: $SymptomsTable.$converter1.mapToDart(
          intType.mapFromDatabaseResponse(
              data['${effectivePrefix}visibility_period'])),
      createdAt: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at']),
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
      final converter = $SymptomsTable.$converter0;
      map['type'] = Variable<int>(converter.mapToSql(type));
    }
    if (!nullToAbsent || visibilityPeriod != null) {
      final converter = $SymptomsTable.$converter1;
      map['visibility_period'] =
          Variable<int>(converter.mapToSql(visibilityPeriod));
    }
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime>(createdAt);
    }
    if (!nullToAbsent || isOnline != null) {
      map['is_online'] = Variable<bool>(isOnline);
    }
    return map;
  }

  SymptomsCompanion toCompanion(bool nullToAbsent) {
    return SymptomsCompanion(
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
      visibilityPeriod: visibilityPeriod == null && nullToAbsent
          ? const Value.absent()
          : Value(visibilityPeriod),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      isOnline: isOnline == null && nullToAbsent
          ? const Value.absent()
          : Value(isOnline),
    );
  }

  factory Symptom.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Symptom(
      id: serializer.fromJson<int>(json['id']),
      clinicDoctorId: serializer.fromJson<int>(json['clinicDoctorId']),
      doctorId: serializer.fromJson<int>(json['doctorId']),
      title: serializer.fromJson<String>(json['title']),
      type: serializer.fromJson<Type>(json['type']),
      visibilityPeriod:
          serializer.fromJson<VisibilityPeriod>(json['visibilityPeriod']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
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
      'type': serializer.toJson<Type>(type),
      'visibilityPeriod': serializer.toJson<VisibilityPeriod>(visibilityPeriod),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'isOnline': serializer.toJson<bool>(isOnline),
    };
  }

  Symptom copyWith(
          {int id,
          int clinicDoctorId,
          int doctorId,
          String title,
          Type type,
          VisibilityPeriod visibilityPeriod,
          DateTime createdAt,
          bool isOnline}) =>
      Symptom(
        id: id ?? this.id,
        clinicDoctorId: clinicDoctorId ?? this.clinicDoctorId,
        doctorId: doctorId ?? this.doctorId,
        title: title ?? this.title,
        type: type ?? this.type,
        visibilityPeriod: visibilityPeriod ?? this.visibilityPeriod,
        createdAt: createdAt ?? this.createdAt,
        isOnline: isOnline ?? this.isOnline,
      );
  @override
  String toString() {
    return (StringBuffer('Symptom(')
          ..write('id: $id, ')
          ..write('clinicDoctorId: $clinicDoctorId, ')
          ..write('doctorId: $doctorId, ')
          ..write('title: $title, ')
          ..write('type: $type, ')
          ..write('visibilityPeriod: $visibilityPeriod, ')
          ..write('createdAt: $createdAt, ')
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
                      $mrjc(visibilityPeriod.hashCode,
                          $mrjc(createdAt.hashCode, isOnline.hashCode))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Symptom &&
          other.id == this.id &&
          other.clinicDoctorId == this.clinicDoctorId &&
          other.doctorId == this.doctorId &&
          other.title == this.title &&
          other.type == this.type &&
          other.visibilityPeriod == this.visibilityPeriod &&
          other.createdAt == this.createdAt &&
          other.isOnline == this.isOnline);
}

class SymptomsCompanion extends UpdateCompanion<Symptom> {
  final Value<int> id;
  final Value<int> clinicDoctorId;
  final Value<int> doctorId;
  final Value<String> title;
  final Value<Type> type;
  final Value<VisibilityPeriod> visibilityPeriod;
  final Value<DateTime> createdAt;
  final Value<bool> isOnline;
  const SymptomsCompanion({
    this.id = const Value.absent(),
    this.clinicDoctorId = const Value.absent(),
    this.doctorId = const Value.absent(),
    this.title = const Value.absent(),
    this.type = const Value.absent(),
    this.visibilityPeriod = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.isOnline = const Value.absent(),
  });
  SymptomsCompanion.insert({
    this.id = const Value.absent(),
    @required int clinicDoctorId,
    @required int doctorId,
    @required String title,
    @required Type type,
    @required VisibilityPeriod visibilityPeriod,
    this.createdAt = const Value.absent(),
    this.isOnline = const Value.absent(),
  })  : clinicDoctorId = Value(clinicDoctorId),
        doctorId = Value(doctorId),
        title = Value(title),
        type = Value(type),
        visibilityPeriod = Value(visibilityPeriod);
  static Insertable<Symptom> custom({
    Expression<int> id,
    Expression<int> clinicDoctorId,
    Expression<int> doctorId,
    Expression<String> title,
    Expression<int> type,
    Expression<int> visibilityPeriod,
    Expression<DateTime> createdAt,
    Expression<bool> isOnline,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (clinicDoctorId != null) 'clinic_doctor_id': clinicDoctorId,
      if (doctorId != null) 'doctor_id': doctorId,
      if (title != null) 'title': title,
      if (type != null) 'type': type,
      if (visibilityPeriod != null) 'visibility_period': visibilityPeriod,
      if (createdAt != null) 'created_at': createdAt,
      if (isOnline != null) 'is_online': isOnline,
    });
  }

  SymptomsCompanion copyWith(
      {Value<int> id,
      Value<int> clinicDoctorId,
      Value<int> doctorId,
      Value<String> title,
      Value<Type> type,
      Value<VisibilityPeriod> visibilityPeriod,
      Value<DateTime> createdAt,
      Value<bool> isOnline}) {
    return SymptomsCompanion(
      id: id ?? this.id,
      clinicDoctorId: clinicDoctorId ?? this.clinicDoctorId,
      doctorId: doctorId ?? this.doctorId,
      title: title ?? this.title,
      type: type ?? this.type,
      visibilityPeriod: visibilityPeriod ?? this.visibilityPeriod,
      createdAt: createdAt ?? this.createdAt,
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
      final converter = $SymptomsTable.$converter0;
      map['type'] = Variable<int>(converter.mapToSql(type.value));
    }
    if (visibilityPeriod.present) {
      final converter = $SymptomsTable.$converter1;
      map['visibility_period'] =
          Variable<int>(converter.mapToSql(visibilityPeriod.value));
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (isOnline.present) {
      map['is_online'] = Variable<bool>(isOnline.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SymptomsCompanion(')
          ..write('id: $id, ')
          ..write('clinicDoctorId: $clinicDoctorId, ')
          ..write('doctorId: $doctorId, ')
          ..write('title: $title, ')
          ..write('type: $type, ')
          ..write('visibilityPeriod: $visibilityPeriod, ')
          ..write('createdAt: $createdAt, ')
          ..write('isOnline: $isOnline')
          ..write(')'))
        .toString();
  }
}

class $SymptomsTable extends Symptoms with TableInfo<$SymptomsTable, Symptom> {
  final GeneratedDatabase _db;
  final String _alias;
  $SymptomsTable(this._db, [this._alias]);
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
      false,
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

  final VerificationMeta _visibilityPeriodMeta =
      const VerificationMeta('visibilityPeriod');
  GeneratedIntColumn _visibilityPeriod;
  @override
  GeneratedIntColumn get visibilityPeriod =>
      _visibilityPeriod ??= _constructVisibilityPeriod();
  GeneratedIntColumn _constructVisibilityPeriod() {
    return GeneratedIntColumn(
      'visibility_period',
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
        visibilityPeriod,
        createdAt,
        isOnline
      ];
  @override
  $SymptomsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'symptoms';
  @override
  final String actualTableName = 'symptoms';
  @override
  VerificationContext validateIntegrity(Insertable<Symptom> instance,
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
    } else if (isInserting) {
      context.missing(_clinicDoctorIdMeta);
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
    context.handle(_visibilityPeriodMeta, const VerificationResult.success());
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at'], _createdAtMeta));
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
  Symptom map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Symptom.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $SymptomsTable createAlias(String alias) {
    return $SymptomsTable(_db, alias);
  }

  static TypeConverter<Type, int> $converter0 =
      const EnumIndexConverter<Type>(Type.values);
  static TypeConverter<VisibilityPeriod, int> $converter1 =
      const EnumIndexConverter<VisibilityPeriod>(VisibilityPeriod.values);
}

abstract class _$SymptomsDB extends GeneratedDatabase {
  _$SymptomsDB(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $SymptomsTable _symptoms;
  $SymptomsTable get symptoms => _symptoms ??= $SymptomsTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [symptoms];
}
