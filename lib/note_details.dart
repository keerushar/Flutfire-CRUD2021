import 'package:flutter/material.dart';

import 'models/note.dart';

class NoteDetails extends StatelessWidget {
  final Note? note;
  const NoteDetails({Key? key, @required this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
      ),
      body: Column(
        children: [
          Text("${note!.title}"),
          Text("${note!.desc}"),
        ],
      ),
    );
  }
}
