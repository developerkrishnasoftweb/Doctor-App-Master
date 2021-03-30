// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Recommendation.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class RecommendationData extends DataClass
    implements Insertable<RecommendationData> {
  final int id;
  final int clinicDoctorId;
  final int doctorId;
  final String disease;
  final int totalCount;
  final int cured;
  final int partiallyCured;
  final int notCured;
  final Medicinesgenerated medicines;
  final int symptomsIncreased;
  final DateTime createdAt;
  final bool isOnline;
  RecommendationData(
      {@required this.id,
      @required this.clinicDoctorId,
      @required this.doctorId,
      @required this.disease,
      @required this.totalCount,
      @required this.cured,
      @required this.partiallyCured,
      @required this.notCured,
      this.medicines,
      @required this.symptomsIncreased,
      this.createdAt,
      @required this.isOnline});
  factory RecommendationData.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    final boolType = db.typeSystem.forDartType<bool>();
    return RecommendationData(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      clinicDoctorId: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}clinic_doctor_id']),
      doctorId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}doctor_id']),
      disease:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}disease']),
      totalCount: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}total_count']),
      cured: intType.mapFromDatabaseResponse(data['${effectivePrefix}cured']),
      partiallyCured: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}partially_cured']),
      notCured:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}not_cured']),
      medicines: $RecommendationTable.$converter0.mapToDart(stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}medicines'])),
      symptomsIncreased: intType.mapFromDatabaseResponse(
          data['${effectivePrefix}symptoms_increased']),
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
    if (!nullToAbsent || disease != null) {
      map['disease'] = Variable<String>(disease);
    }
    if (!nullToAbsent || totalCount != null) {
      map['total_count'] = Variable<int>(totalCount);
    }
    if (!nullToAbsent || cured != null) {
      map['cured'] = Variable<int>(cured);
    }
    if (!nullToAbsent || partiallyCured != null) {
      map['partially_cured'] = Variable<int>(partiallyCured);
    }
    if (!nullToAbsent || notCured != null) {
      map['not_cured'] = Variable<int>(notCured);
    }
    if (!nullToAbsent || medicines != null) {
      final converter = $RecommendationTable.$converter0;
      map['medicines'] = Variable<String>(converter.mapToSql(medicines));
    }
    if (!nullToAbsent || symptomsIncreased != null) {
      map['symptoms_increased'] = Variable<int>(symptomsIncreased);
    }
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime>(createdAt);
    }
    if (!nullToAbsent || isOnline != null) {
      map['is_online'] = Variable<bool>(isOnline);
    }
    return map;
  }

  RecommendationCompanion toCompanion(bool nullToAbsent) {
    return RecommendationCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      clinicDoctorId: clinicDoctorId == null && nullToAbsent
          ? const Value.absent()
          : Value(clinicDoctorId),
      doctorId: doctorId == null && nullToAbsent
          ? const Value.absent()
          : Value(doctorId),
      disease: disease == null && nullToAbsent
          ? const Value.absent()
          : Value(disease),
      totalCount: totalCount == null && nullToAbsent
          ? const Value.absent()
          : Value(totalCount),
      cured:
          cured == null && nullToAbsent ? const Value.absent() : Value(cured),
      partiallyCured: partiallyCured == null && nullToAbsent
          ? const Value.absent()
          : Value(partiallyCured),
      notCured: notCured == null && nullToAbsent
          ? const Value.absent()
          : Value(notCured),
      medicines: medicines == null && nullToAbsent
          ? const Value.absent()
          : Value(medicines),
      symptomsIncreased: symptomsIncreased == null && nullToAbsent
          ? const Value.absent()
          : Value(symptomsIncreased),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      isOnline: isOnline == null && nullToAbsent
          ? const Value.absent()
          : Value(isOnline),
    );
  }

  factory RecommendationData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return RecommendationData(
      id: serializer.fromJson<int>(json['id']),
      clinicDoctorId: serializer.fromJson<int>(json['clinicDoctorId']),
      doctorId: serializer.fromJson<int>(json['doctorId']),
      disease: serializer.fromJson<String>(json['disease']),
      totalCount: serializer.fromJson<int>(json['totalCount']),
      cured: serializer.fromJson<int>(json['cured']),
      partiallyCured: serializer.fromJson<int>(json['partiallyCured']),
      notCured: serializer.fromJson<int>(json['notCured']),
      medicines: serializer.fromJson<Medicinesgenerated>(json['medicines']),
      symptomsIncreased: serializer.fromJson<int>(json['symptomsIncreased']),
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
      'disease': serializer.toJson<String>(disease),
      'totalCount': serializer.toJson<int>(totalCount),
      'cured': serializer.toJson<int>(cured),
      'partiallyCured': serializer.toJson<int>(partiallyCured),
      'notCured': serializer.toJson<int>(notCured),
      'medicines': serializer.toJson<Medicinesgenerated>(medicines),
      'symptomsIncreased': serializer.toJson<int>(symptomsIncreased),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'isOnline': serializer.toJson<bool>(isOnline),
    };
  }

  RecommendationData copyWith(
          {int id,
          int clinicDoctorId,
          int doctorId,
          String disease,
          int totalCount,
          int cured,
          int partiallyCured,
          int notCured,
          Medicinesgenerated medicines,
          int symptomsIncreased,
          DateTime createdAt,
          bool isOnline}) =>
      RecommendationData(
        id: id ?? this.id,
        clinicDoctorId: clinicDoctorId ?? this.clinicDoctorId,
        doctorId: doctorId ?? this.doctorId,
        disease: disease ?? this.disease,
        totalCount: totalCount ?? this.totalCount,
        cured: cured ?? this.cured,
        partiallyCured: partiallyCured ?? this.partiallyCured,
        notCured: notCured ?? this.notCured,
        medicines: medicines ?? this.medicines,
        symptomsIncreased: symptomsIncreased ?? this.symptomsIncreased,
        createdAt: createdAt ?? this.createdAt,
        isOnline: isOnline ?? this.isOnline,
      );
  @override
  String toString() {
    return (StringBuffer('RecommendationData(')
          ..write('id: $id, ')
          ..write('clinicDoctorId: $clinicDoctorId, ')
          ..write('doctorId: $doctorId, ')
          ..write('disease: $disease, ')
          ..write('totalCount: $totalCount, ')
          ..write('cured: $cured, ')
          ..write('partiallyCured: $partiallyCured, ')
          ..write('notCured: $notCured, ')
          ..write('medicines: $medicines, ')
          ..write('symptomsIncreased: $symptomsIncreased, ')
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
                  disease.hashCode,
                  $mrjc(
                      totalCount.hashCode,
                      $mrjc(
                          cured.hashCode,
                          $mrjc(
                              partiallyCured.hashCode,
                              $mrjc(
                                  notCured.hashCode,
                                  $mrjc(
                                      medicines.hashCode,
                                      $mrjc(
                                          symptomsIncreased.hashCode,
                                          $mrjc(createdAt.hashCode,
                                              isOnline.hashCode))))))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is RecommendationData &&
          other.id == this.id &&
          other.clinicDoctorId == this.clinicDoctorId &&
          other.doctorId == this.doctorId &&
          other.disease == this.disease &&
          other.totalCount == this.totalCount &&
          other.cured == this.cured &&
          other.partiallyCured == this.partiallyCured &&
          other.notCured == this.notCured &&
          other.medicines == this.medicines &&
          other.symptomsIncreased == this.symptomsIncreased &&
          other.createdAt == this.createdAt &&
          other.isOnline == this.isOnline);
}

class RecommendationCompanion extends UpdateCompanion<RecommendationData> {
  final Value<int> id;
  final Value<int> clinicDoctorId;
  final Value<int> doctorId;
  final Value<String> disease;
  final Value<int> totalCount;
  final Value<int> cured;
  final Value<int> partiallyCured;
  final Value<int> notCured;
  final Value<Medicinesgenerated> medicines;
  final Value<int> symptomsIncreased;
  final Value<DateTime> createdAt;
  final Value<bool> isOnline;
  const RecommendationCompanion({
    this.id = const Value.absent(),
    this.clinicDoctorId = const Value.absent(),
    this.doctorId = const Value.absent(),
    this.disease = const Value.absent(),
    this.totalCount = const Value.absent(),
    this.cured = const Value.absent(),
    this.partiallyCured = const Value.absent(),
    this.notCured = const Value.absent(),
    this.medicines = const Value.absent(),
    this.symptomsIncreased = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.isOnline = const Value.absent(),
  });
  RecommendationCompanion.insert({
    this.id = const Value.absent(),
    @required int clinicDoctorId,
    @required int doctorId,
    @required String disease,
    this.totalCount = const Value.absent(),
    this.cured = const Value.absent(),
    this.partiallyCured = const Value.absent(),
    this.notCured = const Value.absent(),
    this.medicines = const Value.absent(),
    this.symptomsIncreased = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.isOnline = const Value.absent(),
  })  : clinicDoctorId = Value(clinicDoctorId),
        doctorId = Value(doctorId),
        disease = Value(disease);
  static Insertable<RecommendationData> custom({
    Expression<int> id,
    Expression<int> clinicDoctorId,
    Expression<int> doctorId,
    Expression<String> disease,
    Expression<int> totalCount,
    Expression<int> cured,
    Expression<int> partiallyCured,
    Expression<int> notCured,
    Expression<String> medicines,
    Expression<int> symptomsIncreased,
    Expression<DateTime> createdAt,
    Expression<bool> isOnline,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (clinicDoctorId != null) 'clinic_doctor_id': clinicDoctorId,
      if (doctorId != null) 'doctor_id': doctorId,
      if (disease != null) 'disease': disease,
      if (totalCount != null) 'total_count': totalCount,
      if (cured != null) 'cured': cured,
      if (partiallyCured != null) 'partially_cured': partiallyCured,
      if (notCured != null) 'not_cured': notCured,
      if (medicines != null) 'medicines': medicines,
      if (symptomsIncreased != null) 'symptoms_increased': symptomsIncreased,
      if (createdAt != null) 'created_at': createdAt,
      if (isOnline != null) 'is_online': isOnline,
    });
  }

  RecommendationCompanion copyWith(
      {Value<int> id,
      Value<int> clinicDoctorId,
      Value<int> doctorId,
      Value<String> disease,
      Value<int> totalCount,
      Value<int> cured,
      Value<int> partiallyCured,
      Value<int> notCured,
      Value<Medicinesgenerated> medicines,
      Value<int> symptomsIncreased,
      Value<DateTime> createdAt,
      Value<bool> isOnline}) {
    return RecommendationCompanion(
      id: id ?? this.id,
      clinicDoctorId: clinicDoctorId ?? this.clinicDoctorId,
      doctorId: doctorId ?? this.doctorId,
      disease: disease ?? this.disease,
      totalCount: totalCount ?? this.totalCount,
      cured: cured ?? this.cured,
      partiallyCured: partiallyCured ?? this.partiallyCured,
      notCured: notCured ?? this.notCured,
      medicines: medicines ?? this.medicines,
      symptomsIncreased: symptomsIncreased ?? this.symptomsIncreased,
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
    if (disease.present) {
      map['disease'] = Variable<String>(disease.value);
    }
    if (totalCount.present) {
      map['total_count'] = Variable<int>(totalCount.value);
    }
    if (cured.present) {
      map['cured'] = Variable<int>(cured.value);
    }
    if (partiallyCured.present) {
      map['partially_cured'] = Variable<int>(partiallyCured.value);
    }
    if (notCured.present) {
      map['not_cured'] = Variable<int>(notCured.value);
    }
    if (medicines.present) {
      final converter = $RecommendationTable.$converter0;
      map['medicines'] = Variable<String>(converter.mapToSql(medicines.value));
    }
    if (symptomsIncreased.present) {
      map['symptoms_increased'] = Variable<int>(symptomsIncreased.value);
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
    return (StringBuffer('RecommendationCompanion(')
          ..write('id: $id, ')
          ..write('clinicDoctorId: $clinicDoctorId, ')
          ..write('doctorId: $doctorId, ')
          ..write('disease: $disease, ')
          ..write('totalCount: $totalCount, ')
          ..write('cured: $cured, ')
          ..write('partiallyCured: $partiallyCured, ')
          ..write('notCured: $notCured, ')
          ..write('medicines: $medicines, ')
          ..write('symptomsIncreased: $symptomsIncreased, ')
          ..write('createdAt: $createdAt, ')
          ..write('isOnline: $isOnline')
          ..write(')'))
        .toString();
  }
}

class $RecommendationTable extends Recommendation
    with TableInfo<$RecommendationTable, RecommendationData> {
  final GeneratedDatabase _db;
  final String _alias;
  $RecommendationTable(this._db, [this._alias]);
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

  final VerificationMeta _diseaseMeta = const VerificationMeta('disease');
  GeneratedTextColumn _disease;
  @override
  GeneratedTextColumn get disease => _disease ??= _constructDisease();
  GeneratedTextColumn _constructDisease() {
    return GeneratedTextColumn(
      'disease',
      $tableName,
      false,
    );
  }

  final VerificationMeta _totalCountMeta = const VerificationMeta('totalCount');
  GeneratedIntColumn _totalCount;
  @override
  GeneratedIntColumn get totalCount => _totalCount ??= _constructTotalCount();
  GeneratedIntColumn _constructTotalCount() {
    return GeneratedIntColumn('total_count', $tableName, false,
        defaultValue: Constant(0));
  }

  final VerificationMeta _curedMeta = const VerificationMeta('cured');
  GeneratedIntColumn _cured;
  @override
  GeneratedIntColumn get cured => _cured ??= _constructCured();
  GeneratedIntColumn _constructCured() {
    return GeneratedIntColumn('cured', $tableName, false,
        defaultValue: Constant(0));
  }

  final VerificationMeta _partiallyCuredMeta =
      const VerificationMeta('partiallyCured');
  GeneratedIntColumn _partiallyCured;
  @override
  GeneratedIntColumn get partiallyCured =>
      _partiallyCured ??= _constructPartiallyCured();
  GeneratedIntColumn _constructPartiallyCured() {
    return GeneratedIntColumn('partially_cured', $tableName, false,
        defaultValue: Constant(0));
  }

  final VerificationMeta _notCuredMeta = const VerificationMeta('notCured');
  GeneratedIntColumn _notCured;
  @override
  GeneratedIntColumn get notCured => _notCured ??= _constructNotCured();
  GeneratedIntColumn _constructNotCured() {
    return GeneratedIntColumn('not_cured', $tableName, false,
        defaultValue: Constant(0));
  }

  final VerificationMeta _medicinesMeta = const VerificationMeta('medicines');
  GeneratedTextColumn _medicines;
  @override
  GeneratedTextColumn get medicines => _medicines ??= _constructMedicines();
  GeneratedTextColumn _constructMedicines() {
    return GeneratedTextColumn(
      'medicines',
      $tableName,
      true,
    );
  }

  final VerificationMeta _symptomsIncreasedMeta =
      const VerificationMeta('symptomsIncreased');
  GeneratedIntColumn _symptomsIncreased;
  @override
  GeneratedIntColumn get symptomsIncreased =>
      _symptomsIncreased ??= _constructSymptomsIncreased();
  GeneratedIntColumn _constructSymptomsIncreased() {
    return GeneratedIntColumn('symptoms_increased', $tableName, false,
        defaultValue: Constant(0));
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
        disease,
        totalCount,
        cured,
        partiallyCured,
        notCured,
        medicines,
        symptomsIncreased,
        createdAt,
        isOnline
      ];
  @override
  $RecommendationTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'recommendation';
  @override
  final String actualTableName = 'recommendation';
  @override
  VerificationContext validateIntegrity(Insertable<RecommendationData> instance,
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
    if (data.containsKey('disease')) {
      context.handle(_diseaseMeta,
          disease.isAcceptableOrUnknown(data['disease'], _diseaseMeta));
    } else if (isInserting) {
      context.missing(_diseaseMeta);
    }
    if (data.containsKey('total_count')) {
      context.handle(
          _totalCountMeta,
          totalCount.isAcceptableOrUnknown(
              data['total_count'], _totalCountMeta));
    }
    if (data.containsKey('cured')) {
      context.handle(
          _curedMeta, cured.isAcceptableOrUnknown(data['cured'], _curedMeta));
    }
    if (data.containsKey('partially_cured')) {
      context.handle(
          _partiallyCuredMeta,
          partiallyCured.isAcceptableOrUnknown(
              data['partially_cured'], _partiallyCuredMeta));
    }
    if (data.containsKey('not_cured')) {
      context.handle(_notCuredMeta,
          notCured.isAcceptableOrUnknown(data['not_cured'], _notCuredMeta));
    }
    context.handle(_medicinesMeta, const VerificationResult.success());
    if (data.containsKey('symptoms_increased')) {
      context.handle(
          _symptomsIncreasedMeta,
          symptomsIncreased.isAcceptableOrUnknown(
              data['symptoms_increased'], _symptomsIncreasedMeta));
    }
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
  RecommendationData map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return RecommendationData.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $RecommendationTable createAlias(String alias) {
    return $RecommendationTable(_db, alias);
  }

  static TypeConverter<Medicinesgenerated, String> $converter0 =
      const MedicinesConverter();
}

abstract class _$RecommendationDB extends GeneratedDatabase {
  _$RecommendationDB(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $RecommendationTable _recommendation;
  $RecommendationTable get recommendation =>
      _recommendation ??= $RecommendationTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [recommendation];
}
