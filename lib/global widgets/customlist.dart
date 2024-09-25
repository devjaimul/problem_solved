import 'package:flutter/material.dart';
import 'package:polynotepad/local_db/db_helper.dart';
import 'package:polynotepad/views/edit_screen.dart';

class Customlist extends StatefulWidget {
  const Customlist({super.key});

  @override
  State<Customlist> createState() => CustomlistState();
}

class CustomlistState extends State<Customlist> {
  List item = [];

  @override
  void initState() {
    super.initState();
    readDatabase();
  }

  void readDatabase() async {
    final dataList = await DbHelper().readData();
    setState(() {
      item = dataList ?? []; // Ensure non-null value
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: item.isEmpty
          ? const Center(child: Text('No data available')) // Display if no data
          : ListView.builder(
        itemCount: item.length,
        itemBuilder: (context, index) {
          final note = item[index]; // Access each note

          return Column(
            children: [
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.teal[200],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    leading: const CircleAvatar(
                      radius: 30,
                      child: Text(
                        "T",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    title: Text(
                      "${note["title"]}",
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text("${note["description"]}"),
                    trailing: IconButton(
                      onPressed: () async {
                        // Navigate to EditScreen and pass the selected note's data
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditScreen(
                              id: note['id'],
                              title: note['title'],
                              description: note['description'],
                            ),
                          ),
                        );
                        // Refresh the list after returning from EditScreen
                        if (result == true) {
                          readDatabase(); // Refresh the list
                        }
                      },
                      icon: const Icon(Icons.edit),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
