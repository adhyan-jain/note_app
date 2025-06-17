import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import '../services/firestore_service.dart';
import '../models/note.dart';
import '../widgets/note_card.dart';
import '../widgets/note_editor_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  const HomeScreen({super.key});
  Widget build(BuildContext ctx) {
    final auth = Provider.of<AuthService>(ctx);
    final firestore = Provider.of<FirestoreService>(ctx);
    final uid = auth.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Notes'),
        actions: [IconButton(icon: Icon(Icons.logout), onPressed: auth.signOut)],
      ),
      body: StreamBuilder<List<Note>>(
        stream: firestore.streamNotes(uid),
        builder: (ctx, snap) {
          if (snap.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator());
          }
          final notes = snap.data ?? [];
          if (notes.isEmpty) return Center(child: Text('No notes yet!'));
          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (_, i) => NoteCard(note: notes[i]),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () =>
            Navigator.push(ctx, MaterialPageRoute(builder: (_) => NoteEditor())),
      ),
    );
  }
}
