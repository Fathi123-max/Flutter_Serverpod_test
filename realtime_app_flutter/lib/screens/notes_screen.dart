import 'package:flutter/material.dart';
import '../models/note.dart';
import '../widgets/note_card.dart';
import 'edit_note_screen.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final List<Note> _notes = [];

  void _addNote() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const EditNoteScreen(),
      ),
    );

    if (result != null && result is Note) {
      setState(() {
        _notes.add(result);
      });
    }
  }

  void _editNote(Note note) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditNoteScreen(note: note),
      ),
    );

    if (result != null && result is Note) {
      setState(() {
        final index = _notes.indexWhere((element) => element.id == result.id);
        if (index != -1) {
          _notes[index] = result;
        }
      });
    }
  }

  void _deleteNote(String id) {
    setState(() {
      _notes.removeWhere((note) => note.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Notes'),
      ),
      body: _notes.isEmpty
          ? const Center(
              child: Text('No notes yet. Tap + to add a new note.'),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: _notes.length,
              itemBuilder: (context, index) {
                return NoteCard(
                  note: _notes[index],
                  onTap: () => _editNote(_notes[index]),
                  onDelete: () => _deleteNote(_notes[index].id),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNote,
        child: const Icon(Icons.add),
      ),
    );
  }
}