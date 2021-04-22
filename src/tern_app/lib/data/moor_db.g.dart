// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moor_db.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Spot extends DataClass implements Insertable<Spot> {
  final int id;
  final int birdId;
  final DateTime date;
  final String description;
  Spot({@required this.id, this.birdId, this.date, this.description});
  factory Spot.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    final stringType = db.typeSystem.forDartType<String>();
    return Spot(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      birdId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}bird_id']),
      date:
          dateTimeType.mapFromDatabaseResponse(data['${effectivePrefix}date']),
      description: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}description']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || birdId != null) {
      map['bird_id'] = Variable<int>(birdId);
    }
    if (!nullToAbsent || date != null) {
      map['date'] = Variable<DateTime>(date);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    return map;
  }

  SpotsCompanion toCompanion(bool nullToAbsent) {
    return SpotsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      birdId:
          birdId == null && nullToAbsent ? const Value.absent() : Value(birdId),
      date: date == null && nullToAbsent ? const Value.absent() : Value(date),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
    );
  }

  factory Spot.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Spot(
      id: serializer.fromJson<int>(json['id']),
      birdId: serializer.fromJson<int>(json['birdId']),
      date: serializer.fromJson<DateTime>(json['date']),
      description: serializer.fromJson<String>(json['description']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'birdId': serializer.toJson<int>(birdId),
      'date': serializer.toJson<DateTime>(date),
      'description': serializer.toJson<String>(description),
    };
  }

  Spot copyWith({int id, int birdId, DateTime date, String description}) =>
      Spot(
        id: id ?? this.id,
        birdId: birdId ?? this.birdId,
        date: date ?? this.date,
        description: description ?? this.description,
      );
  @override
  String toString() {
    return (StringBuffer('Spot(')
          ..write('id: $id, ')
          ..write('birdId: $birdId, ')
          ..write('date: $date, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode,
      $mrjc(birdId.hashCode, $mrjc(date.hashCode, description.hashCode))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Spot &&
          other.id == this.id &&
          other.birdId == this.birdId &&
          other.date == this.date &&
          other.description == this.description);
}

class SpotsCompanion extends UpdateCompanion<Spot> {
  final Value<int> id;
  final Value<int> birdId;
  final Value<DateTime> date;
  final Value<String> description;
  const SpotsCompanion({
    this.id = const Value.absent(),
    this.birdId = const Value.absent(),
    this.date = const Value.absent(),
    this.description = const Value.absent(),
  });
  SpotsCompanion.insert({
    this.id = const Value.absent(),
    this.birdId = const Value.absent(),
    this.date = const Value.absent(),
    this.description = const Value.absent(),
  });
  static Insertable<Spot> custom({
    Expression<int> id,
    Expression<int> birdId,
    Expression<DateTime> date,
    Expression<String> description,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (birdId != null) 'bird_id': birdId,
      if (date != null) 'date': date,
      if (description != null) 'description': description,
    });
  }

  SpotsCompanion copyWith(
      {Value<int> id,
      Value<int> birdId,
      Value<DateTime> date,
      Value<String> description}) {
    return SpotsCompanion(
      id: id ?? this.id,
      birdId: birdId ?? this.birdId,
      date: date ?? this.date,
      description: description ?? this.description,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (birdId.present) {
      map['bird_id'] = Variable<int>(birdId.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SpotsCompanion(')
          ..write('id: $id, ')
          ..write('birdId: $birdId, ')
          ..write('date: $date, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }
}

class $SpotsTable extends Spots with TableInfo<$SpotsTable, Spot> {
  final GeneratedDatabase _db;
  final String _alias;
  $SpotsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _birdIdMeta = const VerificationMeta('birdId');
  GeneratedIntColumn _birdId;
  @override
  GeneratedIntColumn get birdId => _birdId ??= _constructBirdId();
  GeneratedIntColumn _constructBirdId() {
    return GeneratedIntColumn(
      'bird_id',
      $tableName,
      true,
    );
  }

  final VerificationMeta _dateMeta = const VerificationMeta('date');
  GeneratedDateTimeColumn _date;
  @override
  GeneratedDateTimeColumn get date => _date ??= _constructDate();
  GeneratedDateTimeColumn _constructDate() {
    return GeneratedDateTimeColumn(
      'date',
      $tableName,
      true,
    );
  }

  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  GeneratedTextColumn _description;
  @override
  GeneratedTextColumn get description =>
      _description ??= _constructDescription();
  GeneratedTextColumn _constructDescription() {
    return GeneratedTextColumn('description', $tableName, true,
        maxTextLength: 255);
  }

  @override
  List<GeneratedColumn> get $columns => [id, birdId, date, description];
  @override
  $SpotsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'spots';
  @override
  final String actualTableName = 'spots';
  @override
  VerificationContext validateIntegrity(Insertable<Spot> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('bird_id')) {
      context.handle(_birdIdMeta,
          birdId.isAcceptableOrUnknown(data['bird_id'], _birdIdMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date'], _dateMeta));
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description'], _descriptionMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Spot map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Spot.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $SpotsTable createAlias(String alias) {
    return $SpotsTable(_db, alias);
  }
}

abstract class _$TernDb extends GeneratedDatabase {
  _$TernDb(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $SpotsTable _spots;
  $SpotsTable get spots => _spots ??= $SpotsTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [spots];
}
