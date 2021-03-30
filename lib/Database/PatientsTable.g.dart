// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PatientsTable.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Patient extends DataClass implements Insertable<Patient> {
  final int id;
  final int mobileNo;
  final int age;
  final String name;
  final Gender gender;
  final String address;
  final String patientId;
  final int clinicDoctorId;
  final bool isOnline;
  Patient(
      {@required this.id,
      @required this.mobileNo,
      this.age,
      @required this.name,
      @required this.gender,
      this.address,
      @required this.patientId,
      this.clinicDoctorId,
      @required this.isOnline});
  factory Patient.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final boolType = db.typeSystem.forDartType<bool>();
    return Patient(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      mobileNo:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}mobile_no']),
      age: intType.mapFromDatabaseResponse(data['${effectivePrefix}age']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      gender: $PatientsTable.$converter0.mapToDart(
          intType.mapFromDatabaseResponse(data['${effectivePrefix}gender'])),
      address:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}address']),
      patientId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}patient_id']),
      clinicDoctorId: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}clinic_doctor_id']),
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
    if (!nullToAbsent || mobileNo != null) {
      map['mobile_no'] = Variable<int>(mobileNo);
    }
    if (!nullToAbsent || age != null) {
      map['age'] = Variable<int>(age);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || gender != null) {
      final converter = $PatientsTable.$converter0;
      map['gender'] = Variable<int>(converter.mapToSql(gender));
    }
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(address);
    }
    if (!nullToAbsent || patientId != null) {
      map['patient_id'] = Variable<String>(patientId);
    }
    if (!nullToAbsent || clinicDoctorId != null) {
      map['clinic_doctor_id'] = Variable<int>(clinicDoctorId);
    }
    if (!nullToAbsent || isOnline != null) {
      map['is_online'] = Variable<bool>(isOnline);
    }
    return map;
  }

  PatientsCompanion toCompanion(bool nullToAbsent) {
    return PatientsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      mobileNo: mobileNo == null && nullToAbsent
          ? const Value.absent()
          : Value(mobileNo),
      age: age == null && nullToAbsent ? const Value.absent() : Value(age),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      gender:
          gender == null && nullToAbsent ? const Value.absent() : Value(gender),
      address: address == null && nullToAbsent
          ? const Value.absent()
          : Value(address),
      patientId: patientId == null && nullToAbsent
          ? const Value.absent()
          : Value(patientId),
      clinicDoctorId: clinicDoctorId == null && nullToAbsent
          ? const Value.absent()
          : Value(clinicDoctorId),
      isOnline: isOnline == null && nullToAbsent
          ? const Value.absent()
          : Value(isOnline),
    );
  }

  factory Patient.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Patient(
      id: serializer.fromJson<int>(json['id']),
      mobileNo: serializer.fromJson<int>(json['mobileNo']),
      age: serializer.fromJson<int>(json['age']),
      name: serializer.fromJson<String>(json['name']),
      gender: serializer.fromJson<Gender>(json['gender']),
      address: serializer.fromJson<String>(json['address']),
      patientId: serializer.fromJson<String>(json['patientId']),
      clinicDoctorId: serializer.fromJson<int>(json['clinicDoctorId']),
      isOnline: serializer.fromJson<bool>(json['isOnline']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'mobileNo': serializer.toJson<int>(mobileNo),
      'age': serializer.toJson<int>(age),
      'name': serializer.toJson<String>(name),
      'gender': serializer.toJson<Gender>(gender),
      'address': serializer.toJson<String>(address),
      'patientId': serializer.toJson<String>(patientId),
      'clinicDoctorId': serializer.toJson<int>(clinicDoctorId),
      'isOnline': serializer.toJson<bool>(isOnline),
    };
  }

  Patient copyWith(
          {int id,
          int mobileNo,
          int age,
          String name,
          Gender gender,
          String address,
          String patientId,
          int clinicDoctorId,
          bool isOnline}) =>
      Patient(
        id: id ?? this.id,
        mobileNo: mobileNo ?? this.mobileNo,
        age: age ?? this.age,
        name: name ?? this.name,
        gender: gender ?? this.gender,
        address: address ?? this.address,
        patientId: patientId ?? this.patientId,
        clinicDoctorId: clinicDoctorId ?? this.clinicDoctorId,
        isOnline: isOnline ?? this.isOnline,
      );
  @override
  String toString() {
    return (StringBuffer('Patient(')
          ..write('id: $id, ')
          ..write('mobileNo: $mobileNo, ')
          ..write('age: $age, ')
          ..write('name: $name, ')
          ..write('gender: $gender, ')
          ..write('address: $address, ')
          ..write('patientId: $patientId, ')
          ..write('clinicDoctorId: $clinicDoctorId, ')
          ..write('isOnline: $isOnline')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          mobileNo.hashCode,
          $mrjc(
              age.hashCode,
              $mrjc(
                  name.hashCode,
                  $mrjc(
                      gender.hashCode,
                      $mrjc(
                          address.hashCode,
                          $mrjc(
                              patientId.hashCode,
                              $mrjc(clinicDoctorId.hashCode,
                                  isOnline.hashCode)))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Patient &&
          other.id == this.id &&
          other.mobileNo == this.mobileNo &&
          other.age == this.age &&
          other.name == this.name &&
          other.gender == this.gender &&
          other.address == this.address &&
          other.patientId == this.patientId &&
          other.clinicDoctorId == this.clinicDoctorId &&
          other.isOnline == this.isOnline);
}

class PatientsCompanion extends UpdateCompanion<Patient> {
  final Value<int> id;
  final Value<int> mobileNo;
  final Value<int> age;
  final Value<String> name;
  final Value<Gender> gender;
  final Value<String> address;
  final Value<String> patientId;
  final Value<int> clinicDoctorId;
  final Value<bool> isOnline;
  const PatientsCompanion({
    this.id = const Value.absent(),
    this.mobileNo = const Value.absent(),
    this.age = const Value.absent(),
    this.name = const Value.absent(),
    this.gender = const Value.absent(),
    this.address = const Value.absent(),
    this.patientId = const Value.absent(),
    this.clinicDoctorId = const Value.absent(),
    this.isOnline = const Value.absent(),
  });
  PatientsCompanion.insert({
    this.id = const Value.absent(),
    @required int mobileNo,
    this.age = const Value.absent(),
    @required String name,
    @required Gender gender,
    this.address = const Value.absent(),
    @required String patientId,
    this.clinicDoctorId = const Value.absent(),
    this.isOnline = const Value.absent(),
  })  : mobileNo = Value(mobileNo),
        name = Value(name),
        gender = Value(gender),
        patientId = Value(patientId);
  static Insertable<Patient> custom({
    Expression<int> id,
    Expression<int> mobileNo,
    Expression<int> age,
    Expression<String> name,
    Expression<int> gender,
    Expression<String> address,
    Expression<String> patientId,
    Expression<int> clinicDoctorId,
    Expression<bool> isOnline,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (mobileNo != null) 'mobile_no': mobileNo,
      if (age != null) 'age': age,
      if (name != null) 'name': name,
      if (gender != null) 'gender': gender,
      if (address != null) 'address': address,
      if (patientId != null) 'patient_id': patientId,
      if (clinicDoctorId != null) 'clinic_doctor_id': clinicDoctorId,
      if (isOnline != null) 'is_online': isOnline,
    });
  }

  PatientsCompanion copyWith(
      {Value<int> id,
      Value<int> mobileNo,
      Value<int> age,
      Value<String> name,
      Value<Gender> gender,
      Value<String> address,
      Value<String> patientId,
      Value<int> clinicDoctorId,
      Value<bool> isOnline}) {
    return PatientsCompanion(
      id: id ?? this.id,
      mobileNo: mobileNo ?? this.mobileNo,
      age: age ?? this.age,
      name: name ?? this.name,
      gender: gender ?? this.gender,
      address: address ?? this.address,
      patientId: patientId ?? this.patientId,
      clinicDoctorId: clinicDoctorId ?? this.clinicDoctorId,
      isOnline: isOnline ?? this.isOnline,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (mobileNo.present) {
      map['mobile_no'] = Variable<int>(mobileNo.value);
    }
    if (age.present) {
      map['age'] = Variable<int>(age.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (gender.present) {
      final converter = $PatientsTable.$converter0;
      map['gender'] = Variable<int>(converter.mapToSql(gender.value));
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (patientId.present) {
      map['patient_id'] = Variable<String>(patientId.value);
    }
    if (clinicDoctorId.present) {
      map['clinic_doctor_id'] = Variable<int>(clinicDoctorId.value);
    }
    if (isOnline.present) {
      map['is_online'] = Variable<bool>(isOnline.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PatientsCompanion(')
          ..write('id: $id, ')
          ..write('mobileNo: $mobileNo, ')
          ..write('age: $age, ')
          ..write('name: $name, ')
          ..write('gender: $gender, ')
          ..write('address: $address, ')
          ..write('patientId: $patientId, ')
          ..write('clinicDoctorId: $clinicDoctorId, ')
          ..write('isOnline: $isOnline')
          ..write(')'))
        .toString();
  }
}

class $PatientsTable extends Patients with TableInfo<$PatientsTable, Patient> {
  final GeneratedDatabase _db;
  final String _alias;
  $PatientsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _mobileNoMeta = const VerificationMeta('mobileNo');
  GeneratedIntColumn _mobileNo;
  @override
  GeneratedIntColumn get mobileNo => _mobileNo ??= _constructMobileNo();
  GeneratedIntColumn _constructMobileNo() {
    return GeneratedIntColumn(
      'mobile_no',
      $tableName,
      false,
    );
  }

  final VerificationMeta _ageMeta = const VerificationMeta('age');
  GeneratedIntColumn _age;
  @override
  GeneratedIntColumn get age => _age ??= _constructAge();
  GeneratedIntColumn _constructAge() {
    return GeneratedIntColumn(
      'age',
      $tableName,
      true,
    );
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _genderMeta = const VerificationMeta('gender');
  GeneratedIntColumn _gender;
  @override
  GeneratedIntColumn get gender => _gender ??= _constructGender();
  GeneratedIntColumn _constructGender() {
    return GeneratedIntColumn(
      'gender',
      $tableName,
      false,
    );
  }

  final VerificationMeta _addressMeta = const VerificationMeta('address');
  GeneratedTextColumn _address;
  @override
  GeneratedTextColumn get address => _address ??= _constructAddress();
  GeneratedTextColumn _constructAddress() {
    return GeneratedTextColumn(
      'address',
      $tableName,
      true,
    );
  }

  final VerificationMeta _patientIdMeta = const VerificationMeta('patientId');
  GeneratedTextColumn _patientId;
  @override
  GeneratedTextColumn get patientId => _patientId ??= _constructPatientId();
  GeneratedTextColumn _constructPatientId() {
    return GeneratedTextColumn(
      'patient_id',
      $tableName,
      false,
    );
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
        mobileNo,
        age,
        name,
        gender,
        address,
        patientId,
        clinicDoctorId,
        isOnline
      ];
  @override
  $PatientsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'patients';
  @override
  final String actualTableName = 'patients';
  @override
  VerificationContext validateIntegrity(Insertable<Patient> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('mobile_no')) {
      context.handle(_mobileNoMeta,
          mobileNo.isAcceptableOrUnknown(data['mobile_no'], _mobileNoMeta));
    } else if (isInserting) {
      context.missing(_mobileNoMeta);
    }
    if (data.containsKey('age')) {
      context.handle(
          _ageMeta, age.isAcceptableOrUnknown(data['age'], _ageMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    context.handle(_genderMeta, const VerificationResult.success());
    if (data.containsKey('address')) {
      context.handle(_addressMeta,
          address.isAcceptableOrUnknown(data['address'], _addressMeta));
    }
    if (data.containsKey('patient_id')) {
      context.handle(_patientIdMeta,
          patientId.isAcceptableOrUnknown(data['patient_id'], _patientIdMeta));
    } else if (isInserting) {
      context.missing(_patientIdMeta);
    }
    if (data.containsKey('clinic_doctor_id')) {
      context.handle(
          _clinicDoctorIdMeta,
          clinicDoctorId.isAcceptableOrUnknown(
              data['clinic_doctor_id'], _clinicDoctorIdMeta));
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
  Patient map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Patient.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $PatientsTable createAlias(String alias) {
    return $PatientsTable(_db, alias);
  }

  static TypeConverter<Gender, int> $converter0 =
      const EnumIndexConverter<Gender>(Gender.values);
}

abstract class _$PatientsDB extends GeneratedDatabase {
  _$PatientsDB(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $PatientsTable _patients;
  $PatientsTable get patients => _patients ??= $PatientsTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [patients];
}
