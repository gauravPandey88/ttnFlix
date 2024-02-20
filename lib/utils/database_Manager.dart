import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ttn_flix/home/model/ttnflix_movies.dart';

enum FavouriteListTableColumns {
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
            ${FavouriteListTableColumns.id.name} INTEGER PRIMARY KEY,
            ${FavouriteListTableColumns.imageUrl.name} TEXT NULL,
            ${FavouriteListTableColumns.posterPath.name} TEXT NULL,
            ${FavouriteListTableColumns.title.name} TEXT NULL,
            ${FavouriteListTableColumns.overview.name} TEXT NULL,
            ${FavouriteListTableColumns.mediaType.name} TEXT NULL,
            ${FavouriteListTableColumns.releaseDate.name} TEXT NULL,
            ${FavouriteListTableColumns.language.name} TEXT NULL,
            ${FavouriteListTableColumns.adult.name} INTEGER NULL,
            ${FavouriteListTableColumns.voteAverage.name} REAL NULL,
            ${FavouriteListTableColumns.voteCount.name} INTEGER NULL
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
    var db = await _db;
    List<Map> maps = await db.query(_table);
    return (maps.isNotEmpty) ? maps.map((e) => Movie.fromMap(e as Map<String, Object?>)).toList() : [];
  }

  Future<int> queryRowCount() async {
    final results = await _db.rawQuery('SELECT COUNT(*) FROM $_table');
    return Sqflite.firstIntValue(results) ?? 0;
  }

  Future<List<int>> getAllIds() async {
    var db = await _db;
    List<Map> movieList = await db.query(_table,
        columns: [FavouriteListTableColumns.id.name]);
    return (movieList.isNotEmpty) ? movieList.map((e) => e['id'] as int).toList() : [];
  }

  Future<Movie?> getMovie(int id) async {
    var db = await _db;
    List<Map> maps = await db.query(_table,
        where: '${FavouriteListTableColumns.id.name} = ?',
        whereArgs: [id]);
    return (maps.isNotEmpty) ? Movie.fromMap(maps.first as Map<String, Object?>) : null;
  }

  Future<int> delete(int id) async {
    return await _db.delete(
        _table,
        where: '${FavouriteListTableColumns.id.name} = ?',
        whereArgs: [id]
    );
  }
}
