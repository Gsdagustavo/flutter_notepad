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

  final FocusNode _searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((_) {
      _searchFocusNode.unfocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NoteState>(
      builder: (context, noteState, _) {
        return GestureDetector(
          onTap: FocusScope.of(context).unfocus,

          child: Scaffold(
            appBar: const MyAppBar(),
x
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // /// search bar
                  TextField(
                    onChanged: (_) => noteState.searchNotes(),
                    controller: noteState.searchController,
                    focusNode: _searchFocusNode,

                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      prefixIcon: Icon(Icons.search),

                      suffixIcon:
                          noteState.searchController.text.isNotEmpty
                              ? IconButton(
                                onPressed: () {
                                  noteState.searchController.clear();
                                  FocusScope.of(context).unfocus();
                                  noteState.searchNotes();
                                },

                                icon: Icon(Icons.clear),
                              )
                              : null,

                      label: Text('Pesquisar anotação'),
                    ),
                  ),

                  const SizedBox(height: 10),

                  /// list of all notes
                  Expanded(
                    child:
                        noteState.filteredNotes.isEmpty
                            ? Center(child: Text('Nenhuma nota encontrada'))
                            : ListView.builder(
                              itemCount: noteState.filteredNotes.length,
                              itemBuilder: (context, index) {
                                final note = noteState.filteredNotes[index];
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                  ),
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
