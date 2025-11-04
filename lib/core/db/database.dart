import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  static Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'app.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE products(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            description TEXT,
            price REAL,
            image TEXT
          )
        ''');

        await db.execute('''
          CREATE TABLE users(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            email TEXT UNIQUE,
            password TEXT
          )
        ''');

        await db.execute('''
          CREATE TABLE basket(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            productId INTEGER,
            name TEXT,
            description TEXT,
            price REAL,
            stock INTEGER,
            quantity INTEGER,
            image TEXT
          )
        ''');

        await _insertInitialProducts(db);
      },
      onOpen: (db) async {
        await _insertInitialProducts(db);
      },
    );
  }

  Future<void> _insertInitialProducts(Database db) async {
    final count = Sqflite.firstIntValue(
      await db.rawQuery('SELECT COUNT(*) FROM products'),
    );

    if (count == 0) {
      final products = [
        {
          'name': 'Apple MacBook Pro 16-inch',
          'description':
              'Apple M1 Pro chip, 16GB RAM, 512GB SSD, macOS Monterey',
          'price': 2499.0,
          'image': 'assets/images/macbook_pro.png',
        },
        {
          'name': 'Samsung Galaxy S23 Ultra',
          'description':
              '6.8-inch AMOLED, Snapdragon 8 Gen 2, 12GB RAM, 5000mAh battery',
          'price': 1199.0,
          'image': 'assets/images/galaxy_s23_ultra.png',
        },
        {
          'name': 'Sony WH-1000XM5 Headphones',
          'description':
              'Wireless noise-canceling headphones with up to 30 hours battery life',
          'price': 399.0,
          'image': 'assets/images/sony_wh1000xm5.png',
        },
        {
          'name': 'Apple Watch Series 9',
          'description':
              'GPS + Cellular, 41mm, Fitness tracking, Heart rate monitoring',
          'price': 399.0,
          'image': 'assets/images/apple_watch_series9.png',
        },
        {
          'name': 'iPad Air 5th Gen',
          'description':
              '10.9-inch Liquid Retina display, M1 chip, 256GB storage, Wi-Fi',
          'price': 599.0,
          'image': 'assets/images/ipad_air_5.png',
        },
        {
          'name': 'Canon EOS R6 Camera',
          'description':
              'Full-frame mirrorless camera, 20fps continuous shooting, 4K video',
          'price': 2499.0,
          'image': 'assets/images/canon_eos_r6.png',
        },
        {
          'name': 'JBL Charge 5 Bluetooth Speaker',
          'description':
              'Portable waterproof wireless speaker, 20 hours battery life, Deep Bass',
          'price': 179.0,
          'image': 'assets/images/jbl_charge5.png',
        },
        {
          'name': 'Sony PlayStation 5 Console',
          'description':
              'Next-gen gaming console with 825GB SSD, 4K gaming, DualSense controller',
          'price': 499.0,
          'image': 'assets/images/ps5_console.png',
        },
        {
          'name': 'Seagate Backup Plus 2TB External Hard Drive',
          'description':
              'Portable USB 3.0 storage, compatible with Windows and Mac',
          'price': 89.0,
          'image': 'assets/images/seagate_2tb.png',
        },
        {
          'name': 'Razer BlackWidow V3 Mechanical Keyboard',
          'description':
              'RGB gaming keyboard with tactile switches, USB wired connection',
          'price': 139.0,
          'image': 'assets/images/razer_blackwidow.png',
        },
      ];

      for (var product in products) {
        await db.insert('products', product);
      }
    }
  }
}
