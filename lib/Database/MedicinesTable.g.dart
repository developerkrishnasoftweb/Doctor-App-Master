// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MedicinesTable.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Medicine extends DataClass implements Insertable<Medicine> {
  final int id;
  final int clinicDoctorId;
  final int doctorId;
  final String title;
  final String defaultUnit;
  final String defaultRoute;
  final String defaultFrequency;
  final String defaultDirection;
  final String defaultDuration;
  final String salt;
  final InteractionDruggenerated interactionDrugs;
  final String category;
  final String defaultDose;
  final bool isOnline;
  Medicine(
      {@required this.id,
      @required this.clinicDoctorId,
      @required this.doctorId,
      @required this.title,
      @required this.defaultUnit,
      @required this.defaultRoute,
      @required this.defaultFrequency,
      @required this.defaultDirection,
      @required this.defaultDuration,
      @required this.salt,
      this.interactionDrugs,
      @required this.category,
      @required this.defaultDose,
      @required this.isOnline});
  factory Medicine.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final boolType = db.typeSystem.forDartType<bool>();
    return Medicine(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      clinicDoctorId: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}clinic_doctor_id']),
      doctorId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}doctor_id']),
      title:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}title']),
      defaultUnit: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}default_unit']),
      defaultRoute: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}default_route']),
      defaultFrequency: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}default_frequency']),
      defaultDirection: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}default_direction']),
      defaultDuration: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}default_duration']),
      salt: stringType.mapFromDatabaseResponse(data['${effectivePrefix}salt']),
      interactionDrugs: $MedicinesTable.$converter0.mapToDart(
          stringType.mapFromDatabaseResponse(
              data['${effectivePrefix}interaction_drugs'])),
      category: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}category']),
      defaultDose: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}default_dose']),
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
    if (!nullToAbsent || defaultUnit != null) {
      map['default_unit'] = Variable<String>(defaultUnit);
    }
    if (!nullToAbsent || defaultRoute != null) {
      map['default_route'] = Variable<String>(defaultRoute);
    }
    if (!nullToAbsent || defaultFrequency != null) {
      map['default_frequency'] = Variable<String>(defaultFrequency);
    }
    if (!nullToAbsent || defaultDirection != null) {
      map['default_direction'] = Variable<String>(defaultDirection);
    }
    if (!nullToAbsent || defaultDuration != null) {
      map['default_duration'] = Variable<String>(defaultDuration);
    }
    if (!nullToAbsent || salt != null) {
      map['salt'] = Variable<String>(salt);
    }
    if (!nullToAbsent || interactionDrugs != null) {
      final converter = $MedicinesTable.$converter0;
      map['interaction_drugs'] =
          Variable<String>(converter.mapToSql(interactionDrugs));
    }
    if (!nullToAbsent || category != null) {
      map['category'] = Variable<String>(category);
    }
    if (!nullToAbsent || defaultDose != null) {
      map['default_dose'] = Variable<String>(defaultDose);
    }
    if (!nullToAbsent || isOnline != null) {
      map['is_online'] = Variable<bool>(isOnline);
    }
    return map;
  }

  MedicinesCompanion toCompanion(bool nullToAbsent) {
    return MedicinesCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      clinicDoctorId: clinicDoctorId == null && nullToAbsent
          ? const Value.absent()
          : Value(clinicDoctorId),
      doctorId: doctorId == null && nullToAbsent
          ? const Value.absent()
          : Value(doctorId),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      defaultUnit: defaultUnit == null && nullToAbsent
          ? const Value.absent()
          : Value(defaultUnit),
      defaultRoute: defaultRoute == null && nullToAbsent
          ? const Value.absent()
          : Value(defaultRoute),
      defaultFrequency: defaultFrequency == null && nullToAbsent
          ? const Value.absent()
          : Value(defaultFrequency),
      defaultDirection: defaultDirection == null && nullToAbsent
          ? const Value.absent()
          : Value(defaultDirection),
      defaultDuration: defaultDuration == null && nullToAbsent
          ? const Value.absent()
          : Value(defaultDuration),
      salt: salt == null && nullToAbsent ? const Value.absent() : Value(salt),
      interactionDrugs: interactionDrugs == null && nullToAbsent
          ? const Value.absent()
          : Value(interactionDrugs),
      category: category == null && nullToAbsent
          ? const Value.absent()
          : Value(category),
      defaultDose: defaultDose == null && nullToAbsent
          ? const Value.absent()
          : Value(defaultDose),
      isOnline: isOnline == null && nullToAbsent
          ? const Value.absent()
          : Value(isOnline),
    );
  }

  factory Medicine.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Medicine(
      id: serializer.fromJson<int>(json['id']),
      clinicDoctorId: serializer.fromJson<int>(json['clinicDoctorId']),
      doctorId: serializer.fromJson<int>(json['doctorId']),
      title: serializer.fromJson<String>(json['title']),
      defaultUnit: serializer.fromJson<String>(json['defaultUnit']),
      defaultRoute: serializer.fromJson<String>(json['defaultRoute']),
      defaultFrequency: serializer.fromJson<String>(json['defaultFrequency']),
      defaultDirection: serializer.fromJson<String>(json['defaultDirection']),
      defaultDuration: serializer.fromJson<String>(json['defaultDuration']),
      salt: serializer.fromJson<String>(json['salt']),
      interactionDrugs: serializer
          .fromJson<InteractionDruggenerated>(json['interactionDrugs']),
      category: serializer.fromJson<String>(json['category']),
      defaultDose: serializer.fromJson<String>(json['defaultDose']),
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
      'defaultUnit': serializer.toJson<String>(defaultUnit),
      'defaultRoute': serializer.toJson<String>(defaultRoute),
      'defaultFrequency': serializer.toJson<String>(defaultFrequency),
      'defaultDirection': serializer.toJson<String>(defaultDirection),
      'defaultDuration': serializer.toJson<String>(defaultDuration),
      'salt': serializer.toJson<String>(salt),
      'interactionDrugs':
          serializer.toJson<InteractionDruggenerated>(interactionDrugs),
      'category': serializer.toJson<String>(category),
      'defaultDose': serializer.toJson<String>(defaultDose),
      'isOnline': serializer.toJson<bool>(isOnline),
    };
  }

  Medicine copyWith(
          {int id,
          int clinicDoctorId,
          int doctorId,
          String title,
          String defaultUnit,
          String defaultRoute,
          String defaultFrequency,
          String defaultDirection,
          String defaultDuration,
          String salt,
          InteractionDruggenerated interactionDrugs,
          String category,
          String defaultDose,
          bool isOnline}) =>
      Medicine(
        id: id ?? this.id,
        clinicDoctorId: clinicDoctorId ?? this.clinicDoctorId,
        doctorId: doctorId ?? this.doctorId,
        title: title ?? this.title,
        defaultUnit: defaultUnit ?? this.defaultUnit,
        defaultRoute: defaultRoute ?? this.defaultRoute,
        defaultFrequency: defaultFrequency ?? this.defaultFrequency,
        defaultDirection: defaultDirection ?? this.defaultDirection,
        defaultDuration: defaultDuration ?? this.defaultDuration,
        salt: salt ?? this.salt,
        interactionDrugs: interactionDrugs ?? this.interactionDrugs,
        category: category ?? this.category,
        defaultDose: defaultDose ?? this.defaultDose,
        isOnline: isOnline ?? this.isOnline,
      );
  @override
  String toString() {
    return (StringBuffer('Medicine(')
          ..write('id: $id, ')
          ..write('clinicDoctorId: $clinicDoctorId, ')
          ..write('doctorId: $doctorId, ')
          ..write('title: $title, ')
          ..write('defaultUnit: $defaultUnit, ')
          ..write('defaultRoute: $defaultRoute, ')
          ..write('defaultFrequency: $defaultFrequency, ')
          ..write('defaultDirection: $defaultDirection, ')
          ..write('defaultDuration: $defaultDuration, ')
          ..write('salt: $salt, ')
          ..write('interactionDrugs: $interactionDrugs, ')
          ..write('category: $category, ')
          ..write('defaultDose: $defaultDose, ')
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
                      defaultUnit.hashCode,
                      $mrjc(
                          defaultRoute.hashCode,
                          $mrjc(
                              defaultFrequency.hashCode,
                              $mrjc(
                                  defaultDirection.hashCode,
                                  $mrjc(
                                      defaultDuration.hashCode,
                                      $mrjc(
                                          salt.hashCode,
                                          $mrjc(
                                              interactionDrugs.hashCode,
                                              $mrjc(
                                                  category.hashCode,
                                                  $mrjc(
                                                      defaultDose.hashCode,
                                                      isOnline
                                                          .hashCode))))))))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Medicine &&
          other.id == this.id &&
          other.clinicDoctorId == this.clinicDoctorId &&
          other.doctorId == this.doctorId &&
          other.title == this.title &&
          other.defaultUnit == this.defaultUnit &&
          other.defaultRoute == this.defaultRoute &&
          other.defaultFrequency == this.defaultFrequency &&
          other.defaultDirection == this.defaultDirection &&
          other.defaultDuration == this.defaultDuration &&
          other.salt == this.salt &&
          other.interactionDrugs == this.interactionDrugs &&
          other.category == this.category &&
          other.defaultDose == this.defaultDose &&
          other.isOnline == this.isOnline);
}

class MedicinesCompanion extends UpdateCompanion<Medicine> {
  final Value<int> id;
  final Value<int> clinicDoctorId;
  final Value<int> doctorId;
  final Value<String> title;
  final Value<String> defaultUnit;
  final Value<String> defaultRoute;
  final Value<String> defaultFrequency;
  final Value<String> defaultDirection;
  final Value<String> defaultDuration;
  final Value<String> salt;
  final Value<InteractionDruggenerated> interactionDrugs;
  final Value<String> category;
  final Value<String> defaultDose;
  final Value<bool> isOnline;
  const MedicinesCompanion({
    this.id = const Value.absent(),
    this.clinicDoctorId = const Value.absent(),
    this.doctorId = const Value.absent(),
    this.title = const Value.absent(),
    this.defaultUnit = const Value.absent(),
    this.defaultRoute = const Value.absent(),
    this.defaultFrequency = const Value.absent(),
    this.defaultDirection = const Value.absent(),
    this.defaultDuration = const Value.absent(),
    this.salt = const Value.absent(),
    this.interactionDrugs = const Value.absent(),
    this.category = const Value.absent(),
    this.defaultDose = const Value.absent(),
    this.isOnline = const Value.absent(),
  });
  MedicinesCompanion.insert({
    this.id = const Value.absent(),
    @required int clinicDoctorId,
    @required int doctorId,
    @required String title,
    @required String defaultUnit,
    @required String defaultRoute,
    @required String defaultFrequency,
    @required String defaultDirection,
    @required String defaultDuration,
    @required String salt,
    this.interactionDrugs = const Value.absent(),
    @required String category,
    @required String defaultDose,
    this.isOnline = const Value.absent(),
  })  : clinicDoctorId = Value(clinicDoctorId),
        doctorId = Value(doctorId),
        title = Value(title),
        defaultUnit = Value(defaultUnit),
        defaultRoute = Value(defaultRoute),
        defaultFrequency = Value(defaultFrequency),
        defaultDirection = Value(defaultDirection),
        defaultDuration = Value(defaultDuration),
        salt = Value(salt),
        category = Value(category),
        defaultDose = Value(defaultDose);
  static Insertable<Medicine> custom({
    Expression<int> id,
    Expression<int> clinicDoctorId,
    Expression<int> doctorId,
    Expression<String> title,
    Expression<String> defaultUnit,
    Expression<String> defaultRoute,
    Expression<String> defaultFrequency,
    Expression<String> defaultDirection,
    Expression<String> defaultDuration,
    Expression<String> salt,
    Expression<String> interactionDrugs,
    Expression<String> category,
    Expression<String> defaultDose,
    Expression<bool> isOnline,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (clinicDoctorId != null) 'clinic_doctor_id': clinicDoctorId,
      if (doctorId != null) 'doctor_id': doctorId,
      if (title != null) 'title': title,
      if (defaultUnit != null) 'default_unit': defaultUnit,
      if (defaultRoute != null) 'default_route': defaultRoute,
      if (defaultFrequency != null) 'default_frequency': defaultFrequency,
      if (defaultDirection != null) 'default_direction': defaultDirection,
      if (defaultDuration != null) 'default_duration': defaultDuration,
      if (salt != null) 'salt': salt,
      if (interactionDrugs != null) 'interaction_drugs': interactionDrugs,
      if (category != null) 'category': category,
      if (defaultDose != null) 'default_dose': defaultDose,
      if (isOnline != null) 'is_online': isOnline,
    });
  }

  MedicinesCompanion copyWith(
      {Value<int> id,
      Value<int> clinicDoctorId,
      Value<int> doctorId,
      Value<String> title,
      Value<String> defaultUnit,
      Value<String> defaultRoute,
      Value<String> defaultFrequency,
      Value<String> defaultDirection,
      Value<String> defaultDuration,
      Value<String> salt,
      Value<InteractionDruggenerated> interactionDrugs,
      Value<String> category,
      Value<String> defaultDose,
      Value<bool> isOnline}) {
    return MedicinesCompanion(
      id: id ?? this.id,
      clinicDoctorId: clinicDoctorId ?? this.clinicDoctorId,
      doctorId: doctorId ?? this.doctorId,
      title: title ?? this.title,
      defaultUnit: defaultUnit ?? this.defaultUnit,
      defaultRoute: defaultRoute ?? this.defaultRoute,
      defaultFrequency: defaultFrequency ?? this.defaultFrequency,
      defaultDirection: defaultDirection ?? this.defaultDirection,
      defaultDuration: defaultDuration ?? this.defaultDuration,
      salt: salt ?? this.salt,
      interactionDrugs: interactionDrugs ?? this.interactionDrugs,
      category: category ?? this.category,
      defaultDose: defaultDose ?? this.defaultDose,
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
    if (defaultUnit.present) {
      map['default_unit'] = Variable<String>(defaultUnit.value);
    }
    if (defaultRoute.present) {
      map['default_route'] = Variable<String>(defaultRoute.value);
    }
    if (defaultFrequency.present) {
      map['default_frequency'] = Variable<String>(defaultFrequency.value);
    }
    if (defaultDirection.present) {
      map['default_direction'] = Variable<String>(defaultDirection.value);
    }
    if (defaultDuration.present) {
      map['default_duration'] = Variable<String>(defaultDuration.value);
    }
    if (salt.present) {
      map['salt'] = Variable<String>(salt.value);
    }
    if (interactionDrugs.present) {
      final converter = $MedicinesTable.$converter0;
      map['interaction_drugs'] =
          Variable<String>(converter.mapToSql(interactionDrugs.value));
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (defaultDose.present) {
      map['default_dose'] = Variable<String>(defaultDose.value);
    }
    if (isOnline.present) {
      map['is_online'] = Variable<bool>(isOnline.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MedicinesCompanion(')
          ..write('id: $id, ')
          ..write('clinicDoctorId: $clinicDoctorId, ')
          ..write('doctorId: $doctorId, ')
          ..write('title: $title, ')
          ..write('defaultUnit: $defaultUnit, ')
          ..write('defaultRoute: $defaultRoute, ')
          ..write('defaultFrequency: $defaultFrequency, ')
          ..write('defaultDirection: $defaultDirection, ')
          ..write('defaultDuration: $defaultDuration, ')
          ..write('salt: $salt, ')
          ..write('interactionDrugs: $interactionDrugs, ')
          ..write('category: $category, ')
          ..write('defaultDose: $defaultDose, ')
          ..write('isOnline: $isOnline')
          ..write(')'))
        .toString();
  }
}

class $MedicinesTable extends Medicines
    with TableInfo<$MedicinesTable, Medicine> {
  final GeneratedDatabase _db;
  final String _alias;
  $MedicinesTable(this._db, [this._alias]);
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

  final VerificationMeta _defaultUnitMeta =
      const VerificationMeta('defaultUnit');
  GeneratedTextColumn _defaultUnit;
  @override
  GeneratedTextColumn get defaultUnit =>
      _defaultUnit ??= _constructDefaultUnit();
  GeneratedTextColumn _constructDefaultUnit() {
    return GeneratedTextColumn(
      'default_unit',
      $tableName,
      false,
    );
  }

  final VerificationMeta _defaultRouteMeta =
      const VerificationMeta('defaultRoute');
  GeneratedTextColumn _defaultRoute;
  @override
  GeneratedTextColumn get defaultRoute =>
      _defaultRoute ??= _constructDefaultRoute();
  GeneratedTextColumn _constructDefaultRoute() {
    return GeneratedTextColumn(
      'default_route',
      $tableName,
      false,
    );
  }

  final VerificationMeta _defaultFrequencyMeta =
      const VerificationMeta('defaultFrequency');
  GeneratedTextColumn _defaultFrequency;
  @override
  GeneratedTextColumn get defaultFrequency =>
      _defaultFrequency ??= _constructDefaultFrequency();
  GeneratedTextColumn _constructDefaultFrequency() {
    return GeneratedTextColumn(
      'default_frequency',
      $tableName,
      false,
    );
  }

  final VerificationMeta _defaultDirectionMeta =
      const VerificationMeta('defaultDirection');
  GeneratedTextColumn _defaultDirection;
  @override
  GeneratedTextColumn get defaultDirection =>
      _defaultDirection ??= _constructDefaultDirection();
  GeneratedTextColumn _constructDefaultDirection() {
    return GeneratedTextColumn(
      'default_direction',
      $tableName,
      false,
    );
  }

  final VerificationMeta _defaultDurationMeta =
      const VerificationMeta('defaultDuration');
  GeneratedTextColumn _defaultDuration;
  @override
  GeneratedTextColumn get defaultDuration =>
      _defaultDuration ??= _constructDefaultDuration();
  GeneratedTextColumn _constructDefaultDuration() {
    return GeneratedTextColumn(
      'default_duration',
      $tableName,
      false,
    );
  }

  final VerificationMeta _saltMeta = const VerificationMeta('salt');
  GeneratedTextColumn _salt;
  @override
  GeneratedTextColumn get salt => _salt ??= _constructSalt();
  GeneratedTextColumn _constructSalt() {
    return GeneratedTextColumn(
      'salt',
      $tableName,
      false,
    );
  }

  final VerificationMeta _interactionDrugsMeta =
      const VerificationMeta('interactionDrugs');
  GeneratedTextColumn _interactionDrugs;
  @override
  GeneratedTextColumn get interactionDrugs =>
      _interactionDrugs ??= _constructInteractionDrugs();
  GeneratedTextColumn _constructInteractionDrugs() {
    return GeneratedTextColumn(
      'interaction_drugs',
      $tableName,
      true,
    );
  }

  final VerificationMeta _categoryMeta = const VerificationMeta('category');
  GeneratedTextColumn _category;
  @override
  GeneratedTextColumn get category => _category ??= _constructCategory();
  GeneratedTextColumn _constructCategory() {
    return GeneratedTextColumn(
      'category',
      $tableName,
      false,
    );
  }

  final VerificationMeta _defaultDoseMeta =
      const VerificationMeta('defaultDose');
  GeneratedTextColumn _defaultDose;
  @override
  GeneratedTextColumn get defaultDose =>
      _defaultDose ??= _constructDefaultDose();
  GeneratedTextColumn _constructDefaultDose() {
    return GeneratedTextColumn(
      'default_dose',
      $tableName,
      false,
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
        defaultUnit,
        defaultRoute,
        defaultFrequency,
        defaultDirection,
        defaultDuration,
        salt,
        interactionDrugs,
        category,
        defaultDose,
        isOnline
      ];
  @override
  $MedicinesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'medicines';
  @override
  final String actualTableName = 'medicines';
  @override
  VerificationContext validateIntegrity(Insertable<Medicine> instance,
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
    if (data.containsKey('default_unit')) {
      context.handle(
          _defaultUnitMeta,
          defaultUnit.isAcceptableOrUnknown(
              data['default_unit'], _defaultUnitMeta));
    } else if (isInserting) {
      context.missing(_defaultUnitMeta);
    }
    if (data.containsKey('default_route')) {
      context.handle(
          _defaultRouteMeta,
          defaultRoute.isAcceptableOrUnknown(
              data['default_route'], _defaultRouteMeta));
    } else if (isInserting) {
      context.missing(_defaultRouteMeta);
    }
    if (data.containsKey('default_frequency')) {
      context.handle(
          _defaultFrequencyMeta,
          defaultFrequency.isAcceptableOrUnknown(
              data['default_frequency'], _defaultFrequencyMeta));
    } else if (isInserting) {
      context.missing(_defaultFrequencyMeta);
    }
    if (data.containsKey('default_direction')) {
      context.handle(
          _defaultDirectionMeta,
          defaultDirection.isAcceptableOrUnknown(
              data['default_direction'], _defaultDirectionMeta));
    } else if (isInserting) {
      context.missing(_defaultDirectionMeta);
    }
    if (data.containsKey('default_duration')) {
      context.handle(
          _defaultDurationMeta,
          defaultDuration.isAcceptableOrUnknown(
              data['default_duration'], _defaultDurationMeta));
    } else if (isInserting) {
      context.missing(_defaultDurationMeta);
    }
    if (data.containsKey('salt')) {
      context.handle(
          _saltMeta, salt.isAcceptableOrUnknown(data['salt'], _saltMeta));
    } else if (isInserting) {
      context.missing(_saltMeta);
    }
    context.handle(_interactionDrugsMeta, const VerificationResult.success());
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category'], _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('default_dose')) {
      context.handle(
          _defaultDoseMeta,
          defaultDose.isAcceptableOrUnknown(
              data['default_dose'], _defaultDoseMeta));
    } else if (isInserting) {
      context.missing(_defaultDoseMeta);
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
  Medicine map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Medicine.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $MedicinesTable createAlias(String alias) {
    return $MedicinesTable(_db, alias);
  }

  static TypeConverter<InteractionDruggenerated, String> $converter0 =
      const InteractionDrugConverter();
}

abstract class _$MedicinesDB extends GeneratedDatabase {
  _$MedicinesDB(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $MedicinesTable _medicines;
  $MedicinesTable get medicines => _medicines ??= $MedicinesTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [medicines];
}
