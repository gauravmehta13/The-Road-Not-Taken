import 'package:flutter/material.dart';

class AddRoadUntravelled extends StatefulWidget {
  const AddRoadUntravelled({Key? key}) : super(key: key);

  @override
  _AddRoadUntravelledState createState() => _AddRoadUntravelledState();
}

class _AddRoadUntravelledState extends State<AddRoadUntravelled> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SizedBox.shrink(),
      body: Container(
        child: Column(
          children: [
            TextFormField(),
          ],
        ),
      ),
    );
  }
}
