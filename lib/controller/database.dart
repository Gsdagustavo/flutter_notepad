import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/note.dart';

const String databaseName = 'notepad.db';
const int version = 1;

/// Returns an instance of a database
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

/// Represents the Note table on SQLite database
class TableNote {
  /// Table name
  static const String tableName = 'note';

  /// Columns
  static const String name = 'name';
  static const String description = 'description';
  static const String lastEditDate = 'lastEditDate';

  /// Command to create the Note table in SQLite
  static const String createTable = '''
      create table $tableName(
      $name text primary key,
      $description text,
      $lastEditDate lastEditDate integer
      );
  ''';

  /// Return a readable object (Map) for the database
  static Map<String, dynamic> toMap(Note note) {
    return {
      TableNote.name: note.name,
      TableNote.description: note.description,
      TableNote.lastEditDate: note.lastEditDate.millisecondsSinceEpoch,
    };
  }
}

class NoteController {
  /// inserts a note or overwrites the note
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

  /// returns a list of notes stored on the database
  Future<List<Note>> select() async {
    final database = await getDatabase();

    final List<Map<String, dynamic>> results = await database.query(
      TableNote.tableName,
      orderBy: '${TableNote.lastEditDate} desc',
    );

    return results.map((map) => Note.fromMap(map)).toList();
  }

  /// returns whether a note exists in the database or not
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
