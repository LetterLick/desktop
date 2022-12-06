import 'package:enough_mail/smtp.dart';

class MailRead {
  static const List<String> months = [
    'JAN',
    'FEB',
    'MAR',
    'APR',
    'MAY',
    'JUN',
    'JUL',
    'AUG',
    'SEP',
    'OCT',
    'NOV',
    'DEC'
  ];
  static bool getIsSeen(MimeMessage mail, bool alt) {
    try {
      return mail.isSeen;
    } catch (e) {
      return alt;
    }
  }

  static List<String> getSenderPersonalName(
      MimeMessage mail, List<String> alt) {
    try {
      List<String> names = [];

      for (var name in mail.from!) {
        names.add(name.personalName!);
      }

      return names;
    } catch (e) {
      return alt;
    }
  }

  static List<String> getSenderEmail(MimeMessage mail, List<String> alt) {
    try {
      List<String> names = [];

      for (var name in mail.decodeSender()) {
        names.add(name.email);
      }
      return names;
    } catch (e) {
      return alt;
    }
  }

  static String getSubject(MimeMessage mail, String alt) {
    try {
      return mail.decodeSubject()!;
    } catch (e) {
      return alt;
    }
  }

  static String getDate(MimeMessage mail) {
    try {
      var date = mail.decodeDate()!;
      return "${date.day} ${months[date.month - 1]}";
    } catch (e) {
      return "";
    }
  }

  static String toReadableList(List<String> list, String seperator) {
    String res = "";

    for (var item in list) {
      res += item + seperator;
    }
    return res.substring(0, res.length - 2);
  }
}
