import 'package:flutter/material.dart';
import 'package:polynotepad/local_db/db_helper.dart';

class EditScreen extends StatefulWidget {
  final int id;
  final String title;
  final String description;

  const EditScreen({super.key, required this.title, required this.description, required this.id});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final titleEditController = TextEditingController();
  final descriptionEditController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    setData();
  }

  void setData() {
    setState(() {
      titleEditController.text = widget.title;
      descriptionEditController.text = widget.description;
    });
  }

  void _onTapAddProductButton() {
    if (_formKey.currentState!.validate()) {
      addNewProduct();
    }
  }

  Future<void> addNewProduct() async {
    if (titleEditController.text.isEmpty || descriptionEditController.text.isEmpty) {
      var snackBar = SnackBar(content: Text('All fields are required!'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      await DbHelper().update(widget.id, {
        "title": titleEditController.text,
        "description": descriptionEditController.text,
      }, context);

      Navigator.pop(context, true); // Return true to indicate the update was successful
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit note", style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 7,
                        offset: Offset(0, 3),
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
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: TextFormField(
                    controller: descriptionEditController,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.description),
                      hintText: 'Enter your description here',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter a valid description';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _onTapAddProductButton,
                  child: const Text("Save"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
