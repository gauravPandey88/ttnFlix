import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ttn_flix/home/model/ttnflix_movies.dart';

enum WishlistTableColumns {
  imageUrl,
  adult,
  id,
  title,
  overview,
  posterPath,
  mediaType,
  releaseDate,
  voteCount,
  voteAverage,
  language,
}

class DBManager {
  final String _databaseName = "ttnOTT.db";
  final int _databaseVersion = 1;
  final String _table = 'wishlist';
  late Database _db;

  DBManager() {
    init();
  }

  Future<void> init() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, _databaseName);
    _db = await openDatabase(
        path,
        version: _databaseVersion,
        onCreate: _onCreate
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE if not exists $_table (
            ${WishlistTableColumns.id.name} INTEGER PRIMARY KEY,
            ${WishlistTableColumns.imageUrl.name} TEXT NULL,
            ${WishlistTableColumns.posterPath.name} TEXT NULL,
            ${WishlistTableColumns.title.name} TEXT NULL,
            ${WishlistTableColumns.overview.name} TEXT NULL,
            ${WishlistTableColumns.mediaType.name} TEXT NULL,
            ${WishlistTableColumns.releaseDate.name} TEXT NULL,
            ${WishlistTableColumns.language.name} TEXT NULL,
            ${WishlistTableColumns.adult.name} INTEGER NULL,
            ${WishlistTableColumns.voteAverage.name} REAL NULL,
            ${WishlistTableColumns.voteCount.name} INTEGER NULL
          )
          ''');
  }

  Future<int> insert(Movie movie) async {
    if(await getMovie(movie.id ?? 0) == null) {
      return await _db.insert(_table, movie.toMap(movie));
    }
    return 0;
  }

  Future<List<Movie>> queryAllMovies() async {
    List<Map> maps = await _db.query(_table);
    if (maps.isNotEmpty) {
      return maps.map((e) => Movie.fromMap(e as Map<String, Object?>)).toList();
    }
    return [];
  }

  Future<int> queryRowCount() async {
    final results = await _db.rawQuery('SELECT COUNT(*) FROM $_table');
    return Sqflite.firstIntValue(results) ?? 0;
  }

  Future<List<int>> getAllIds() async {
    List<Map> maps = await _db.query(_table,
        columns: [WishlistTableColumns.id.name]);
    if (maps.isNotEmpty) {
      return maps.map((e) => e['id'] as int).toList();
    }
    return [];
  }

  Future<Movie?> getMovie(int id) async {
    List<Map> maps = await _db.query(_table,
        where: '${WishlistTableColumns.id.name} = ?',
        whereArgs: [id]);
    if (maps.isNotEmpty) {
      return Movie.fromMap(maps.first as Map<String, Object?>);
    }
    return null;
  }

  Future<int> delete(int id) async {
    return await _db.delete(
        _table,
        where: '${WishlistTableColumns.id.name} = ?',
        whereArgs: [id]
    );
  }
}
