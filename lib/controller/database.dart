import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/note.dart';

const String databaseName = 'notepad.db';
const int version = 1;

Future<Database> getDatabase() async {
  final path = join(await getDatabasesPath(), databaseName);

  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute(TableNote.createTable);
    },
    version: version,
  );
}

class TableNote {
  static const String tableName = 'note';

  static const String name = 'name';
  static const String description = 'description';

  static const String createTable = '''
      create table $tableName(
      $name text primary key,
      $description text,
      );
  ''';

  static Map<String, dynamic> toMap(Note note) {
    return {TableNote.name: note.name, TableNote.description: note.description};
  }
}

class NoteController {
  Future<void> insert(Note note) async {
    final database = await getDatabase();
    final noteMap = TableNote.toMap(note);

    await database.insert(TableNote.tableName, noteMap);
  }

  Future<void> delete(Note note) async {
    final database = await getDatabase();

    await database.delete(
      TableNote.tableName,
      where: '${TableNote.name} = ?',
      whereArgs: [note.name],
    );
  }

  Future<void> update(Note note) async {
    final database = await getDatabase();
    final noteMap = TableNote.toMap(note);

    await database.update(
      TableNote.tableName,
      noteMap,
      where: '${TableNote.name} = ?',
      whereArgs: [note.name],
    );
  }

  Future<List<Note>> select() async {
    final database = await getDatabase();
    final List<Map<String, dynamic>> results = await database.query(
      TableNote.tableName,
    );

    return results
        .map(
          (note) => Note(
            name: note[TableNote.name],
            description: note[TableNote.description],
          ),
        )
        .toList();
  }
}
