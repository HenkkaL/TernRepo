import 'package:moor_flutter/moor_flutter.dart';

part 'moor_db.g.dart';

class Spots extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get birdId => integer().nullable()();
  DateTimeColumn get date => dateTime().nullable()();
  TextColumn get description => text().withLength(max: 255).nullable()();
}

@UseMoor(tables: [Spots])
class TernDb extends _$TernDb {
  TernDb() : super(FlutterQueryExecutor.inDatabaseFolder(path: 'tern.db'));
  @override
  int get schemaVersion => 1;

  Future<List<Spot>> getSpots() => (select(spots)
        ..orderBy([
          (spot) => OrderingTerm(expression: spot.date, mode: OrderingMode.desc)
        ]))
      .get();

  Future<int> insertSpot(Spot spot) => into(spots).insert(spot);
  Future<bool> updateSpot(Spot spot) => update(spots).replace(spot);
  Future<int> deleteSpot(Spot spot) => delete(spots).delete(spot);
}
