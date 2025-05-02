import 'package:flutter/material.dart';
import 'package:notepad/view/components/my_app_bar.dart';

import '../../model/note.dart';

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
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,

      child: Scaffold(
        appBar: const MyAppBar(),

        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: widget.note.nameController,
                decoration: InputDecoration(border: InputBorder.none),
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
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
    );
  }
}
