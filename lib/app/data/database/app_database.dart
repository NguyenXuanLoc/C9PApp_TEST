import 'package:c9p/app/data/database/product_field.dart';
import 'package:c9p/app/data/model/product_model.dart';
import 'package:c9p/app/utils/log_utils.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const String table = 'models';

class AppDatabase {
  static final AppDatabase instance = AppDatabase._init();

  static Database? _database;

  AppDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('app.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const nameType = 'TEXT NOT NULL';
    const priceType = 'INT NOT NULL';
    const weightType = 'INT NOT NULL';
    const createdAtType = 'TEXT NOT NULL';
    const updatedAtType = 'TEXT NOT NULL';
    const imgType = 'TEXT NOT NULL';
    const descriptionType = 'TEXT NOT NULL';
    const imgListType = 'TEXT NOT NULL';
    const shippingFeeType = 'INT NOT NULL';
    const salesType = 'TEXT NOT NULL';
    const countType = 'INT NOT NULL';

    await db.execute('''
CREATE TABLE $table ( 
  ${ProductField.id} $idType, 
  ${ProductField.name} $nameType,
  ${ProductField.price} $priceType,
  ${ProductField.weight} $weightType,
  ${ProductField.createdAt} $createdAtType,
  ${ProductField.updatedAt} $updatedAtType,
  ${ProductField.img} $imgType,
  ${ProductField.description} $descriptionType,
  ${ProductField.imgList} $imgListType,
  ${ProductField.shippingFee} $shippingFeeType,
  ${ProductField.sales} $salesType,
  ${ProductField.count} $countType
  )
''');
  }

  Future<ProductModel?> create(ProductModel model) async {
    final db = await instance.database;
    final id = await db.insert(table, model.toJson());
    return model;
  }

  Future<ProductModel?> readProduct(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      table,
      columns: ProductField.values,
      where: '${ProductField.id} = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return ProductModel.fromJson(maps.first);
    }
    return null;
  }

  Future<void> removeAllData() async {
    final db = await instance.database;
    db.rawDelete('DELETE FROM $table');
  }

  Future<List<ProductModel>> getAllProduct() async {
    final db = await instance.database;

    final result = await db.query(table, distinct: true);
    return result.map((json) => ProductModel.fromJson(json)).toList();
  }

  Future<int> getQuantity() async {
    final db = await instance.database;
    var result = await db.query(table);
    return result.length;
  }

  Future<int> update(ProductModel model) async {
    final db = await instance.database;

    return db.update(
      table,
      model.toJson(),
      where: '${ProductField.id} = ?',
      whereArgs: [model.id],
    );
  }

  Future<int> delete(String id) async {
    final db = await instance.database;

    return await db.delete(
      table,
      where: '${ProductField.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
