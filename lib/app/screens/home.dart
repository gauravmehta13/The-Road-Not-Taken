import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, this.title = ""}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Stream<QuerySnapshot<Map<String, dynamic>>> ownerData() {
    return FirebaseFirestore.instance
        .collection("roadsNotTaken")
        .doc(auth.currentUser!.uid)
        .collection("roads")
        .snapshots();
  }

  TextEditingController textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          TextFormField(
            controller: textController,
          ),
          ElevatedButton(
              onPressed: () async {
                var db = FirebaseFirestore.instance
                    .collection("roadsNotTaken")
                    .doc(auth.currentUser!.uid)
                    .collection("roads");

                Map<String, dynamic> data = {
                  "title": textController.text,
                  "about": "",
                  "timeStamp": FieldValue.serverTimestamp()
                };

                await db
                    .doc()
                    .set(data)
                    .then((value) => textController.clear());
              },
              child: const Text("Add Road")),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
                stream: ownerData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  print(snapshot.data!.docs);
                  if (!snapshot.hasData) {
                    return const Text("Error, try again ltaer");
                  }
                  if (snapshot.hasData) {
                    print(":");
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          var road = snapshot.data!.docs[index].data() as Map;
                          return ListTile(
                              leading: const Icon(Icons.list),
                              trailing: Text(
                                road["title"],
                                style: const TextStyle(
                                    color: Colors.green, fontSize: 15),
                              ),
                              title: Text("List item $index"));
                        });
                  }
                  return Container();
                }),
          )
        ],
      ),
    );
  }
}
