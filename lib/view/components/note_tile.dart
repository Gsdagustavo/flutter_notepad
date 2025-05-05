import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/note.dart';
import '../../model/states/note_state.dart';
import '../pages/note_page.dart';

const int maxTitleLines = 1;

/// This class represents a ListTile that will be shown in the HomePage
class NoteTile extends StatelessWidget {
  const NoteTile({super.key, required this.note});

  final Note note;

  @override
  Widget build(BuildContext context) {
    return Consumer<NoteState>(
      builder: (context, noteState, child) {
        /// returns the list tile
        return ListTile(
          /// title text
          ///
          /// if the note has no title, shows the first line of the description
          title: Text(
            note.name.isNotEmpty ? note.name : note.description,
            style: const TextStyle(
              fontSize: 20,
              overflow: TextOverflow.ellipsis,
            ),
            maxLines: maxTitleLines,
          ),

          /// adds a circular border
          shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Colors.grey),
          ),

          /// description text
          subtitle: Text(
            note.description.isNotEmpty ? note.description : 'Sem texto',
            style: const TextStyle(
              fontSize: 16,
              overflow: TextOverflow.ellipsis,
              color: Colors.grey,
            ),
            maxLines: 1,
          ),

          /// adds an IconButton to delete the note
          trailing: IconButton(
            onPressed: () => noteState.deleteNote(note),
            icon: Icon(Icons.delete),
          ),

          /// todo: implement named route with arguments
          onTap:
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotePage(note: note)),
              ),
        );
      },
    );
  }
}
