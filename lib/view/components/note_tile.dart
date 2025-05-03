import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/note.dart';
import '../../model/states/note_state.dart';
import '../pages/note_page.dart';

class NoteTile extends StatelessWidget {
  const NoteTile({super.key, required this.note});

  final Note note;

  @override
  Widget build(BuildContext context) {
    return Consumer<NoteState>(
      builder:
          (context, noteState, child) => ListTile(
            title: Text(
              note.name.isNotEmpty ? note.name : note.description,
              style: TextStyle(fontSize: 20, overflow: TextOverflow.ellipsis),
              maxLines: 1,
            ),

            shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Colors.grey),
            ),

            subtitle: Text(
              note.description.isNotEmpty ? note.description : 'Sem texto',
              style: TextStyle(
                fontSize: 16,
                overflow: TextOverflow.ellipsis,
                color: Colors.grey,
              ),
              maxLines: 1,
            ),

            trailing: IconButton(
              onPressed: () {
                noteState.deleteNote(note);
              },
              icon: Icon(Icons.delete),
            ),

            onTap:
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotePage(note: note)),
                ),
          ),
    );
  }
}
