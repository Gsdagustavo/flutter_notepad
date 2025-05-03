import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:notepad/controller/database.dart';

import '../note.dart';

class NoteState with ChangeNotifier {
  final _notes = <Note>[];
  final _filteredNotes = <Note>[];

  final _searchController = TextEditingController();

  final NoteController _noteController = NoteController();

  get filteredNotes => _filteredNotes;

  List<Note> get notes => _notes;

  get searchController => _searchController;

  NoteState() {
    _searchController.addListener(searchNotes);
    loadNotes();
  }

  /// loads the notes from the database
  Future<void> loadNotes() async {
    final list = await _noteController.select();
    _notes.clear();
    _notes.addAll(list);
    searchNotes();
    notifyListeners();
  }

  /// adds a new note
  Future<void> addNote(Note note) async {
    /// invalid note
    if (note.description.isEmpty && note.name.isEmpty) return;
    if (_notes.firstWhereOrNull((n) => n.name == note.name) != null) return;

    /// adds the note
    await _noteController.insert(note);
    await loadNotes();
  }

  /// deletes a note
  Future<void> deleteNote(Note note) async {
    await _noteController.delete(note);
    await loadNotes();
  }

  void searchNotes() {
    debugPrint('search: ${_searchController.text}');
    final search = _searchController.text.toLowerCase().trim();
    final result = <Note>[];
    _filteredNotes.clear();

    if (search.isEmpty) {
      _filteredNotes.addAll(_notes);
    } else {
      _filteredNotes.addAll(
        _notes
            .where(
              (note) =>
                  note.name.toLowerCase().contains(search) ||
                  note.description.toLowerCase().contains(search),
            )
            .toList(),
      );
    }

    _filteredNotes.addAll(result);

    debugPrint('filtered notes: ${_filteredNotes.join('\n')}');
    notifyListeners();
  }

  Future<bool> doesNoteExists(Note note) async {
    return await _noteController.doesNoteExists(note);
  }
}
