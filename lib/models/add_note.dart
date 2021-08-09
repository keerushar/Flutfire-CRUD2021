import 'package:flutfire_crud/data/firestore_service.dart';
import 'package:flutfire_crud/models/note.dart';
import 'package:flutter/material.dart';

class AddNote extends StatefulWidget {
  const AddNote({Key? key}) : super(key: key);

  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  GlobalKey<FormState> key = GlobalKey<FormState>();

  TextEditingController? _titleController;
  TextEditingController? _descController;

  @override
  void initState() {
    // TODO: implement initState

    _titleController = TextEditingController(text: '');
    _descController = TextEditingController(text: '');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Note"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Form(
          key: key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _titleController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return ("Title cannot be empty");
                  }
                },
                decoration: InputDecoration(
                  labelText: "Enter title",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _descController,
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: "Enter description",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () async {
                    if (key.currentState!.validate()) {  //checking validity
                      try {
                        await FireStoreService().addNote(Note(
                          title: _titleController!.text,
                          desc: _descController!.text,
                        ));
                        Navigator.pop(context);
                      } catch (e) {
                        print(e);
                      }
                    }
                  },
                  child: Text("Ok"))
            ],
          ),
        ),
      ),
    );
  }
}
