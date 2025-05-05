import 'package:notepad/controller/database.dart';

/// This is a class that represents a [Note]] made by the user
///
/// A note contains a [name], a [description] and a [lastEditDate] representing the last
/// date when the user modified the note (changed the name, description, etc)
class Note {
  String name;
  String description;
  DateTime lastEditDate;

  /// default constructor
  ///
  /// if no [lastEditDate] value is passed to the constructor, the default
  /// date will be [Datetime.now()]
  Note({required this.name, required this.description, DateTime? lastEditDate})
    : lastEditDate = lastEditDate ?? DateTime.now();

  /// returns a map that contains the objects's attributes
  ///
  /// this is useful to make operations with the database
  Map<String, dynamic> toMap() => {
    TableNote.name: name,
    TableNote.description: description,
    TableNote.lastEditDate: lastEditDate.millisecondsSinceEpoch,
  };

  /// returns a [Note] based on the given [Map]
  static Note fromMap(Map<String, dynamic> map) {
    return Note(
      name: map[TableNote.name],
      description: map[TableNote.description],
      lastEditDate: DateTime.fromMillisecondsSinceEpoch(
        map[TableNote.lastEditDate],
      ),
    );
  }
}
