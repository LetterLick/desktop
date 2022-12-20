import 'package:flutter/material.dart';

class FolderItem extends StatefulWidget {
  const FolderItem({super.key});

  @override
  State<FolderItem> createState() => _FolderItemState();
}

class _FolderItemState extends State<FolderItem> {
  static const Icon closed = Icon(Icons.arrow_right_rounded);
  static const Icon open = Icon(Icons.arrow_drop_down_rounded);
  Icon icon = closed;
  void rotate() {
    setState(() {
      if (icon == closed)
        icon = open;
      else
        icon = closed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            IconButton(onPressed: rotate, icon: icon),
            Icon(Icons.folder),
            Text("Inbox"),
          ],
        ),
        const Divider(
          color: Colors.black,
        )
      ],
    );
  }
}
