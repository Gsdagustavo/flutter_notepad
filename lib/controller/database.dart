import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/note.dart';

const String databaseName = 'notepad.db';
const int version = 1;

Future<Database> getDatabase() async {
  final path = join(await getDatabasesPath(), databaseName);

  return openDatabase(
    path,
    onCreate: (db, version) async {
      await db.execute(TableNote.createTable);
    },

    version: version,
  );
}

class TableNote {
  static const String tableName = 'note';

  static const String name = 'name';
  static const String description = 'description';
  static const String lastEditDate = 'lastEditDate';

  static const String createTable = '''
      create table $tableName(
      $name text primary key,
      $description text,
      $lastEditDate lastEditDate integer
      );
  ''';

  static Map<String, dynamic> toMap(Note note) {
    return {
      TableNote.name: note.name,
      TableNote.description: note.description,
      TableNote.lastEditDate: note.lastEditDate.millisecondsSinceEpoch,
    };
  }
}

class NoteController {
  /// inserts to database
  Future<void> insert(Note note) async {
    final database = await getDatabase();

    await database.insert(
      TableNote.tableName,
      note.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// delete from database
  Future<void> delete(Note note) async {
    final database = await getDatabase();

    await database.delete(
      TableNote.tableName,
      where: '${TableNote.name} = ?',
      whereArgs: [note.name],
    );
  }

  /// select from database
  Future<List<Note>> select() async {
    final database = await getDatabase();

    final List<Map<String, dynamic>> results = await database.query(
      TableNote.tableName,
      orderBy: '${TableNote.lastEditDate} desc',
    );

    return results.map((map) => Note.fromMap(map)).toList();
  }

  Future<bool> doesNoteExists(Note note) async {
    final database = await getDatabase();

    final query = await database.query(
      TableNote.tableName,
      where: '${TableNote.name} = ?',
      whereArgs: [note.name],
    );

    return query.isEmpty;
  }
}
