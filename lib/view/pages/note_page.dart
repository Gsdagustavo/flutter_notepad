import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:notepad/model/states/note_state.dart';
import 'package:notepad/view/components/my_app_bar.dart';
import 'package:provider/provider.dart';

import '../../model/note.dart';
import '../../model/states/theme_state.dart';

/// Declares how many lines the user can write on
const int maxLines = 100;

/// This class represents the Note Page that is shown when the user selects
/// a note from the Home Page or when a new note is created
class NotePage extends StatefulWidget {
  const NotePage({super.key, required this.note});

  ///  Represents the note that will be shown
  final Note note;

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  /// Controllers to edit the texts (name and description)
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  /// Keep track of the number of characters in the description
  ///
  /// Useful for showing the number of characters under the note name (just for UX)
  int _numCharacters = 0;

  /// Sets [_numCharacters] to the number of characters in the note's description
  void _countCharacters() {
    setState(() {
      _numCharacters = widget.note.description.length;
    });
  }

  /// Decoration of the text fields
  final InputDecoration _textFieldDecoration = InputDecoration(
    border: InputBorder.none,
  );

  @override
  void initState() {
    super.initState();

    /// Sets the initial texts as the notes's texts (name and description)
    _nameController.text = widget.note.name;
    _descriptionController.text = widget.note.description;
    _countCharacters();
  }

  /// Returns a [String] for showing the user when the note was last updated
  String getLastEditTime() {
    final lastEditDate = widget.note.lastEditDate;
    return '${lastEditDate.month}/${lastEditDate.day} - ${lastEditDate.hour}:${lastEditDate.minute}';
  }

  /// Updates the note based on the current text on the text fields
  void updateNote() {
    final note = widget.note;

    note.name = _nameController.text;
    note.description = _descriptionController.text;
    note.lastEditDate = DateTime.now();

    _countCharacters();
  }

  /// Util method to unfocus the current scope
  void unfocus() => FocusScope.of(context).unfocus();

  @override
  Widget build(BuildContext context) {
    final note = widget.note;

    return GestureDetector(
      onTap: unfocus,

      /// ThemeState is for keeping track of the current theme of the app (light or dark)
      ///
      /// NoteState is for keeping track of the note
      child: Consumer2<ThemeState, NoteState>(
        builder:
            /// PopScope will handle if the user exited the NotePage, and if he
            (context, themeState, noteState, child) => PopScope(
              onPopInvokedWithResult: (didPop, _) async {
                if (didPop) {
                  noteState.addNote(note);
                  unfocus();
                }
              },

              child: Scaffold(
                appBar: MyAppBar(),

                body: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Note name text field
                      TextField(
                        controller: _nameController,
                        decoration: _textFieldDecoration,

                        onChanged: (_) => updateNote(),

                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      /// last edit time and character count texts
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          children: [
                            Text('${getLastEditTime()} | '),

                            Text(
                              '$_numCharacters ${AppLocalizations.of(context)!.characterCountLabel}',
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),

                      /// Note description text field
                      Expanded(
                        child: TextField(
                          controller: _descriptionController,
                          decoration: _textFieldDecoration,

                          onChanged: (_) => updateNote(),
                          maxLines: maxLines,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
      ),
    );
  }
}
