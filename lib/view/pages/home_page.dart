import 'package:flutter/material.dart';
import 'package:notepad/model/note.dart';
import 'package:notepad/view/pages/note_page.dart';
import 'package:provider/provider.dart';

import '../../model/states/note_state.dart';
import '../../model/states/theme_state.dart';
import '../components/my_app_bar.dart';
import '../components/note_tile.dart';

/// This is the home page of the application
///
/// Here will be listed all the notes made by the user, in forms of [NoteTile]
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  /// clears the text on the text field and calls the [searchNotes] function
  /// from the [NoteState] class
  void _searchNote(BuildContext context, NoteState noteState) {
    noteState.searchController.clear();
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<NoteState, ThemeState>(
      builder: (context, noteState, themeState, _) {

        /// this gesture detector and the implementation of the [onTap] function
        /// is needed to unfocus when the user taps somewhere of the screen
        /// and dismiss the keyboard when searching for a note
        return GestureDetector(
          onTap: FocusScope.of(context).unfocus,

          child: Scaffold(
            /// custom App Bar
            appBar: const MyAppBar(),

            /// padding for style
            body: Padding(
              padding: const EdgeInsets.all(16.0),

              /// all the widgets are here
              child: Column(
                children: [
                  /// search bar
                  TextField(
                    controller: noteState.searchController,

                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),

                      /// search icon
                      prefixIcon: const Icon(Icons.search),

                      /// if there is any text on the search text field, a "clear"
                      /// icon will be shown, and when it's pressed, the
                      /// text field will be cleansed and the list of shown notes
                      /// will be updated
                      suffixIcon:
                          noteState.searchController.text.isNotEmpty
                              ? IconButton(
                                icon: Icon(Icons.clear),
                                onPressed:
                                    () => _searchNote(context, noteState),
                              )
                              : null,

                      label: Text('Pesquisar anotação'),
                    ),
                  ),

                  /// space between the search field and the list of notes
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

            /// button to add a new note
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                final note = Note(name: '', description: '');

                /// when the user interacts with it, it navigates to a page
                /// to edit the note
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotePage(note: note)),
                );
              },

              /// sets the button to be a circle
              shape: CircleBorder(),

              /// add icon
              child: Icon(Icons.add),
            ),
          ),
        );
      },
    );
  }
}
