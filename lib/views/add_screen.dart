import 'package:flutter/material.dart';
import 'package:polynotepad/local_db/db_helper.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  void _addNewNote() {
    if (titleController.text.isEmpty || descriptionController.text.isEmpty) {
      var snackBar = const SnackBar(content: Text('All fields are required!'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      DbHelper().addlist(context, titleController.text, descriptionController.text);
      Navigator.pop(context, true); // Return true to indicate note was added
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Note"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: "Title"),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: "Description"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addNewNote,
              child: const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}
