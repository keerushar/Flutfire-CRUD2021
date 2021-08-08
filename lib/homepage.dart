import 'package:flutfire_crud/data/firestore_service.dart';
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
              );
            },
          );
        },
      ),
    );
  }
}
