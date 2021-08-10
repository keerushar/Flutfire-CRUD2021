import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutfire_crud/models/note.dart';

class FireStoreService {
  static final FireStoreService _fireStoreService =
      FireStoreService._internal();
  FirebaseFirestore _db = FirebaseFirestore.instance;

  FireStoreService._internal();

  factory FireStoreService() {
    return _fireStoreService;
  }

  Stream<List<Note>> getNotes() {
    return _db.collection('notes').snapshots().map(
          (snapshot) => snapshot.docs.map((doc) => Note.fromMap(doc.data(), doc.id),).toList(),
        );
  }

  Future<void> addNote(Note note) {
    return _db.collection("notes").add(note.toMap());
  }

  Future<void> deleteNote(String id) {
    return _db.collection('notes').doc(id).delete();
  }

  Future<void> updateNote(Note note) {
    return _db.collection('notes').doc(note.id).update(note.toMap());
  }
}
