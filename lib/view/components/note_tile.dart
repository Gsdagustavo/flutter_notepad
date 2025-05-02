import 'package:flutter/material.dart';

import '../../model/note.dart';
import '../pages/note_page.dart';

class NoteTile extends StatelessWidget {
  const NoteTile({super.key, required this.note});

  final Note note;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        note.name,
        style: TextStyle(fontSize: 20, overflow: TextOverflow.ellipsis),
      ),

      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: Colors.grey),
      ),

      subtitle: Text(
        note.description.isNotEmpty ? note.description : 'Sem texto',
        style: TextStyle(
          fontSize: 16,
          overflow: TextOverflow.ellipsis,
          color: Colors.grey,
        ),
      ),

      onTap:
          () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NotePage(note: note)),
          ),
    );
  }
}
