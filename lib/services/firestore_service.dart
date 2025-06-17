import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/note.dart';

class FirestoreService {
  final _db = FirebaseFirestore.instance;

  Stream<List<Note>> streamNotes(String uid) {
    return _db
      .collection('users')
      .doc(uid)
      .collection('notes')
      .orderBy('updated_at', descending: true)
      .snapshots()
      .map((snap) => snap.docs
          .map((d) => Note.fromDoc(d))
          .toList());
  }

  Future<void> addOrUpdate(String uid, Note note) {
    final ref = _db
      .collection('users')
      .doc(uid)
      .collection('notes')
      .doc(note.id);
    return ref.set(note.toMap(), SetOptions(merge: true));
  }

  Future<void> deleteNote(String uid, String id) {
    return _db
      .collection('users')
      .doc(uid)
      .collection('notes')
      .doc(id)
      .delete();
  }
}