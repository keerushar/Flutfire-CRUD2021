import 'package:flutfire_crud/data/firestore_service.dart';
import 'package:flutfire_crud/models/note.dart';
import 'package:flutter/material.dart';

class AddNote extends StatefulWidget {
  final Note? note;
  const AddNote({Key? key, this.note}) : super(key: key);

  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  GlobalKey<FormState> key = GlobalKey<FormState>();

  TextEditingController? _titleController;
  TextEditingController? _descController;

  FocusNode? _titlefocus;
  FocusNode? _descfocus;

  get isEditMode => widget.note != null;

  @override
  void initState() {
    _titleController =
        TextEditingController(text: isEditMode ? widget.note!.title : '');
    _descController =
        TextEditingController(text: isEditMode ? widget.note!.desc : '');

    _titlefocus = FocusNode();
    _descfocus = FocusNode();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditMode ? "Edit Note" : "Add Note"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Form(
          key: key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                focusNode: _titlefocus,
                controller: _titleController,
                onEditingComplete: () => _descfocus!.requestFocus(),
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
                focusNode: _descfocus,
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
                    if (key.currentState!.validate()) {
                      //checking validity
                      try {
                        if (isEditMode) {
                          Note note = Note(
                            title: _titleController!.text,
                            desc: _descController!.text,
                            id: widget.note!.id,
                          );
                          await FireStoreService().updateNote(note);
                          Navigator.pop(context);
                        } else {
                          Note note = Note(
                            title: _titleController!.text,
                            desc: _descController!.text,
                          );
                          await FireStoreService().addNote(note);
                          Navigator.pop(context);
                        }
                      } catch (e) {
                        print(e);
                      }
                    }
                  },
                  child: Text(isEditMode ? "Update" : "Save"))
            ],
          ),
        ),
      ),
    );
  }
}
