import 'package:flutter/material.dart';
import '../models/note.dart';
import '../widgets/note_editor_screen.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({super.key, required this.note});
  final Note note;

  @override
  Widget build(BuildContext ctx) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        title: Text(note.title),
        subtitle: Text(
          note.content.length > 50 ? note.content.substring(0, 50) + '...' : note.content,
        ),
        trailing: note.isPinned ? Icon(Icons.push_pin) : null,
        onTap: () => Navigator.push(
          ctx,
          MaterialPageRoute(builder: (_) => NoteEditor(note: note)),
        ),
      ),
    );
  }
}
