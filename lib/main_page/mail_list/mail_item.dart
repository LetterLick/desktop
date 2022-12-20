import 'package:desktop/design.dart';
import 'package:desktop/logic/mail/data/email.dart';
import 'package:flutter/material.dart';

class MailItem extends StatelessWidget {
  final Email mail;
  final Function callBack;
  final bool isSelected = false;
  const MailItem(this.mail, this.callBack, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //background color
    Color backgroundColor = design.mailListItemBackgroundColor;
    //selected
    if (isSelected)
      backgroundColor = design.mailListItemBackgroundColorIsSelected;

    //read status
    Color isReadColor = design.mailListItemIsNotRead;
    if (mail.isRead) isReadColor = design.mailListItemIsRead;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextButton(
          onPressed: () => callBack(),
          style: ButtonStyle(
            alignment: Alignment.centerLeft,
            backgroundColor:
                MaterialStateProperty.resolveWith((Set<MaterialState> states) {
              if (states.contains(MaterialState.hovered))
                return design.mailListItemBackgroundColorHover;
              return backgroundColor;
            }),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30))),
            padding: MaterialStateProperty.all(
                const EdgeInsets.fromLTRB(15, 15, 25, 15)),
          ),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: isReadColor,
                      borderRadius: const BorderRadius.all(Radius.circular(5))),
                  width: 3,
                  height: double.infinity,
                ),
                const SizedBox(width: 7),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            mail.fromEmail.name,
                            style: design.mailListItemFromStyle,
                          ),
                          const Spacer(),
                          Text(
                            mail.previewTime,
                            style: design.mailListItemPreviewtStyle,
                          ),
                        ],
                      ),
                      Text(
                        mail.subject,
                        style: design.mailListItemSubjectStyle,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        mail.previewText,
                        maxLines: 1,
                        overflow: TextOverflow.clip,
                        style: design.mailListItemPreviewtStyle,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
