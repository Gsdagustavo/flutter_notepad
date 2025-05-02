import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/note.dart';
import '../../model/states/note_state.dart';
import '../components/my_app_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<NoteState>(
      builder:
          (context, noteState, _) => Scaffold(
            appBar: const MyAppBar(),

            body: Column(
              children: [
                /// search bar
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: Icon(Icons.search),
                    label: Text('Pesquisar anotação'),
                  ),

                  controller: _searchController,
                ),

                const SizedBox(height: 25),

                /// list of all notes
                Expanded(
                  child: ListView.builder(
                    itemCount: noteState.notes.length,
                    itemBuilder: (context, index) {
                      final note = noteState.notes[index];
                      return NoteTile(note: note);
                    },
                  ),
                ),
              ],
            ),
          ),
    );
  }
}

class NoteTile extends StatelessWidget {
  const NoteTile({super.key, required this.note});

  final Note note;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(note.name),
      subtitle: Text(
        note.description.isNotEmpty ? note.description : 'Sem texto',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        softWrap: false,
      ),
    );
  }
}
