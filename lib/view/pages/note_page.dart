import 'package:flutter/material.dart';
import 'package:notepad/model/states/note_state.dart';
import 'package:notepad/view/components/my_app_bar.dart';
import 'package:provider/provider.dart';

import '../../model/note.dart';
import '../../model/states/theme_state.dart';

const int maxLines = 100;

class NotePage extends StatefulWidget {
  const NotePage({super.key, required this.note});

  final Note note;

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  int _quantCaracteres = 0;

  void _countCaracteres() {
    setState(() {
      _quantCaracteres = widget.note.description.length;
    });
  }

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.note.name;
    _descriptionController.text = widget.note.description;
    _countCaracteres();
  }

  String getLastEditTime() {
    final note = widget.note;
    return '${note.lastEditDate.month}/${note.lastEditDate.day} - ${note.lastEditDate.hour}:${note.lastEditDate.minute}';
  }

  void updateNote() {
    final note = widget.note;

    note.name = _nameController.text;
    note.description = _descriptionController.text;
    note.lastEditDate = DateTime.now();
    _countCaracteres();
  }

  void unfocus() => FocusScope.of(context).unfocus();

  @override
  Widget build(BuildContext context) {
    final note = widget.note;

    return GestureDetector(
      onTap: unfocus,

      child: Consumer2<ThemeState, NoteState>(
        builder:
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

                        decoration: InputDecoration(border: InputBorder.none),
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),

                        onChanged: (_) => updateNote(),
                      ),

                      /// last edit time and character count texts
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          children: [
                            Text('${getLastEditTime()} | '),

                            Text(
                              '$_quantCaracteres caracteres',
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),

                      /// Note description text field
                      Expanded(
                        child: TextField(
                          controller: _descriptionController,
                          onChanged: (_) => updateNote(),

                          maxLines: maxLines,
                          decoration: InputDecoration(border: InputBorder.none),
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
