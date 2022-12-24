import 'package:desktop/logic/mail/data/address.dart';
import 'package:desktop/logic/mail/data/emailText.dart';
import 'package:intl/intl.dart';

class Email {
  DateFormat timeFormat = DateFormat("hh:mm");
  DateFormat dateFormat = DateFormat("d MMM");

  final String subject;
  final EmailText? plainText;
  bool plainTextAvailable = false;
  final EmailText? htmlText;
  bool htmlAvailable = false;
  final Address fromEmail;
  final Address toEmail;
  final DateTime sendDate;
  final isRead = false;

  Email(this.subject, this.plainText, this.htmlText, this.fromEmail,
      this.toEmail, this.sendDate) {
    if (htmlText != null) htmlAvailable = true;
    if (plainText != null) plainTextAvailable = true;
  }

  String get text {
    if (!plainTextAvailable) throw "no text available";
    return plainText!.text;
  }

  String get html {
    if (!htmlAvailable) return text;
    return htmlText!.text;
  }

  String get previewText {
    if (!plainTextAvailable) throw "no text available";

    String preview = "";

    List<String> ilegalChars = ["\r", "\n", "\r\n", "\n\r"];

    for (int i = 0; i < plainText!.text.length; i++) {
      if (!ilegalChars.contains(plainText!.text[i])) {
        preview += plainText!.text[i];
      }
    }
    return preview;
  }

  String get previewTime {
    if (sendDate.day == DateTime.now().day) return timeFormat.format(sendDate);

    return dateFormat.format(sendDate);
  }

  factory Email.fromResp(List<String> mailString) {
    EmailText? html;
    EmailText? plain;
    //remove id and fetch cmd
    int indexOfCMD = mailString[0].indexOf("FETCH");

    mailString[0] = mailString[0].substring(indexOfCMD + 6);
    //indexes
    int indexOfFlags =
        mailString.indexWhere((element) => element.contains("FLAGS")) + 1;
    int indexOfEnvelope =
        mailString.indexWhere((element) => element.contains("ENVELOPE")) + 1;
    int indexOfText =
        mailString.indexWhere((element) => element.contains("BODYTEXT")) + 1;

    //extract text
    List<EmailText> mailTexts = _getEmailTexts(mailString[indexOfText]);

    for (var email in mailTexts) {
      if (email.type == EmailTextType.html) html = email;
      if (email.type == EmailTextType.text) plain = email;
    }

    //extract flags
    List<String> flags = _getFlags(mailString[indexOfFlags]);

    //extract enevlop data
    EnvelopData envelope = _fromEnvelop(
        mailString.getRange(indexOfEnvelope, indexOfText - 1).toList());
    return Email(envelope.subject, plain, html, envelope.from, envelope.to,
        envelope.date);
  }

  static List<EmailText> _getEmailTexts(String mailString) {
    int startIndex = 0;
    //get tag index
    while (
        !(mailString[startIndex] == "-" && mailString[startIndex + 1] == "-")) {
      startIndex++;
    }

    //tag to mark start and end of mail
    String tag = mailString.substring(startIndex + 2).split("\r\n")[0];
    List<String> emailTexts = _getTextByTag(mailString, tag);

    List<EmailText> texts = [];
    for (var mailText in emailTexts) {
      texts.add(EmailText.fromString(mailText));
    }

    return texts;
  }

  static List<String> _getTextByTag(String data, String tag) {
    bool saveData = false;
    List<String> lineList = [];
    List<String> resList = [];
    //split by lines
    for (var line in data.split("\r\n")) {
      //stop when end reached
      if (line == "--$tag--") {
        resList.add(lineList.join("\r\n"));
        break;
      }

      if (line == "--$tag") {
        //first time just save data active
        if (saveData == false) {
          saveData = true;
          continue;
        }
        //for ever comp in msg
        resList.add(lineList.join("\r\n"));
        lineList = [];
        continue;
      }

      if (saveData) lineList.add(line);
    }
    return resList;
  }

  static List<String> _getFlags(String data) {
    //print(data);
    // TODO: implement extraction of flags
    return [];
  }

  static EnvelopData _fromEnvelop(List<String> data) {
    //date
    String stringDate = data[0];
    stringDate = stringDate.replaceAll(" +", "+");
    DateFormat format = DateFormat("E, dd MMM yyyy hh:mm:ss");
    DateTime date = format.parse(stringDate);

    //subject
    String subject = data[1];

    //from
    Address fromAddr = Address(data[2], "${data[4]}@${data[5]}");
    //to
    Address toAddr = Address("", "${data[16]}@${data[17]}");

    return EnvelopData(subject, date, fromAddr, toAddr);
  }
}

class EnvelopData {
  final String subject;
  final DateTime date;
  final Address from;
  final Address to;

  const EnvelopData(this.subject, this.date, this.from, this.to);
}
