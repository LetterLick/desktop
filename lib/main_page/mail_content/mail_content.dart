import 'package:flutter/material.dart';

class MailContent extends StatelessWidget {
  const MailContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(204, 65, 63, 63),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: [
          const Text(
            "🚀 Neuheiten und Weiterentwicklungen",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const Text("Infomaniak <no-reply@infomaniak.com>"),
          const Text("sent: date"),
          const Text("To: test@bolli.dev"),
          const Text("Folder: Inbox"),
          Expanded(
            child: Container(
              color: Colors.red,
              child: Text("Content"),
            ),
          ),
        ],
      ),
    );
  }
}
