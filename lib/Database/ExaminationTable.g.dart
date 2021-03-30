// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ExaminationTable.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Examination extends DataClass implements Insertable<Examination> {
  final int id;
  final int clinicDoctorId;
  final int doctorId;
  final String title;
  final Parameters2 parameters;
  final int price;
  final bool isOnline;
  Examination(
      {@required this.id,
      @required this.clinicDoctorId,
      @required this.doctorId,
      @required this.title,
      this.parameters,
      @required this.price,
      @required this.isOnline});
  factory Examination.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final boolType = db.typeSystem.forDartType<bool>();
    return Examination(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      clinicDoctorId: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}clinic_doctor_id']),
      doctorId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}doctor_id']),
      title:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}title']),
      parameters: $ExaminationsTable.$converter0.mapToDart(stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}parameters'])),
      price: intType.mapFromDatabaseResponse(data['${effectivePrefix}price']),
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
    if (!nullToAbsent || parameters != null) {
      final converter = $ExaminationsTable.$converter0;
      map['parameters'] = Variable<String>(converter.mapToSql(parameters));
    }
    if (!nullToAbsent || price != null) {
      map['price'] = Variable<int>(price);
    }
    if (!nullToAbsent || isOnline != null) {
      map['is_online'] = Variable<bool>(isOnline);
    }
    return map;
  }

  ExaminationsCompanion toCompanion(bool nullToAbsent) {
    return ExaminationsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      clinicDoctorId: clinicDoctorId == null && nullToAbsent
          ? const Value.absent()
          : Value(clinicDoctorId),
      doctorId: doctorId == null && nullToAbsent
          ? const Value.absent()
          : Value(doctorId),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      parameters: parameters == null && nullToAbsent
          ? const Value.absent()
          : Value(parameters),
      price:
          price == null && nullToAbsent ? const Value.absent() : Value(price),
      isOnline: isOnline == null && nullToAbsent
          ? const Value.absent()
          : Value(isOnline),
    );
  }

  factory Examination.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Examination(
      id: serializer.fromJson<int>(json['id']),
      clinicDoctorId: serializer.fromJson<int>(json['clinicDoctorId']),
      doctorId: serializer.fromJson<int>(json['doctorId']),
      title: serializer.fromJson<String>(json['title']),
      parameters: serializer.fromJson<Parameters2>(json['parameters']),
      price: serializer.fromJson<int>(json['price']),
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
      'parameters': serializer.toJson<Parameters2>(parameters),
      'price': serializer.toJson<int>(price),
      'isOnline': serializer.toJson<bool>(isOnline),
    };
  }

  Examination copyWith(
          {int id,
          int clinicDoctorId,
          int doctorId,
          String title,
          Parameters2 parameters,
          int price,
          bool isOnline}) =>
      Examination(
        id: id ?? this.id,
        clinicDoctorId: clinicDoctorId ?? this.clinicDoctorId,
        doctorId: doctorId ?? this.doctorId,
        title: title ?? this.title,
        parameters: parameters ?? this.parameters,
        price: price ?? this.price,
        isOnline: isOnline ?? this.isOnline,
      );
  @override
  String toString() {
    return (StringBuffer('Examination(')
          ..write('id: $id, ')
          ..write('clinicDoctorId: $clinicDoctorId, ')
          ..write('doctorId: $doctorId, ')
          ..write('title: $title, ')
          ..write('parameters: $parameters, ')
          ..write('price: $price, ')
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
                  $mrjc(parameters.hashCode,
                      $mrjc(price.hashCode, isOnline.hashCode)))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Examination &&
          other.id == this.id &&
          other.clinicDoctorId == this.clinicDoctorId &&
          other.doctorId == this.doctorId &&
          other.title == this.title &&
          other.parameters == this.parameters &&
          other.price == this.price &&
          other.isOnline == this.isOnline);
}

class ExaminationsCompanion extends UpdateCompanion<Examination> {
  final Value<int> id;
  final Value<int> clinicDoctorId;
  final Value<int> doctorId;
  final Value<String> title;
  final Value<Parameters2> parameters;
  final Value<int> price;
  final Value<bool> isOnline;
  const ExaminationsCompanion({
    this.id = const Value.absent(),
    this.clinicDoctorId = const Value.absent(),
    this.doctorId = const Value.absent(),
    this.title = const Value.absent(),
    this.parameters = const Value.absent(),
    this.price = const Value.absent(),
    this.isOnline = const Value.absent(),
  });
  ExaminationsCompanion.insert({
    this.id = const Value.absent(),
    @required int clinicDoctorId,
    @required int doctorId,
    @required String title,
    this.parameters = const Value.absent(),
    @required int price,
    this.isOnline = const Value.absent(),
  })  : clinicDoctorId = Value(clinicDoctorId),
        doctorId = Value(doctorId),
        title = Value(title),
        price = Value(price);
  static Insertable<Examination> custom({
    Expression<int> id,
    Expression<int> clinicDoctorId,
    Expression<int> doctorId,
    Expression<String> title,
    Expression<String> parameters,
    Expression<int> price,
    Expression<bool> isOnline,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (clinicDoctorId != null) 'clinic_doctor_id': clinicDoctorId,
      if (doctorId != null) 'doctor_id': doctorId,
      if (title != null) 'title': title,
      if (parameters != null) 'parameters': parameters,
      if (price != null) 'price': price,
      if (isOnline != null) 'is_online': isOnline,
    });
  }

  ExaminationsCompanion copyWith(
      {Value<int> id,
      Value<int> clinicDoctorId,
      Value<int> doctorId,
      Value<String> title,
      Value<Parameters2> parameters,
      Value<int> price,
      Value<bool> isOnline}) {
    return ExaminationsCompanion(
      id: id ?? this.id,
      clinicDoctorId: clinicDoctorId ?? this.clinicDoctorId,
      doctorId: doctorId ?? this.doctorId,
      title: title ?? this.title,
      parameters: parameters ?? this.parameters,
      price: price ?? this.price,
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
    if (parameters.present) {
      final converter = $ExaminationsTable.$converter0;
      map['parameters'] =
          Variable<String>(converter.mapToSql(parameters.value));
    }
    if (price.present) {
      map['price'] = Variable<int>(price.value);
    }
    if (isOnline.present) {
      map['is_online'] = Variable<bool>(isOnline.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExaminationsCompanion(')
          ..write('id: $id, ')
          ..write('clinicDoctorId: $clinicDoctorId, ')
          ..write('doctorId: $doctorId, ')
          ..write('title: $title, ')
          ..write('parameters: $parameters, ')
          ..write('price: $price, ')
          ..write('isOnline: $isOnline')
          ..write(')'))
        .toString();
  }
}

class $ExaminationsTable extends Examinations
    with TableInfo<$ExaminationsTable, Examination> {
  final GeneratedDatabase _db;
  final String _alias;
  $ExaminationsTable(this._db, [this._alias]);
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

  final VerificationMeta _parametersMeta = const VerificationMeta('parameters');
  GeneratedTextColumn _parameters;
  @override
  GeneratedTextColumn get parameters => _parameters ??= _constructParameters();
  GeneratedTextColumn _constructParameters() {
    return GeneratedTextColumn(
      'parameters',
      $tableName,
      true,
    );
  }

  final VerificationMeta _priceMeta = const VerificationMeta('price');
  GeneratedIntColumn _price;
  @override
  GeneratedIntColumn get price => _price ??= _constructPrice();
  GeneratedIntColumn _constructPrice() {
    return GeneratedIntColumn(
      'price',
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
  List<GeneratedColumn> get $columns =>
      [id, clinicDoctorId, doctorId, title, parameters, price, isOnline];
  @override
  $ExaminationsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'examinations';
  @override
  final String actualTableName = 'examinations';
  @override
  VerificationContext validateIntegrity(Insertable<Examination> instance,
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
    context.handle(_parametersMeta, const VerificationResult.success());
    if (data.containsKey('price')) {
      context.handle(
          _priceMeta, price.isAcceptableOrUnknown(data['price'], _priceMeta));
    } else if (isInserting) {
      context.missing(_priceMeta);
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
  Examination map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Examination.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $ExaminationsTable createAlias(String alias) {
    return $ExaminationsTable(_db, alias);
  }

  static TypeConverter<Parameters2, String> $converter0 =
      const ParametersConverter();
}

abstract class _$ExaminationsDB extends GeneratedDatabase {
  _$ExaminationsDB(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $ExaminationsTable _examinations;
  $ExaminationsTable get examinations =>
      _examinations ??= $ExaminationsTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [examinations];
}
