import 'package:flutter/cupertino.dart';

import '../note.dart';

class NoteState with ChangeNotifier {
  final _notes = <Note>[];

  List<Note> get notes => _notes;

  /// adds a new note in the notes list when created
  /// (this is just for debugging purposes. remove this in production)
  NoteState() {
    _notes.add(
      Note(
        'Notas da escola',
        'Ultimamente eu tenho tirado boas notas na escola',
      ),
    );
  }

  /// adds a new note
  void addNote(Note note) {
    _notes.add(note);
  }

  /// deletes a note
  void deleteNote(Note note) {
    _notes.remove(note);
  }
}
