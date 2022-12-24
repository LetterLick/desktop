import 'package:desktop/logic/mail/data/mailbox.dart';
import 'package:desktop/logic/mail_controller.dart';
import 'package:flutter/material.dart';

class FolderItem extends StatefulWidget {
  final Mailbox box;
  final MailController mailController;
  final int accId;
  const FolderItem(this.mailController, this.accId, this.box, {super.key});

  @override
  State<FolderItem> createState() => _FolderItemState();
}

class _FolderItemState extends State<FolderItem> {
  static const Icon closedIcon = Icon(Icons.arrow_right_rounded);
  static const Icon openIcon = Icon(Icons.arrow_drop_down_rounded);
  Icon icon = closedIcon;
  bool isOpen = false;
  bool hasChildren = false;
  List<FolderItem> children = [];

  void addChildren() {
    children = [];
    for (var child in widget.box.children) {
      children.add(FolderItem(widget.mailController, widget.accId, child));
    }
    if (children.isNotEmpty)
      hasChildren = true;
    else
      hasChildren = false;
  }

  void setArrow() {
    if (isOpen)
      icon = openIcon;
    else
      icon = closedIcon;
  }

  void rotate() {
    setState(() {
      isOpen = !isOpen;
    });
  }

  void onSelect() {
    widget.mailController.setMailbox(widget.box, widget.accId);
  }

  void unSelect() {}

  @override
  Widget build(BuildContext context) {
    addChildren();
    setArrow();

    return Column(
      children: [
        Row(
          children: [
            hasChildren
                ? IconButton(
                    onPressed: rotate,
                    icon: icon,
                    padding: const EdgeInsets.all(0),
                    constraints: const BoxConstraints(maxHeight: 20),
                  )
                : const SizedBox(width: 25),
            TextButton(
                onPressed: onSelect,
                child: Row(
                  children: [
                    const Icon(Icons.folder),
                    Text(widget.box.cleanName),
                  ],
                ))
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Column(
            children: isOpen ? children : [],
          ),
        )
      ],
    );
  }
}
