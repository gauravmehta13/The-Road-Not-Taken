import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_sign_in/google_sign_in.dart';

final googleSignIn = GoogleSignIn();

final FirebaseAuth auth = FirebaseAuth.instance;

unFocusKeyboard(context) {
  FocusScopeNode currentFocus = FocusScope.of(context);
  if (!currentFocus.hasPrimaryFocus) {
    currentFocus.unfocus();
  }
}

String durationToString(int minutes) {
  var d = Duration(minutes: minutes);
  List<String> parts = d.toString().split(':');
  return '${parts[0].padLeft(2, '0')} Hr : ${parts[1].padLeft(2, '0')} Min';
}

String durationToWatchTime(int minutes) {
  var d = Duration(minutes: minutes);
  List<String> parts = d.toString().split(':');
  return '${parts[0].padLeft(2, '0')}:${parts[1].padLeft(2, '0')}:00';
}

List<dynamic> mapByKey(String keyName, List<dynamic> input) {
  Map returnValue = Map();
  for (var currMap in input) {
    if (currMap.containsKey(keyName)) {
      var currKeyValue = currMap[keyName];
      if (!returnValue.containsKey(currKeyValue)) {
        returnValue[currKeyValue] = {currKeyValue: []};
      }
      returnValue[currKeyValue][currKeyValue].add(currMap);
    }
  }
  return returnValue.values.toList();
}

textfieldDecoration(label) {
  return InputDecoration(
      isDense: true,
      contentPadding: const EdgeInsets.all(15),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        borderSide: BorderSide(width: 1, color: primaryColor),
      ),
      border:
          const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
      labelText: label,
      labelStyle: const TextStyle(color: Colors.grey));
}

comingSoon(context) {
  return showDialog(
      context: context,
      builder: (_) => AlertDialog(
            title: Column(
              children: [
                const Center(child: Text('Coming Soon')),
                box20,
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("OK"))
              ],
            ),
          ));
}

displaySnackBar(text, ctx, [time = 2]) {
  ScaffoldMessenger.of(ctx).showSnackBar(
    SnackBar(
      content: Text(text),
      behavior: SnackBarBehavior.floating,
      duration: Duration(seconds: time),
    ),
  );
}

const EdgeInsets padding10 = EdgeInsets.all(10);
const SizedBox wbox5 = SizedBox(
  width: 5,
);
const SizedBox wbox10 = SizedBox(
  width: 10,
);
const SizedBox wbox20 = SizedBox(
  width: 20,
);
const SizedBox wbox30 = SizedBox(
  width: 30,
);
const SizedBox box5 = SizedBox(
  height: 5,
);
const SizedBox box10 = SizedBox(
  height: 10,
);
const SizedBox box20 = SizedBox(
  height: 20,
);
const SizedBox box30 = SizedBox(
  height: 30,
);

const primaryColor = Color(0xFFE50914);
const secondaryColor = Color(0xFF2A2D3E);
const bgColor = Color(0xFF000000);

InputDecoration dropdownDecoration = InputDecoration(
  fillColor: Colors.white,
  isDense: true,
  counterText: "",
  contentPadding: EdgeInsets.fromLTRB(20, 0, 0, 1),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(5)),
    borderSide: BorderSide(
      width: 1,
      color: primaryColor,
    ),
  ),
  border: new OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(5)),
      borderSide: new BorderSide(color: Colors.grey)),
);
