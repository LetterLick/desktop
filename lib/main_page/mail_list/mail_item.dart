import 'package:flutter/material.dart';

class MailItem extends StatelessWidget {
  const MailItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(Colors.white),
          overlayColor:
              MaterialStateProperty.all(Color.fromARGB(209, 41, 41, 41))),
      onPressed: (() => print("hey")),
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.grey,
              width: 1,
            ),
            bottom: BorderSide(
              color: Colors.grey,
              width: 1,
            ),
          ),
        ),
        padding: const EdgeInsets.only(top: 7, bottom: 7),
        child: Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(right: 20, left: 10),
              child: Icon(
                Icons.circle,
                color: Colors.blue,
                size: 15,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(right: 10),
              width: 150,
              child: const Text(
                "email Adress dassfdasdf",
                overflow: TextOverflow.fade,
                softWrap: false,
              ),
            ),
            const Expanded(
                child: Text(
              "🚀 Neuheiten und Weiterentwicklungen",
              overflow: TextOverflow.fade,
              softWrap: false,
            )),
            const Padding(
              padding: EdgeInsets.only(right: 20, left: 20),
              child: Text(
                "Mar 29",
                style: TextStyle(color: Colors.grey),
                softWrap: false,
              ),
            )
          ],
        ),
      ),
    );
  }
}
