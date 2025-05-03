import 'package:flutter/material.dart';
import 'package:notepad/model/states/note_state.dart';
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
  int _quantCaracteres = 0;

  void _countCaracteres() {
    setState(() {
      _quantCaracteres = widget.note.description.length;
    });
  }

  @override
  void initState() {
    super.initState();
    _countCaracteres();
  }

  String getLastEditTime() {
    final note = widget.note;
    return '${note.lastEditDate.month}/${note.lastEditDate.day} - ${note.lastEditDate.hour}:${note.lastEditDate.minute}';
  }

  @override
  Widget build(BuildContext context) {
    final note = widget.note;

    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,

      child: Consumer2<ThemeState, NoteState>(
        builder:
            (context, themeState, noteState, child) => PopScope(
              onPopInvokedWithResult: (didPop, _) {
                if (didPop) {
                  noteState.addNote(note);
                  noteState.searchNotes();
                }
              },

              child: Scaffold(
                appBar: AppBar(
                  title: Text('Notepad'),
                  centerTitle: true,
                  actions: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          /// toggle theme button
                          IconButton(
                            onPressed: () => themeState.toggleTheme(),
                            icon: Icon(
                              themeState.isLightMode
                                  ? Icons.light_mode
                                  : Icons.dark_mode,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                body: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: note.nameController,
                        decoration: InputDecoration(border: InputBorder.none),
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),

                        onChanged: (_) {
                          note.lastEditDate = DateTime.now();
                        },
                      ),

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

                      Expanded(
                        child: TextField(
                          controller: widget.note.descriptionController,
                          onChanged: (_) {
                            widget.note.lastEditDate = DateTime.now();
                            _countCaracteres();
                          },

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
