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
      return;
    }

    if (_notes.firstWhereOrNull((n) => n.name == note.name) != null) {
      return;
    }

    _notes.add(note);
    searchNotes(); // atualizar filtered notes
    notifyListeners();
  }

  /// deletes a note
  void deleteNote(Note note) {
    _notes.remove(note);
    searchNotes(); // atualizar filtered notes
    notifyListeners();
  }

  void searchNotes() {
    if (_searchController.text.isEmpty) {
      _filteredNotes = [..._notes];
      _filteredNotes.sort((a, b) => b.lastEditDate.compareTo(a.lastEditDate));
      notifyListeners();
      return;
    }

    final searchedNote = _searchController.text.toLowerCase().trim();

    _filteredNotes =
        _notes
            .where((note) => note.name.toLowerCase().contains(searchedNote))
            .toList();

    notifyListeners();
  }
}
