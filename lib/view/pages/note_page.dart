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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,

      child: Consumer2<ThemeState, NoteState>(
        builder:
            (context, themeState, noteState, child) => Scaffold(
              appBar: AppBar(
                title: Text('Notepad'),
                centerTitle: true,
                actions: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        /// save button
                        IconButton(
                          onPressed: () => noteState.addNote(widget.note),
                          icon: Icon(Icons.save),
                        ),

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
                      controller: widget.note.nameController,
                      decoration: InputDecoration(border: InputBorder.none),
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        '$_quantCaracteres caracteres',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),

                    Expanded(
                      child: TextField(
                        controller: widget.note.descriptionController,
                        onChanged: (_) => _countCaracteres(),
                        maxLines: maxLines,
                        decoration: InputDecoration(border: InputBorder.none),
                      ),
                    ),
                  ],
                ),
              ),
            ),
      ),
    );
  }
}
