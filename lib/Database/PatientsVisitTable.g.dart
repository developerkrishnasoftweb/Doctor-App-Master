// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PatientsVisitTable.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class PatientsVisitData extends DataClass
    implements Insertable<PatientsVisitData> {
  final int id;
  final String appointmentId;
  final int mobileNo;
  final int age;
  final String patientName;
  final String temperature;
  final String bp;
  final String pulse;
  final String weight;
  final int fee;
  final String patientId;
  final int clinicDoctorId;
  final String appointmentType;
  final String visitType;
  final String bookingType;
  final String bookedBy;
  final String bookedVia;
  final DateTime appointmentsTime;
  final DateTime presentTime;
  final bool completed;
  final bool isDoctorFeedBack;
  final bool isPatientFeedBack;
  final BriefHistorygenerated briefHistory;
  final VisitReasongenerated visitReason;
  final Examinationgenerated examination;
  final Dignosisgenerated diagnosis;
  final Medicationgenerated medication;
  final Medicationgenerated feedBack;
  final Allergy allergies;
  final LifeStyle lifestyle;
  final bool isOnline;
  PatientsVisitData(
      {@required this.id,
      this.appointmentId,
      @required this.mobileNo,
      this.age,
      @required this.patientName,
      @required this.temperature,
      @required this.bp,
      @required this.pulse,
      @required this.weight,
      @required this.fee,
      @required this.patientId,
      this.clinicDoctorId,
      this.appointmentType,
      this.visitType,
      this.bookingType,
      this.bookedBy,
      this.bookedVia,
      this.appointmentsTime,
      this.presentTime,
      @required this.completed,
      @required this.isDoctorFeedBack,
      @required this.isPatientFeedBack,
      this.briefHistory,
      this.visitReason,
      this.examination,
      this.diagnosis,
      this.medication,
      this.feedBack,
      this.allergies,
      this.lifestyle,
      @required this.isOnline});
  factory PatientsVisitData.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    final boolType = db.typeSystem.forDartType<bool>();
    return PatientsVisitData(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      appointmentId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}appointment_id']),
      mobileNo:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}mobile_no']),
      age: intType.mapFromDatabaseResponse(data['${effectivePrefix}age']),
      patientName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}patient_name']),
      temperature: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}temperature']),
      bp: stringType.mapFromDatabaseResponse(data['${effectivePrefix}bp']),
      pulse:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}pulse']),
      weight:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}weight']),
      fee: intType.mapFromDatabaseResponse(data['${effectivePrefix}fee']),
      patientId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}patient_id']),
      clinicDoctorId: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}clinic_doctor_id']),
      appointmentType: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}appointment_type']),
      visitType: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}visit_type']),
      bookingType: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}booking_type']),
      bookedBy: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}booked_by']),
      bookedVia: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}booked_via']),
      appointmentsTime: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}appointments_time']),
      presentTime: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}present_time']),
      completed:
          boolType.mapFromDatabaseResponse(data['${effectivePrefix}completed']),
      isDoctorFeedBack: boolType.mapFromDatabaseResponse(
          data['${effectivePrefix}is_doctor_feed_back']),
      isPatientFeedBack: boolType.mapFromDatabaseResponse(
          data['${effectivePrefix}is_patient_feed_back']),
      briefHistory: $PatientsVisitTable.$converter0.mapToDart(stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}brief_history'])),
      visitReason: $PatientsVisitTable.$converter1.mapToDart(stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}visit_reason'])),
      examination: $PatientsVisitTable.$converter2.mapToDart(stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}examination'])),
      diagnosis: $PatientsVisitTable.$converter3.mapToDart(stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}diagnosis'])),
      medication: $PatientsVisitTable.$converter4.mapToDart(stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}medication'])),
      feedBack: $PatientsVisitTable.$converter5.mapToDart(stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}feed_back'])),
      allergies: $PatientsVisitTable.$converter6.mapToDart(stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}allergies'])),
      lifestyle: $PatientsVisitTable.$converter7.mapToDart(stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}lifestyle'])),
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
    if (!nullToAbsent || appointmentId != null) {
      map['appointment_id'] = Variable<String>(appointmentId);
    }
    if (!nullToAbsent || mobileNo != null) {
      map['mobile_no'] = Variable<int>(mobileNo);
    }
    if (!nullToAbsent || age != null) {
      map['age'] = Variable<int>(age);
    }
    if (!nullToAbsent || patientName != null) {
      map['patient_name'] = Variable<String>(patientName);
    }
    if (!nullToAbsent || temperature != null) {
      map['temperature'] = Variable<String>(temperature);
    }
    if (!nullToAbsent || bp != null) {
      map['bp'] = Variable<String>(bp);
    }
    if (!nullToAbsent || pulse != null) {
      map['pulse'] = Variable<String>(pulse);
    }
    if (!nullToAbsent || weight != null) {
      map['weight'] = Variable<String>(weight);
    }
    if (!nullToAbsent || fee != null) {
      map['fee'] = Variable<int>(fee);
    }
    if (!nullToAbsent || patientId != null) {
      map['patient_id'] = Variable<String>(patientId);
    }
    if (!nullToAbsent || clinicDoctorId != null) {
      map['clinic_doctor_id'] = Variable<int>(clinicDoctorId);
    }
    if (!nullToAbsent || appointmentType != null) {
      map['appointment_type'] = Variable<String>(appointmentType);
    }
    if (!nullToAbsent || visitType != null) {
      map['visit_type'] = Variable<String>(visitType);
    }
    if (!nullToAbsent || bookingType != null) {
      map['booking_type'] = Variable<String>(bookingType);
    }
    if (!nullToAbsent || bookedBy != null) {
      map['booked_by'] = Variable<String>(bookedBy);
    }
    if (!nullToAbsent || bookedVia != null) {
      map['booked_via'] = Variable<String>(bookedVia);
    }
    if (!nullToAbsent || appointmentsTime != null) {
      map['appointments_time'] = Variable<DateTime>(appointmentsTime);
    }
    if (!nullToAbsent || presentTime != null) {
      map['present_time'] = Variable<DateTime>(presentTime);
    }
    if (!nullToAbsent || completed != null) {
      map['completed'] = Variable<bool>(completed);
    }
    if (!nullToAbsent || isDoctorFeedBack != null) {
      map['is_doctor_feed_back'] = Variable<bool>(isDoctorFeedBack);
    }
    if (!nullToAbsent || isPatientFeedBack != null) {
      map['is_patient_feed_back'] = Variable<bool>(isPatientFeedBack);
    }
    if (!nullToAbsent || briefHistory != null) {
      final converter = $PatientsVisitTable.$converter0;
      map['brief_history'] = Variable<String>(converter.mapToSql(briefHistory));
    }
    if (!nullToAbsent || visitReason != null) {
      final converter = $PatientsVisitTable.$converter1;
      map['visit_reason'] = Variable<String>(converter.mapToSql(visitReason));
    }
    if (!nullToAbsent || examination != null) {
      final converter = $PatientsVisitTable.$converter2;
      map['examination'] = Variable<String>(converter.mapToSql(examination));
    }
    if (!nullToAbsent || diagnosis != null) {
      final converter = $PatientsVisitTable.$converter3;
      map['diagnosis'] = Variable<String>(converter.mapToSql(diagnosis));
    }
    if (!nullToAbsent || medication != null) {
      final converter = $PatientsVisitTable.$converter4;
      map['medication'] = Variable<String>(converter.mapToSql(medication));
    }
    if (!nullToAbsent || feedBack != null) {
      final converter = $PatientsVisitTable.$converter5;
      map['feed_back'] = Variable<String>(converter.mapToSql(feedBack));
    }
    if (!nullToAbsent || allergies != null) {
      final converter = $PatientsVisitTable.$converter6;
      map['allergies'] = Variable<String>(converter.mapToSql(allergies));
    }
    if (!nullToAbsent || lifestyle != null) {
      final converter = $PatientsVisitTable.$converter7;
      map['lifestyle'] = Variable<String>(converter.mapToSql(lifestyle));
    }
    if (!nullToAbsent || isOnline != null) {
      map['is_online'] = Variable<bool>(isOnline);
    }
    return map;
  }

  PatientsVisitCompanion toCompanion(bool nullToAbsent) {
    return PatientsVisitCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      appointmentId: appointmentId == null && nullToAbsent
          ? const Value.absent()
          : Value(appointmentId),
      mobileNo: mobileNo == null && nullToAbsent
          ? const Value.absent()
          : Value(mobileNo),
      age: age == null && nullToAbsent ? const Value.absent() : Value(age),
      patientName: patientName == null && nullToAbsent
          ? const Value.absent()
          : Value(patientName),
      temperature: temperature == null && nullToAbsent
          ? const Value.absent()
          : Value(temperature),
      bp: bp == null && nullToAbsent ? const Value.absent() : Value(bp),
      pulse:
          pulse == null && nullToAbsent ? const Value.absent() : Value(pulse),
      weight:
          weight == null && nullToAbsent ? const Value.absent() : Value(weight),
      fee: fee == null && nullToAbsent ? const Value.absent() : Value(fee),
      patientId: patientId == null && nullToAbsent
          ? const Value.absent()
          : Value(patientId),
      clinicDoctorId: clinicDoctorId == null && nullToAbsent
          ? const Value.absent()
          : Value(clinicDoctorId),
      appointmentType: appointmentType == null && nullToAbsent
          ? const Value.absent()
          : Value(appointmentType),
      visitType: visitType == null && nullToAbsent
          ? const Value.absent()
          : Value(visitType),
      bookingType: bookingType == null && nullToAbsent
          ? const Value.absent()
          : Value(bookingType),
      bookedBy: bookedBy == null && nullToAbsent
          ? const Value.absent()
          : Value(bookedBy),
      bookedVia: bookedVia == null && nullToAbsent
          ? const Value.absent()
          : Value(bookedVia),
      appointmentsTime: appointmentsTime == null && nullToAbsent
          ? const Value.absent()
          : Value(appointmentsTime),
      presentTime: presentTime == null && nullToAbsent
          ? const Value.absent()
          : Value(presentTime),
      completed: completed == null && nullToAbsent
          ? const Value.absent()
          : Value(completed),
      isDoctorFeedBack: isDoctorFeedBack == null && nullToAbsent
          ? const Value.absent()
          : Value(isDoctorFeedBack),
      isPatientFeedBack: isPatientFeedBack == null && nullToAbsent
          ? const Value.absent()
          : Value(isPatientFeedBack),
      briefHistory: briefHistory == null && nullToAbsent
          ? const Value.absent()
          : Value(briefHistory),
      visitReason: visitReason == null && nullToAbsent
          ? const Value.absent()
          : Value(visitReason),
      examination: examination == null && nullToAbsent
          ? const Value.absent()
          : Value(examination),
      diagnosis: diagnosis == null && nullToAbsent
          ? const Value.absent()
          : Value(diagnosis),
      medication: medication == null && nullToAbsent
          ? const Value.absent()
          : Value(medication),
      feedBack: feedBack == null && nullToAbsent
          ? const Value.absent()
          : Value(feedBack),
      allergies: allergies == null && nullToAbsent
          ? const Value.absent()
          : Value(allergies),
      lifestyle: lifestyle == null && nullToAbsent
          ? const Value.absent()
          : Value(lifestyle),
      isOnline: isOnline == null && nullToAbsent
          ? const Value.absent()
          : Value(isOnline),
    );
  }

  factory PatientsVisitData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return PatientsVisitData(
      id: serializer.fromJson<int>(json['id']),
      appointmentId: serializer.fromJson<String>(json['appointmentId']),
      mobileNo: serializer.fromJson<int>(json['mobileNo']),
      age: serializer.fromJson<int>(json['age']),
      patientName: serializer.fromJson<String>(json['patientName']),
      temperature: serializer.fromJson<String>(json['temperature']),
      bp: serializer.fromJson<String>(json['bp']),
      pulse: serializer.fromJson<String>(json['pulse']),
      weight: serializer.fromJson<String>(json['weight']),
      fee: serializer.fromJson<int>(json['fee']),
      patientId: serializer.fromJson<String>(json['patientId']),
      clinicDoctorId: serializer.fromJson<int>(json['clinicDoctorId']),
      appointmentType: serializer.fromJson<String>(json['appointmentType']),
      visitType: serializer.fromJson<String>(json['visitType']),
      bookingType: serializer.fromJson<String>(json['bookingType']),
      bookedBy: serializer.fromJson<String>(json['bookedBy']),
      bookedVia: serializer.fromJson<String>(json['bookedVia']),
      appointmentsTime: serializer.fromJson<DateTime>(json['appointmentsTime']),
      presentTime: serializer.fromJson<DateTime>(json['presentTime']),
      completed: serializer.fromJson<bool>(json['completed']),
      isDoctorFeedBack: serializer.fromJson<bool>(json['isDoctorFeedBack']),
      isPatientFeedBack: serializer.fromJson<bool>(json['isPatientFeedBack']),
      briefHistory:
          serializer.fromJson<BriefHistorygenerated>(json['briefHistory']),
      visitReason:
          serializer.fromJson<VisitReasongenerated>(json['visitReason']),
      examination:
          serializer.fromJson<Examinationgenerated>(json['examination']),
      diagnosis: serializer.fromJson<Dignosisgenerated>(json['diagnosis']),
      medication: serializer.fromJson<Medicationgenerated>(json['medication']),
      feedBack: serializer.fromJson<Medicationgenerated>(json['feedBack']),
      allergies: serializer.fromJson<Allergy>(json['allergies']),
      lifestyle: serializer.fromJson<LifeStyle>(json['lifestyle']),
      isOnline: serializer.fromJson<bool>(json['isOnline']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'appointmentId': serializer.toJson<String>(appointmentId),
      'mobileNo': serializer.toJson<int>(mobileNo),
      'age': serializer.toJson<int>(age),
      'patientName': serializer.toJson<String>(patientName),
      'temperature': serializer.toJson<String>(temperature),
      'bp': serializer.toJson<String>(bp),
      'pulse': serializer.toJson<String>(pulse),
      'weight': serializer.toJson<String>(weight),
      'fee': serializer.toJson<int>(fee),
      'patientId': serializer.toJson<String>(patientId),
      'clinicDoctorId': serializer.toJson<int>(clinicDoctorId),
      'appointmentType': serializer.toJson<String>(appointmentType),
      'visitType': serializer.toJson<String>(visitType),
      'bookingType': serializer.toJson<String>(bookingType),
      'bookedBy': serializer.toJson<String>(bookedBy),
      'bookedVia': serializer.toJson<String>(bookedVia),
      'appointmentsTime': serializer.toJson<DateTime>(appointmentsTime),
      'presentTime': serializer.toJson<DateTime>(presentTime),
      'completed': serializer.toJson<bool>(completed),
      'isDoctorFeedBack': serializer.toJson<bool>(isDoctorFeedBack),
      'isPatientFeedBack': serializer.toJson<bool>(isPatientFeedBack),
      'briefHistory': serializer.toJson<BriefHistorygenerated>(briefHistory),
      'visitReason': serializer.toJson<VisitReasongenerated>(visitReason),
      'examination': serializer.toJson<Examinationgenerated>(examination),
      'diagnosis': serializer.toJson<Dignosisgenerated>(diagnosis),
      'medication': serializer.toJson<Medicationgenerated>(medication),
      'feedBack': serializer.toJson<Medicationgenerated>(feedBack),
      'allergies': serializer.toJson<Allergy>(allergies),
      'lifestyle': serializer.toJson<LifeStyle>(lifestyle),
      'isOnline': serializer.toJson<bool>(isOnline),
    };
  }

  PatientsVisitData copyWith(
          {int id,
          String appointmentId,
          int mobileNo,
          int age,
          String patientName,
          String temperature,
          String bp,
          String pulse,
          String weight,
          int fee,
          String patientId,
          int clinicDoctorId,
          String appointmentType,
          String visitType,
          String bookingType,
          String bookedBy,
          String bookedVia,
          DateTime appointmentsTime,
          DateTime presentTime,
          bool completed,
          bool isDoctorFeedBack,
          bool isPatientFeedBack,
          BriefHistorygenerated briefHistory,
          VisitReasongenerated visitReason,
          Examinationgenerated examination,
          Dignosisgenerated diagnosis,
          Medicationgenerated medication,
          Medicationgenerated feedBack,
          Allergy allergies,
          LifeStyle lifestyle,
          bool isOnline}) =>
      PatientsVisitData(
        id: id ?? this.id,
        appointmentId: appointmentId ?? this.appointmentId,
        mobileNo: mobileNo ?? this.mobileNo,
        age: age ?? this.age,
        patientName: patientName ?? this.patientName,
        temperature: temperature ?? this.temperature,
        bp: bp ?? this.bp,
        pulse: pulse ?? this.pulse,
        weight: weight ?? this.weight,
        fee: fee ?? this.fee,
        patientId: patientId ?? this.patientId,
        clinicDoctorId: clinicDoctorId ?? this.clinicDoctorId,
        appointmentType: appointmentType ?? this.appointmentType,
        visitType: visitType ?? this.visitType,
        bookingType: bookingType ?? this.bookingType,
        bookedBy: bookedBy ?? this.bookedBy,
        bookedVia: bookedVia ?? this.bookedVia,
        appointmentsTime: appointmentsTime ?? this.appointmentsTime,
        presentTime: presentTime ?? this.presentTime,
        completed: completed ?? this.completed,
        isDoctorFeedBack: isDoctorFeedBack ?? this.isDoctorFeedBack,
        isPatientFeedBack: isPatientFeedBack ?? this.isPatientFeedBack,
        briefHistory: briefHistory ?? this.briefHistory,
        visitReason: visitReason ?? this.visitReason,
        examination: examination ?? this.examination,
        diagnosis: diagnosis ?? this.diagnosis,
        medication: medication ?? this.medication,
        feedBack: feedBack ?? this.feedBack,
        allergies: allergies ?? this.allergies,
        lifestyle: lifestyle ?? this.lifestyle,
        isOnline: isOnline ?? this.isOnline,
      );
  @override
  String toString() {
    return (StringBuffer('PatientsVisitData(')
          ..write('id: $id, ')
          ..write('appointmentId: $appointmentId, ')
          ..write('mobileNo: $mobileNo, ')
          ..write('age: $age, ')
          ..write('patientName: $patientName, ')
          ..write('temperature: $temperature, ')
          ..write('bp: $bp, ')
          ..write('pulse: $pulse, ')
          ..write('weight: $weight, ')
          ..write('fee: $fee, ')
          ..write('patientId: $patientId, ')
          ..write('clinicDoctorId: $clinicDoctorId, ')
          ..write('appointmentType: $appointmentType, ')
          ..write('visitType: $visitType, ')
          ..write('bookingType: $bookingType, ')
          ..write('bookedBy: $bookedBy, ')
          ..write('bookedVia: $bookedVia, ')
          ..write('appointmentsTime: $appointmentsTime, ')
          ..write('presentTime: $presentTime, ')
          ..write('completed: $completed, ')
          ..write('isDoctorFeedBack: $isDoctorFeedBack, ')
          ..write('isPatientFeedBack: $isPatientFeedBack, ')
          ..write('briefHistory: $briefHistory, ')
          ..write('visitReason: $visitReason, ')
          ..write('examination: $examination, ')
          ..write('diagnosis: $diagnosis, ')
          ..write('medication: $medication, ')
          ..write('feedBack: $feedBack, ')
          ..write('allergies: $allergies, ')
          ..write('lifestyle: $lifestyle, ')
          ..write('isOnline: $isOnline')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          appointmentId.hashCode,
          $mrjc(
              mobileNo.hashCode,
              $mrjc(
                  age.hashCode,
                  $mrjc(
                      patientName.hashCode,
                      $mrjc(
                          temperature.hashCode,
                          $mrjc(
                              bp.hashCode,
                              $mrjc(
                                  pulse.hashCode,
                                  $mrjc(
                                      weight.hashCode,
                                      $mrjc(
                                          fee.hashCode,
                                          $mrjc(
                                              patientId.hashCode,
                                              $mrjc(
                                                  clinicDoctorId.hashCode,
                                                  $mrjc(
                                                      appointmentType.hashCode,
                                                      $mrjc(
                                                          visitType.hashCode,
                                                          $mrjc(
                                                              bookingType
                                                                  .hashCode,
                                                              $mrjc(
                                                                  bookedBy
                                                                      .hashCode,
                                                                  $mrjc(
                                                                      bookedVia
                                                                          .hashCode,
                                                                      $mrjc(
                                                                          appointmentsTime
                                                                              .hashCode,
                                                                          $mrjc(
                                                                              presentTime.hashCode,
                                                                              $mrjc(completed.hashCode, $mrjc(isDoctorFeedBack.hashCode, $mrjc(isPatientFeedBack.hashCode, $mrjc(briefHistory.hashCode, $mrjc(visitReason.hashCode, $mrjc(examination.hashCode, $mrjc(diagnosis.hashCode, $mrjc(medication.hashCode, $mrjc(feedBack.hashCode, $mrjc(allergies.hashCode, $mrjc(lifestyle.hashCode, isOnline.hashCode)))))))))))))))))))))))))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is PatientsVisitData &&
          other.id == this.id &&
          other.appointmentId == this.appointmentId &&
          other.mobileNo == this.mobileNo &&
          other.age == this.age &&
          other.patientName == this.patientName &&
          other.temperature == this.temperature &&
          other.bp == this.bp &&
          other.pulse == this.pulse &&
          other.weight == this.weight &&
          other.fee == this.fee &&
          other.patientId == this.patientId &&
          other.clinicDoctorId == this.clinicDoctorId &&
          other.appointmentType == this.appointmentType &&
          other.visitType == this.visitType &&
          other.bookingType == this.bookingType &&
          other.bookedBy == this.bookedBy &&
          other.bookedVia == this.bookedVia &&
          other.appointmentsTime == this.appointmentsTime &&
          other.presentTime == this.presentTime &&
          other.completed == this.completed &&
          other.isDoctorFeedBack == this.isDoctorFeedBack &&
          other.isPatientFeedBack == this.isPatientFeedBack &&
          other.briefHistory == this.briefHistory &&
          other.visitReason == this.visitReason &&
          other.examination == this.examination &&
          other.diagnosis == this.diagnosis &&
          other.medication == this.medication &&
          other.feedBack == this.feedBack &&
          other.allergies == this.allergies &&
          other.lifestyle == this.lifestyle &&
          other.isOnline == this.isOnline);
}

class PatientsVisitCompanion extends UpdateCompanion<PatientsVisitData> {
  final Value<int> id;
  final Value<String> appointmentId;
  final Value<int> mobileNo;
  final Value<int> age;
  final Value<String> patientName;
  final Value<String> temperature;
  final Value<String> bp;
  final Value<String> pulse;
  final Value<String> weight;
  final Value<int> fee;
  final Value<String> patientId;
  final Value<int> clinicDoctorId;
  final Value<String> appointmentType;
  final Value<String> visitType;
  final Value<String> bookingType;
  final Value<String> bookedBy;
  final Value<String> bookedVia;
  final Value<DateTime> appointmentsTime;
  final Value<DateTime> presentTime;
  final Value<bool> completed;
  final Value<bool> isDoctorFeedBack;
  final Value<bool> isPatientFeedBack;
  final Value<BriefHistorygenerated> briefHistory;
  final Value<VisitReasongenerated> visitReason;
  final Value<Examinationgenerated> examination;
  final Value<Dignosisgenerated> diagnosis;
  final Value<Medicationgenerated> medication;
  final Value<Medicationgenerated> feedBack;
  final Value<Allergy> allergies;
  final Value<LifeStyle> lifestyle;
  final Value<bool> isOnline;
  const PatientsVisitCompanion({
    this.id = const Value.absent(),
    this.appointmentId = const Value.absent(),
    this.mobileNo = const Value.absent(),
    this.age = const Value.absent(),
    this.patientName = const Value.absent(),
    this.temperature = const Value.absent(),
    this.bp = const Value.absent(),
    this.pulse = const Value.absent(),
    this.weight = const Value.absent(),
    this.fee = const Value.absent(),
    this.patientId = const Value.absent(),
    this.clinicDoctorId = const Value.absent(),
    this.appointmentType = const Value.absent(),
    this.visitType = const Value.absent(),
    this.bookingType = const Value.absent(),
    this.bookedBy = const Value.absent(),
    this.bookedVia = const Value.absent(),
    this.appointmentsTime = const Value.absent(),
    this.presentTime = const Value.absent(),
    this.completed = const Value.absent(),
    this.isDoctorFeedBack = const Value.absent(),
    this.isPatientFeedBack = const Value.absent(),
    this.briefHistory = const Value.absent(),
    this.visitReason = const Value.absent(),
    this.examination = const Value.absent(),
    this.diagnosis = const Value.absent(),
    this.medication = const Value.absent(),
    this.feedBack = const Value.absent(),
    this.allergies = const Value.absent(),
    this.lifestyle = const Value.absent(),
    this.isOnline = const Value.absent(),
  });
  PatientsVisitCompanion.insert({
    this.id = const Value.absent(),
    this.appointmentId = const Value.absent(),
    @required int mobileNo,
    this.age = const Value.absent(),
    @required String patientName,
    this.temperature = const Value.absent(),
    this.bp = const Value.absent(),
    this.pulse = const Value.absent(),
    this.weight = const Value.absent(),
    this.fee = const Value.absent(),
    @required String patientId,
    this.clinicDoctorId = const Value.absent(),
    this.appointmentType = const Value.absent(),
    this.visitType = const Value.absent(),
    this.bookingType = const Value.absent(),
    this.bookedBy = const Value.absent(),
    this.bookedVia = const Value.absent(),
    this.appointmentsTime = const Value.absent(),
    this.presentTime = const Value.absent(),
    this.completed = const Value.absent(),
    this.isDoctorFeedBack = const Value.absent(),
    this.isPatientFeedBack = const Value.absent(),
    this.briefHistory = const Value.absent(),
    this.visitReason = const Value.absent(),
    this.examination = const Value.absent(),
    this.diagnosis = const Value.absent(),
    this.medication = const Value.absent(),
    this.feedBack = const Value.absent(),
    this.allergies = const Value.absent(),
    this.lifestyle = const Value.absent(),
    this.isOnline = const Value.absent(),
  })  : mobileNo = Value(mobileNo),
        patientName = Value(patientName),
        patientId = Value(patientId);
  static Insertable<PatientsVisitData> custom({
    Expression<int> id,
    Expression<String> appointmentId,
    Expression<int> mobileNo,
    Expression<int> age,
    Expression<String> patientName,
    Expression<String> temperature,
    Expression<String> bp,
    Expression<String> pulse,
    Expression<String> weight,
    Expression<int> fee,
    Expression<String> patientId,
    Expression<int> clinicDoctorId,
    Expression<String> appointmentType,
    Expression<String> visitType,
    Expression<String> bookingType,
    Expression<String> bookedBy,
    Expression<String> bookedVia,
    Expression<DateTime> appointmentsTime,
    Expression<DateTime> presentTime,
    Expression<bool> completed,
    Expression<bool> isDoctorFeedBack,
    Expression<bool> isPatientFeedBack,
    Expression<String> briefHistory,
    Expression<String> visitReason,
    Expression<String> examination,
    Expression<String> diagnosis,
    Expression<String> medication,
    Expression<String> feedBack,
    Expression<String> allergies,
    Expression<String> lifestyle,
    Expression<bool> isOnline,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (appointmentId != null) 'appointment_id': appointmentId,
      if (mobileNo != null) 'mobile_no': mobileNo,
      if (age != null) 'age': age,
      if (patientName != null) 'patient_name': patientName,
      if (temperature != null) 'temperature': temperature,
      if (bp != null) 'bp': bp,
      if (pulse != null) 'pulse': pulse,
      if (weight != null) 'weight': weight,
      if (fee != null) 'fee': fee,
      if (patientId != null) 'patient_id': patientId,
      if (clinicDoctorId != null) 'clinic_doctor_id': clinicDoctorId,
      if (appointmentType != null) 'appointment_type': appointmentType,
      if (visitType != null) 'visit_type': visitType,
      if (bookingType != null) 'booking_type': bookingType,
      if (bookedBy != null) 'booked_by': bookedBy,
      if (bookedVia != null) 'booked_via': bookedVia,
      if (appointmentsTime != null) 'appointments_time': appointmentsTime,
      if (presentTime != null) 'present_time': presentTime,
      if (completed != null) 'completed': completed,
      if (isDoctorFeedBack != null) 'is_doctor_feed_back': isDoctorFeedBack,
      if (isPatientFeedBack != null) 'is_patient_feed_back': isPatientFeedBack,
      if (briefHistory != null) 'brief_history': briefHistory,
      if (visitReason != null) 'visit_reason': visitReason,
      if (examination != null) 'examination': examination,
      if (diagnosis != null) 'diagnosis': diagnosis,
      if (medication != null) 'medication': medication,
      if (feedBack != null) 'feed_back': feedBack,
      if (allergies != null) 'allergies': allergies,
      if (lifestyle != null) 'lifestyle': lifestyle,
      if (isOnline != null) 'is_online': isOnline,
    });
  }

  PatientsVisitCompanion copyWith(
      {Value<int> id,
      Value<String> appointmentId,
      Value<int> mobileNo,
      Value<int> age,
      Value<String> patientName,
      Value<String> temperature,
      Value<String> bp,
      Value<String> pulse,
      Value<String> weight,
      Value<int> fee,
      Value<String> patientId,
      Value<int> clinicDoctorId,
      Value<String> appointmentType,
      Value<String> visitType,
      Value<String> bookingType,
      Value<String> bookedBy,
      Value<String> bookedVia,
      Value<DateTime> appointmentsTime,
      Value<DateTime> presentTime,
      Value<bool> completed,
      Value<bool> isDoctorFeedBack,
      Value<bool> isPatientFeedBack,
      Value<BriefHistorygenerated> briefHistory,
      Value<VisitReasongenerated> visitReason,
      Value<Examinationgenerated> examination,
      Value<Dignosisgenerated> diagnosis,
      Value<Medicationgenerated> medication,
      Value<Medicationgenerated> feedBack,
      Value<Allergy> allergies,
      Value<LifeStyle> lifestyle,
      Value<bool> isOnline}) {
    return PatientsVisitCompanion(
      id: id ?? this.id,
      appointmentId: appointmentId ?? this.appointmentId,
      mobileNo: mobileNo ?? this.mobileNo,
      age: age ?? this.age,
      patientName: patientName ?? this.patientName,
      temperature: temperature ?? this.temperature,
      bp: bp ?? this.bp,
      pulse: pulse ?? this.pulse,
      weight: weight ?? this.weight,
      fee: fee ?? this.fee,
      patientId: patientId ?? this.patientId,
      clinicDoctorId: clinicDoctorId ?? this.clinicDoctorId,
      appointmentType: appointmentType ?? this.appointmentType,
      visitType: visitType ?? this.visitType,
      bookingType: bookingType ?? this.bookingType,
      bookedBy: bookedBy ?? this.bookedBy,
      bookedVia: bookedVia ?? this.bookedVia,
      appointmentsTime: appointmentsTime ?? this.appointmentsTime,
      presentTime: presentTime ?? this.presentTime,
      completed: completed ?? this.completed,
      isDoctorFeedBack: isDoctorFeedBack ?? this.isDoctorFeedBack,
      isPatientFeedBack: isPatientFeedBack ?? this.isPatientFeedBack,
      briefHistory: briefHistory ?? this.briefHistory,
      visitReason: visitReason ?? this.visitReason,
      examination: examination ?? this.examination,
      diagnosis: diagnosis ?? this.diagnosis,
      medication: medication ?? this.medication,
      feedBack: feedBack ?? this.feedBack,
      allergies: allergies ?? this.allergies,
      lifestyle: lifestyle ?? this.lifestyle,
      isOnline: isOnline ?? this.isOnline,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (appointmentId.present) {
      map['appointment_id'] = Variable<String>(appointmentId.value);
    }
    if (mobileNo.present) {
      map['mobile_no'] = Variable<int>(mobileNo.value);
    }
    if (age.present) {
      map['age'] = Variable<int>(age.value);
    }
    if (patientName.present) {
      map['patient_name'] = Variable<String>(patientName.value);
    }
    if (temperature.present) {
      map['temperature'] = Variable<String>(temperature.value);
    }
    if (bp.present) {
      map['bp'] = Variable<String>(bp.value);
    }
    if (pulse.present) {
      map['pulse'] = Variable<String>(pulse.value);
    }
    if (weight.present) {
      map['weight'] = Variable<String>(weight.value);
    }
    if (fee.present) {
      map['fee'] = Variable<int>(fee.value);
    }
    if (patientId.present) {
      map['patient_id'] = Variable<String>(patientId.value);
    }
    if (clinicDoctorId.present) {
      map['clinic_doctor_id'] = Variable<int>(clinicDoctorId.value);
    }
    if (appointmentType.present) {
      map['appointment_type'] = Variable<String>(appointmentType.value);
    }
    if (visitType.present) {
      map['visit_type'] = Variable<String>(visitType.value);
    }
    if (bookingType.present) {
      map['booking_type'] = Variable<String>(bookingType.value);
    }
    if (bookedBy.present) {
      map['booked_by'] = Variable<String>(bookedBy.value);
    }
    if (bookedVia.present) {
      map['booked_via'] = Variable<String>(bookedVia.value);
    }
    if (appointmentsTime.present) {
      map['appointments_time'] = Variable<DateTime>(appointmentsTime.value);
    }
    if (presentTime.present) {
      map['present_time'] = Variable<DateTime>(presentTime.value);
    }
    if (completed.present) {
      map['completed'] = Variable<bool>(completed.value);
    }
    if (isDoctorFeedBack.present) {
      map['is_doctor_feed_back'] = Variable<bool>(isDoctorFeedBack.value);
    }
    if (isPatientFeedBack.present) {
      map['is_patient_feed_back'] = Variable<bool>(isPatientFeedBack.value);
    }
    if (briefHistory.present) {
      final converter = $PatientsVisitTable.$converter0;
      map['brief_history'] =
          Variable<String>(converter.mapToSql(briefHistory.value));
    }
    if (visitReason.present) {
      final converter = $PatientsVisitTable.$converter1;
      map['visit_reason'] =
          Variable<String>(converter.mapToSql(visitReason.value));
    }
    if (examination.present) {
      final converter = $PatientsVisitTable.$converter2;
      map['examination'] =
          Variable<String>(converter.mapToSql(examination.value));
    }
    if (diagnosis.present) {
      final converter = $PatientsVisitTable.$converter3;
      map['diagnosis'] = Variable<String>(converter.mapToSql(diagnosis.value));
    }
    if (medication.present) {
      final converter = $PatientsVisitTable.$converter4;
      map['medication'] =
          Variable<String>(converter.mapToSql(medication.value));
    }
    if (feedBack.present) {
      final converter = $PatientsVisitTable.$converter5;
      map['feed_back'] = Variable<String>(converter.mapToSql(feedBack.value));
    }
    if (allergies.present) {
      final converter = $PatientsVisitTable.$converter6;
      map['allergies'] = Variable<String>(converter.mapToSql(allergies.value));
    }
    if (lifestyle.present) {
      final converter = $PatientsVisitTable.$converter7;
      map['lifestyle'] = Variable<String>(converter.mapToSql(lifestyle.value));
    }
    if (isOnline.present) {
      map['is_online'] = Variable<bool>(isOnline.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PatientsVisitCompanion(')
          ..write('id: $id, ')
          ..write('appointmentId: $appointmentId, ')
          ..write('mobileNo: $mobileNo, ')
          ..write('age: $age, ')
          ..write('patientName: $patientName, ')
          ..write('temperature: $temperature, ')
          ..write('bp: $bp, ')
          ..write('pulse: $pulse, ')
          ..write('weight: $weight, ')
          ..write('fee: $fee, ')
          ..write('patientId: $patientId, ')
          ..write('clinicDoctorId: $clinicDoctorId, ')
          ..write('appointmentType: $appointmentType, ')
          ..write('visitType: $visitType, ')
          ..write('bookingType: $bookingType, ')
          ..write('bookedBy: $bookedBy, ')
          ..write('bookedVia: $bookedVia, ')
          ..write('appointmentsTime: $appointmentsTime, ')
          ..write('presentTime: $presentTime, ')
          ..write('completed: $completed, ')
          ..write('isDoctorFeedBack: $isDoctorFeedBack, ')
          ..write('isPatientFeedBack: $isPatientFeedBack, ')
          ..write('briefHistory: $briefHistory, ')
          ..write('visitReason: $visitReason, ')
          ..write('examination: $examination, ')
          ..write('diagnosis: $diagnosis, ')
          ..write('medication: $medication, ')
          ..write('feedBack: $feedBack, ')
          ..write('allergies: $allergies, ')
          ..write('lifestyle: $lifestyle, ')
          ..write('isOnline: $isOnline')
          ..write(')'))
        .toString();
  }
}

class $PatientsVisitTable extends PatientsVisit
    with TableInfo<$PatientsVisitTable, PatientsVisitData> {
  final GeneratedDatabase _db;
  final String _alias;
  $PatientsVisitTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _appointmentIdMeta =
      const VerificationMeta('appointmentId');
  GeneratedTextColumn _appointmentId;
  @override
  GeneratedTextColumn get appointmentId =>
      _appointmentId ??= _constructAppointmentId();
  GeneratedTextColumn _constructAppointmentId() {
    return GeneratedTextColumn(
      'appointment_id',
      $tableName,
      true,
    );
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

  final VerificationMeta _patientNameMeta =
      const VerificationMeta('patientName');
  GeneratedTextColumn _patientName;
  @override
  GeneratedTextColumn get patientName =>
      _patientName ??= _constructPatientName();
  GeneratedTextColumn _constructPatientName() {
    return GeneratedTextColumn(
      'patient_name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _temperatureMeta =
      const VerificationMeta('temperature');
  GeneratedTextColumn _temperature;
  @override
  GeneratedTextColumn get temperature =>
      _temperature ??= _constructTemperature();
  GeneratedTextColumn _constructTemperature() {
    return GeneratedTextColumn('temperature', $tableName, false,
        defaultValue: Constant('98'));
  }

  final VerificationMeta _bpMeta = const VerificationMeta('bp');
  GeneratedTextColumn _bp;
  @override
  GeneratedTextColumn get bp => _bp ??= _constructBp();
  GeneratedTextColumn _constructBp() {
    return GeneratedTextColumn('bp', $tableName, false,
        defaultValue: Constant('120/80'));
  }

  final VerificationMeta _pulseMeta = const VerificationMeta('pulse');
  GeneratedTextColumn _pulse;
  @override
  GeneratedTextColumn get pulse => _pulse ??= _constructPulse();
  GeneratedTextColumn _constructPulse() {
    return GeneratedTextColumn('pulse', $tableName, false,
        defaultValue: Constant('72'));
  }

  final VerificationMeta _weightMeta = const VerificationMeta('weight');
  GeneratedTextColumn _weight;
  @override
  GeneratedTextColumn get weight => _weight ??= _constructWeight();
  GeneratedTextColumn _constructWeight() {
    return GeneratedTextColumn('weight', $tableName, false,
        defaultValue: Constant('0'));
  }

  final VerificationMeta _feeMeta = const VerificationMeta('fee');
  GeneratedIntColumn _fee;
  @override
  GeneratedIntColumn get fee => _fee ??= _constructFee();
  GeneratedIntColumn _constructFee() {
    return GeneratedIntColumn('fee', $tableName, false,
        defaultValue: Constant(100));
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

  final VerificationMeta _appointmentTypeMeta =
      const VerificationMeta('appointmentType');
  GeneratedTextColumn _appointmentType;
  @override
  GeneratedTextColumn get appointmentType =>
      _appointmentType ??= _constructAppointmentType();
  GeneratedTextColumn _constructAppointmentType() {
    return GeneratedTextColumn(
      'appointment_type',
      $tableName,
      true,
    );
  }

  final VerificationMeta _visitTypeMeta = const VerificationMeta('visitType');
  GeneratedTextColumn _visitType;
  @override
  GeneratedTextColumn get visitType => _visitType ??= _constructVisitType();
  GeneratedTextColumn _constructVisitType() {
    return GeneratedTextColumn(
      'visit_type',
      $tableName,
      true,
    );
  }

  final VerificationMeta _bookingTypeMeta =
      const VerificationMeta('bookingType');
  GeneratedTextColumn _bookingType;
  @override
  GeneratedTextColumn get bookingType =>
      _bookingType ??= _constructBookingType();
  GeneratedTextColumn _constructBookingType() {
    return GeneratedTextColumn(
      'booking_type',
      $tableName,
      true,
    );
  }

  final VerificationMeta _bookedByMeta = const VerificationMeta('bookedBy');
  GeneratedTextColumn _bookedBy;
  @override
  GeneratedTextColumn get bookedBy => _bookedBy ??= _constructBookedBy();
  GeneratedTextColumn _constructBookedBy() {
    return GeneratedTextColumn(
      'booked_by',
      $tableName,
      true,
    );
  }

  final VerificationMeta _bookedViaMeta = const VerificationMeta('bookedVia');
  GeneratedTextColumn _bookedVia;
  @override
  GeneratedTextColumn get bookedVia => _bookedVia ??= _constructBookedVia();
  GeneratedTextColumn _constructBookedVia() {
    return GeneratedTextColumn(
      'booked_via',
      $tableName,
      true,
    );
  }

  final VerificationMeta _appointmentsTimeMeta =
      const VerificationMeta('appointmentsTime');
  GeneratedDateTimeColumn _appointmentsTime;
  @override
  GeneratedDateTimeColumn get appointmentsTime =>
      _appointmentsTime ??= _constructAppointmentsTime();
  GeneratedDateTimeColumn _constructAppointmentsTime() {
    return GeneratedDateTimeColumn(
      'appointments_time',
      $tableName,
      true,
    );
  }

  final VerificationMeta _presentTimeMeta =
      const VerificationMeta('presentTime');
  GeneratedDateTimeColumn _presentTime;
  @override
  GeneratedDateTimeColumn get presentTime =>
      _presentTime ??= _constructPresentTime();
  GeneratedDateTimeColumn _constructPresentTime() {
    return GeneratedDateTimeColumn(
      'present_time',
      $tableName,
      true,
    );
  }

  final VerificationMeta _completedMeta = const VerificationMeta('completed');
  GeneratedBoolColumn _completed;
  @override
  GeneratedBoolColumn get completed => _completed ??= _constructCompleted();
  GeneratedBoolColumn _constructCompleted() {
    return GeneratedBoolColumn('completed', $tableName, false,
        defaultValue: Constant(false));
  }

  final VerificationMeta _isDoctorFeedBackMeta =
      const VerificationMeta('isDoctorFeedBack');
  GeneratedBoolColumn _isDoctorFeedBack;
  @override
  GeneratedBoolColumn get isDoctorFeedBack =>
      _isDoctorFeedBack ??= _constructIsDoctorFeedBack();
  GeneratedBoolColumn _constructIsDoctorFeedBack() {
    return GeneratedBoolColumn('is_doctor_feed_back', $tableName, false,
        defaultValue: Constant(false));
  }

  final VerificationMeta _isPatientFeedBackMeta =
      const VerificationMeta('isPatientFeedBack');
  GeneratedBoolColumn _isPatientFeedBack;
  @override
  GeneratedBoolColumn get isPatientFeedBack =>
      _isPatientFeedBack ??= _constructIsPatientFeedBack();
  GeneratedBoolColumn _constructIsPatientFeedBack() {
    return GeneratedBoolColumn('is_patient_feed_back', $tableName, false,
        defaultValue: Constant(false));
  }

  final VerificationMeta _briefHistoryMeta =
      const VerificationMeta('briefHistory');
  GeneratedTextColumn _briefHistory;
  @override
  GeneratedTextColumn get briefHistory =>
      _briefHistory ??= _constructBriefHistory();
  GeneratedTextColumn _constructBriefHistory() {
    return GeneratedTextColumn(
      'brief_history',
      $tableName,
      true,
    );
  }

  final VerificationMeta _visitReasonMeta =
      const VerificationMeta('visitReason');
  GeneratedTextColumn _visitReason;
  @override
  GeneratedTextColumn get visitReason =>
      _visitReason ??= _constructVisitReason();
  GeneratedTextColumn _constructVisitReason() {
    return GeneratedTextColumn(
      'visit_reason',
      $tableName,
      true,
    );
  }

  final VerificationMeta _examinationMeta =
      const VerificationMeta('examination');
  GeneratedTextColumn _examination;
  @override
  GeneratedTextColumn get examination =>
      _examination ??= _constructExamination();
  GeneratedTextColumn _constructExamination() {
    return GeneratedTextColumn(
      'examination',
      $tableName,
      true,
    );
  }

  final VerificationMeta _diagnosisMeta = const VerificationMeta('diagnosis');
  GeneratedTextColumn _diagnosis;
  @override
  GeneratedTextColumn get diagnosis => _diagnosis ??= _constructDiagnosis();
  GeneratedTextColumn _constructDiagnosis() {
    return GeneratedTextColumn(
      'diagnosis',
      $tableName,
      true,
    );
  }

  final VerificationMeta _medicationMeta = const VerificationMeta('medication');
  GeneratedTextColumn _medication;
  @override
  GeneratedTextColumn get medication => _medication ??= _constructMedication();
  GeneratedTextColumn _constructMedication() {
    return GeneratedTextColumn(
      'medication',
      $tableName,
      true,
    );
  }

  final VerificationMeta _feedBackMeta = const VerificationMeta('feedBack');
  GeneratedTextColumn _feedBack;
  @override
  GeneratedTextColumn get feedBack => _feedBack ??= _constructFeedBack();
  GeneratedTextColumn _constructFeedBack() {
    return GeneratedTextColumn(
      'feed_back',
      $tableName,
      true,
    );
  }

  final VerificationMeta _allergiesMeta = const VerificationMeta('allergies');
  GeneratedTextColumn _allergies;
  @override
  GeneratedTextColumn get allergies => _allergies ??= _constructAllergies();
  GeneratedTextColumn _constructAllergies() {
    return GeneratedTextColumn(
      'allergies',
      $tableName,
      true,
    );
  }

  final VerificationMeta _lifestyleMeta = const VerificationMeta('lifestyle');
  GeneratedTextColumn _lifestyle;
  @override
  GeneratedTextColumn get lifestyle => _lifestyle ??= _constructLifestyle();
  GeneratedTextColumn _constructLifestyle() {
    return GeneratedTextColumn(
      'lifestyle',
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
        appointmentId,
        mobileNo,
        age,
        patientName,
        temperature,
        bp,
        pulse,
        weight,
        fee,
        patientId,
        clinicDoctorId,
        appointmentType,
        visitType,
        bookingType,
        bookedBy,
        bookedVia,
        appointmentsTime,
        presentTime,
        completed,
        isDoctorFeedBack,
        isPatientFeedBack,
        briefHistory,
        visitReason,
        examination,
        diagnosis,
        medication,
        feedBack,
        allergies,
        lifestyle,
        isOnline
      ];
  @override
  $PatientsVisitTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'patients_visit';
  @override
  final String actualTableName = 'patients_visit';
  @override
  VerificationContext validateIntegrity(Insertable<PatientsVisitData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('appointment_id')) {
      context.handle(
          _appointmentIdMeta,
          appointmentId.isAcceptableOrUnknown(
              data['appointment_id'], _appointmentIdMeta));
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
    if (data.containsKey('patient_name')) {
      context.handle(
          _patientNameMeta,
          patientName.isAcceptableOrUnknown(
              data['patient_name'], _patientNameMeta));
    } else if (isInserting) {
      context.missing(_patientNameMeta);
    }
    if (data.containsKey('temperature')) {
      context.handle(
          _temperatureMeta,
          temperature.isAcceptableOrUnknown(
              data['temperature'], _temperatureMeta));
    }
    if (data.containsKey('bp')) {
      context.handle(_bpMeta, bp.isAcceptableOrUnknown(data['bp'], _bpMeta));
    }
    if (data.containsKey('pulse')) {
      context.handle(
          _pulseMeta, pulse.isAcceptableOrUnknown(data['pulse'], _pulseMeta));
    }
    if (data.containsKey('weight')) {
      context.handle(_weightMeta,
          weight.isAcceptableOrUnknown(data['weight'], _weightMeta));
    }
    if (data.containsKey('fee')) {
      context.handle(
          _feeMeta, fee.isAcceptableOrUnknown(data['fee'], _feeMeta));
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
    if (data.containsKey('appointment_type')) {
      context.handle(
          _appointmentTypeMeta,
          appointmentType.isAcceptableOrUnknown(
              data['appointment_type'], _appointmentTypeMeta));
    }
    if (data.containsKey('visit_type')) {
      context.handle(_visitTypeMeta,
          visitType.isAcceptableOrUnknown(data['visit_type'], _visitTypeMeta));
    }
    if (data.containsKey('booking_type')) {
      context.handle(
          _bookingTypeMeta,
          bookingType.isAcceptableOrUnknown(
              data['booking_type'], _bookingTypeMeta));
    }
    if (data.containsKey('booked_by')) {
      context.handle(_bookedByMeta,
          bookedBy.isAcceptableOrUnknown(data['booked_by'], _bookedByMeta));
    }
    if (data.containsKey('booked_via')) {
      context.handle(_bookedViaMeta,
          bookedVia.isAcceptableOrUnknown(data['booked_via'], _bookedViaMeta));
    }
    if (data.containsKey('appointments_time')) {
      context.handle(
          _appointmentsTimeMeta,
          appointmentsTime.isAcceptableOrUnknown(
              data['appointments_time'], _appointmentsTimeMeta));
    }
    if (data.containsKey('present_time')) {
      context.handle(
          _presentTimeMeta,
          presentTime.isAcceptableOrUnknown(
              data['present_time'], _presentTimeMeta));
    }
    if (data.containsKey('completed')) {
      context.handle(_completedMeta,
          completed.isAcceptableOrUnknown(data['completed'], _completedMeta));
    }
    if (data.containsKey('is_doctor_feed_back')) {
      context.handle(
          _isDoctorFeedBackMeta,
          isDoctorFeedBack.isAcceptableOrUnknown(
              data['is_doctor_feed_back'], _isDoctorFeedBackMeta));
    }
    if (data.containsKey('is_patient_feed_back')) {
      context.handle(
          _isPatientFeedBackMeta,
          isPatientFeedBack.isAcceptableOrUnknown(
              data['is_patient_feed_back'], _isPatientFeedBackMeta));
    }
    context.handle(_briefHistoryMeta, const VerificationResult.success());
    context.handle(_visitReasonMeta, const VerificationResult.success());
    context.handle(_examinationMeta, const VerificationResult.success());
    context.handle(_diagnosisMeta, const VerificationResult.success());
    context.handle(_medicationMeta, const VerificationResult.success());
    context.handle(_feedBackMeta, const VerificationResult.success());
    context.handle(_allergiesMeta, const VerificationResult.success());
    context.handle(_lifestyleMeta, const VerificationResult.success());
    if (data.containsKey('is_online')) {
      context.handle(_isOnlineMeta,
          isOnline.isAcceptableOrUnknown(data['is_online'], _isOnlineMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PatientsVisitData map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return PatientsVisitData.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $PatientsVisitTable createAlias(String alias) {
    return $PatientsVisitTable(_db, alias);
  }

  static TypeConverter<BriefHistorygenerated, String> $converter0 =
      const BriefHistoryConverter();
  static TypeConverter<VisitReasongenerated, String> $converter1 =
      const VisitReasonConverter();
  static TypeConverter<Examinationgenerated, String> $converter2 =
      const ExaminationConverter();
  static TypeConverter<Dignosisgenerated, String> $converter3 =
      const DignosisConverter();
  static TypeConverter<Medicationgenerated, String> $converter4 =
      const MedicationConverter();
  static TypeConverter<Medicationgenerated, String> $converter5 =
      const MedicationConverter();
  static TypeConverter<Allergy, String> $converter6 = const AllergyConverter();
  static TypeConverter<LifeStyle, String> $converter7 =
      const LifeStyleConverter();
}

abstract class _$PatientsVisitDB extends GeneratedDatabase {
  _$PatientsVisitDB(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $PatientsVisitTable _patientsVisit;
  $PatientsVisitTable get patientsVisit =>
      _patientsVisit ??= $PatientsVisitTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [patientsVisit];
}
