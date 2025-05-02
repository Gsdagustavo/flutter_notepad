import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Consumer<NoteState>(
      builder:
          (context, noteState, _) => GestureDetector(
            onTap: FocusScope.of(context).unfocus,

            child: Scaffold(
              appBar: const MyAppBar(),

              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    /// search bar
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 25),
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          prefixIcon: Icon(Icons.search),
                          label: Text('Pesquisar anotação'),
                        ),

                        controller: _searchController,
                      ),
                    ),

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
            ),
          ),
    );
  }
}
