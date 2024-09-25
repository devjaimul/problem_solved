import 'package:flutter/material.dart';
import 'package:polynotepad/local_db/db_helper.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final titleEditController = TextEditingController();
  final descriptionEditController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _onTapAddProductButton() {
    if (_formKey.currentState!.validate()) {
      addNewProduct();
    }
  }

  Future<void> addNewProduct() async {
    // Save the product after validation
    if (titleEditController.text.isNotEmpty &&
        descriptionEditController.text.isNotEmpty) {
      await DbHelper().addlist(
          context, titleEditController.text, descriptionEditController.text);
      // Return true to indicate new data was added
      Navigator.pop(context, true);
    } else {
      var snackBar = const SnackBar(content: Text('All fields are required!'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add note", style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 20),
                Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: TextFormField(
                    controller: titleEditController,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.title),
                      hintText: 'Enter your title here',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter a valid title';
                      }
                      return null;
                    },
                    textAlignVertical: TextAlignVertical.top,
                    textAlign: TextAlign.start,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: TextFormField(
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter a valid description';
                      }
                      return null;
                    },
                    controller: descriptionEditController,
                    textAlignVertical: TextAlignVertical.top,
                    textAlign: TextAlign.start,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.description),
                      hintText: 'Enter description here',
                    ),
                    maxLines: 5,
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  width: MediaQuery.sizeOf(context).width,
                  child: ElevatedButton(
                      onPressed: _onTapAddProductButton,
                      child: const Text("Save")),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
