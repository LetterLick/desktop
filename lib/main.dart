import 'dart:convert';

import 'package:desktop/logic/mail/data/mailbox.dart';
import 'package:desktop/logic/mail/imap.dart';
import 'package:desktop/logic/mail/mail_account.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  initializeDateFormatting();
  await dotenv.load(fileName: ".env");
  //test();
  runApp(const App());
}

void test() async {
  /*
  final prefs = await SharedPreferences.getInstance();

  var temp = MailAccount("asdf", dotenv.get("TESTMAIL_DOMAIN"),
      dotenv.get("TESTMAIL_USR"), dotenv.get("TESTMAIL_PASSWD"));

  await temp.connect();
  print(temp.mailboxes);
*/
  /*
  //await prefs.setString("ACC", jsonEncode(temp.toJson()));
  var resp = prefs.getString("ACC");

  var json = jsonDecode(resp!);
  print(MailAccount.fromJson(json));

  prefs.remove("ACC");

  */
}
