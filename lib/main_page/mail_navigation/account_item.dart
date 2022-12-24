import 'package:desktop/logic/mail/data/mailbox.dart';
import 'package:desktop/logic/mail/mail_account.dart';
import 'package:desktop/logic/mail_controller.dart';
import 'package:desktop/main_page/mail_navigation/folder_item.dart';
import 'package:flutter/cupertino.dart';

class AccountItem extends StatelessWidget {
  final List<Mailbox> tree;
  final String name;
  final MailController mailController;
  final int accId;
  const AccountItem(this.mailController, this.accId, this.name, this.tree,
      {super.key});

  @override
  Widget build(BuildContext context) {
    List<FolderItem> folderList = [];

    for (var folder in tree) {
      folderList.add(FolderItem(mailController, accId, folder));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(name),
        ...folderList,
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}
