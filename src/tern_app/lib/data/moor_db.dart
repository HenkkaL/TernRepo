import 'package:moor_flutter/moor_flutter.dart';

part 'moor_db.g.dart';

class Spots extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get birdId => integer().nullable()();
  DateTimeColumn get date => dateTime().nullable()();
  TextColumn get description => text().withLength(max: 255).nullable()();
}

class Birds extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 255)();
}

@UseMoor(tables: [Spots, Birds])
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

  Future<List<Bird>> getBirds() => (select(birds)
        ..orderBy([
          (bird) => OrderingTerm(expression: bird.name, mode: OrderingMode.asc)
        ]))
      .get();

  Future<int> insertBird(Bird bird) => into(birds).insert(bird);
  Future<bool> updateBird(Bird bird) => update(birds).replace(bird);
  Future<int> deleteBird(Bird bird) => delete(birds).delete(bird);
}
