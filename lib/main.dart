import 'package:desktop/logic/mail/data/mailbox.dart';
import 'package:desktop/logic/mail/imap.dart';
import 'package:flutter/material.dart';
import 'app.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  initializeDateFormatting();
  await dotenv.load(fileName: ".env");
  runApp(const App());
}
