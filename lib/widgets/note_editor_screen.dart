import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/firestore_service.dart';
import '../services/auth_service.dart';
import '../models/note.dart';

class NoteEditor extends StatefulWidget {
  const NoteEditor({super.key, this.note});

  final Note? note;

  @override
  State<NoteEditor> createState() => _NoteEditorState();
}


class _NoteEditorState extends State<NoteEditor> {
  final _title = TextEditingController();
  final _content = TextEditingController();
  bool _pinned = false;

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      _title.text = widget.note!.title;
      _content.text = widget.note!.content;
      _pinned = widget.note!.isPinned;
    }
  }

  void _save() async {
    final uid = Provider.of<AuthService>(context, listen: false).currentUser!.uid;
    final fs = Provider.of<FirestoreService>(context, listen: false);
    final now = DateTime.now();

    late Note note;

    if (widget.note != null) {
      // Editing existing note
      note = Note(
        id: widget.note!.id,
        title: _title.text,
        content: _content.text,
        createdAt: widget.note!.createdAt,
        updatedAt: now,
        isPinned: _pinned,
      );
    } else {
      // Creating a new note
      note = Note(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: _title.text,
        content: _content.text,
        createdAt: now,
        updatedAt: now,
        isPinned: _pinned,
      );
    }

    await fs.addOrUpdate(uid, note);
    if (!context.mounted) return;
    Navigator.pop(context);
  }


  void _delete() async {
    if (widget.note != null) {
      final uid = Provider.of<AuthService>(context, listen: false).currentUser!.uid;
      final fs = Provider.of<FirestoreService>(context, listen: false);
      await fs.deleteNote(uid, widget.note!.id);
    }
    if (!context.mounted) return;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.note == null ? 'New Note' : 'Edit Note'),
        actions: [
          IconButton(icon: Icon(Icons.save), onPressed: _save),
          if (widget.note != null)
            IconButton(icon: Icon(Icons.delete), onPressed: _delete),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: _title, decoration: InputDecoration(hintText: 'Title')),
            SizedBox(height: 12),
            Expanded(
              child: TextField(
                controller: _content,
                decoration: InputDecoration(hintText: 'Your note...'),
                maxLines: null,
                expands: true,
              ),
            ),
            Row(
              children: [
                Checkbox(value: _pinned, onChanged: (v) => setState(() => _pinned = v!)),
                Text('Pin this note'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
