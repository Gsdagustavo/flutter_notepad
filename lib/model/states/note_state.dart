import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';

import '../note.dart';

class NoteState with ChangeNotifier {
  final _notes = <Note>[];

  var _filteredNotes = <Note>[];
  final _searchController = TextEditingController();

  List<Note> get notes => _notes;

  get filteredNotes => _filteredNotes;

  get searchController => _searchController;

  /// adds a new note in the notes list when created
  /// (this is just for debugging purposes. remove this in production)
  NoteState() {
    _notes.add(
      Note(
        name: 'Notas da escola',
        description: 'Ultimamente eu tenho tirado boas notas na escola',
      ),
    );
  }

  /// adds a new note
  void addNote(Note note) {
    if (note.description.isEmpty && note.name.isEmpty) {
      debugPrint('nigga');
      return;
    }

    if (_notes.firstWhereOrNull((n) => n.name == note.name) != null) {
      return;
    }

    _notes.add(note);
  }

  /// deletes a note
  void deleteNote(Note note) {
    _notes.remove(note);
    notifyListeners();
  }

  void searchNotes() {
    _filteredNotes =
        _searchController.text.isEmpty
            ? _notes
            : _notes
                .where(
                  (note) => note.name.toLowerCase().contains(
                    _searchController.text.toLowerCase().trim(),
                  ),
                )
                .toList();
    notifyListeners();
  }
}
