import 'package:flutfire_crud/data/firestore_service.dart';
import 'package:flutfire_crud/models/add_note.dart';
import 'package:flutfire_crud/note_details.dart';
import 'package:flutter/material.dart';

import 'models/note.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutfire CRUD"),
      ),
      body: StreamBuilder(
        stream: FireStoreService().getNotes(),
        builder: (context, AsyncSnapshot<List<Note>> snapshot) {
          if (snapshot.hasError || !snapshot.hasData)
            return CircularProgressIndicator();

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, int index) {
              Note note = snapshot.data![index];
              return ListTile(
                title: Text("${note.title}"),
                subtitle: Text("${note.desc}"),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      color: Colors.blue,
                      icon: Icon(Icons.edit),
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => AddNote(note: note))),
                    ),
                    IconButton(
                      color: Colors.red,
                      icon: Icon(Icons.delete),
                      onPressed: () => _deleteNote(context, "${note.id}"),
                    ),
                  ],
                ),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => NoteDetails(note: note),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (_) => AddNote())),
      ),
    );
  }

  void _deleteNote(BuildContext context, String id) async {
    final _isDelete = await _showConfirmationDialog(context) ?? false;
    if (_isDelete) {
      print("connected");
      try {
        await FireStoreService().deleteNote(id);
      } catch (e) {
        print(e);
      }
    }
  }

  Future<bool?> _showConfirmationDialog(BuildContext context) async {
    return showDialog<bool?>(
      context: context,
      barrierDismissible: true,
      builder: (context) => AlertDialog(
        content: Text("Are you Sure??"),
        actions: [
          ElevatedButton(
            child: Text("Delete"),
            onPressed: () => Navigator.pop(context, true),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text("Cancel"),
          )
        ],
      ),
    );
  }
}
