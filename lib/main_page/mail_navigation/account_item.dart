import 'package:desktop/main_page/mail_navigation/folder_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class AccountItem extends StatelessWidget {
  const AccountItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Account Name:"),
        FolderItem(),
        FolderItem(),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}
