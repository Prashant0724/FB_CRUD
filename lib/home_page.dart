import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crud_koko/services/firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirestoreServices firestoreServices = FirestoreServices();

  final TextEditingController textController = TextEditingController();

  void openNoteBox({String? docID}) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: TextField(
                controller: textController,
              ),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      if (docID == null) {
                        firestoreServices.addNote(textController.text);
                      } else {
                        firestoreServices.updateNote(
                            docID, textController.text);
                      }
                      textController.clear();
                      Navigator.pop(context);
                    },
                    child: Text("Add"))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes"),
        backgroundColor: Colors.grey,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestoreServices.getNotesstream(),
        builder: (context, snapshot) {
          // if we have data , then get all the docs
          if (snapshot.hasData) {
            List notesList = snapshot.data!.docs;

            //   display data as a list
            return ListView.builder(
                itemCount: notesList.length,
                itemBuilder: (context, index) {
                  //   get each individual doc
                  DocumentSnapshot document = notesList[index];
                  String docID = document.id;

                  //   get note from each doc
                  Map<String, dynamic> data =
                      document.data() as Map<String, dynamic>;
                  String noteText = data['note'];

                  //   display as a list tile
                  return ListTile(
                    title: Text(noteText),
                    trailing: Row(mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: ()=>openNoteBox(docID: docID),
                          icon: Icon(Icons.settings_outlined),
                        ),
                        IconButton(
                          onPressed: ()=>firestoreServices.deleteNote(docID),
                          icon: Icon(Icons.delete),
                        ),
                      ],
                    ),
                  );
                });

            // if there is no data , return nothing
          } else {
            return const Text("No notes....");
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: openNoteBox,
        child: Icon(Icons.add),
      ),
    );
  }
}
