import 'package:cloud_firestore/cloud_firestore.dart';

class Note {
  final String id;
  String title;
  String content;
  DateTime createdAt;
  DateTime updatedAt;
  bool isPinned;

  Note({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
    this.isPinned = false,
  });

  Map<String, dynamic> toMap() => {
    'title': title,
    'content': content,
    'created_at': createdAt,
    'updated_at': updatedAt,
    'isPinned': isPinned,
  };

  factory Note.fromDoc(DocumentSnapshot doc) {
    final d = doc.data() as Map<String, dynamic>;
    return Note(
      id: doc.id,
      title: d['title'] ?? '',
      content: d['content'] ?? '',
      createdAt: (d['created_at'] as Timestamp).toDate(),
      updatedAt: (d['updated_at'] as Timestamp).toDate(),
      isPinned: d['isPinned'] ?? false,
    );
  }
}
