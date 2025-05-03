import 'package:notepad/controller/database.dart';

class Note {
  String name;
  String description;
  DateTime lastEditDate;

  Note({required this.name, required this.description, DateTime? lastEditDate})
    : lastEditDate = lastEditDate ?? DateTime.now();

  Map<String, dynamic> toMap() => {
    TableNote.name: name,
    TableNote.description: description,
    TableNote.lastEditDate: lastEditDate.millisecondsSinceEpoch,
  };

  static Note fromMap(Map<String, dynamic> map) => Note(
    name: map[TableNote.name],
    description: map[TableNote.description],
    lastEditDate: DateTime.fromMillisecondsSinceEpoch(
      map[TableNote.lastEditDate],
    ),
  );
}
