import 'package:flutter/material.dart';
import 'package:notepad/model/note.dart';
import 'package:notepad/view/pages/note_page.dart';
import 'package:provider/provider.dart';

import '../../model/states/note_state.dart';
import '../components/my_app_bar.dart';
import '../components/note_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _searchController = TextEditingController();
  List<Note> _notes = [];

  void _searchNote(NoteState state) {
    setState(() {
      _notes =
          state.notes
              .where(
                (note) => note.name.toLowerCase().contains(
                  _searchController.text.toLowerCase().trim(),
                ),
              )
              .toList();
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NoteState>(
      builder: (context, noteState, _) {
        if (_searchController.text.isEmpty) {
          _notes = noteState.notes;
        }

        return GestureDetector(
          onTap: FocusScope.of(context).unfocus,

          child: Scaffold(
            appBar: const MyAppBar(),

            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // /// search bar
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.search),
                      label: Text('Pesquisar anotação'),
                    ),

                    onChanged: (_) => _searchNote(noteState),
                    controller: _searchController,
                  ),

                  const SizedBox(height: 10),

                  /// list of all notes
                  Expanded(
                    child: ListView.builder(
                      itemCount: _notes.length,
                      itemBuilder: (context, index) {
                        final note = _notes[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: NoteTile(note: note),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            floatingActionButton: FloatingActionButton(
              onPressed: () {
                final note = Note(name: '', description: '');

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotePage(note: note)),
                );
              },

              shape: CircleBorder(),
              child: Icon(Icons.add),
            ),
          ),
        );
      },
    );
  }
}
