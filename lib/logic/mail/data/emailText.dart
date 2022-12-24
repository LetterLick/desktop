import 'package:tuple/tuple.dart';

enum EmailTextType { text, html }

class EmailText {
  final EmailTextType type;
  final String charset;
  final String transverEncoding;
  final String text;

  const EmailText(this.type, this.charset, this.transverEncoding, this.text);

  factory EmailText.fromString(String data) {
    List<String> lineArray = data.split("\r\n");
    EmailTextType type = EmailTextType.text;
    String charset = "utf-8";
    String transverEncoding = "";

    while (lineArray.isNotEmpty) {
      if (lineArray[0] == "") break;

      //get type encoding, etc
      if (lineArray[0].startsWith("Content-Type:")) {
        var res = _getContentType(lineArray[0]);
        type = res.item2;
        charset = res.item1;
      }
      if (lineArray[0].startsWith("Content-Transfer-Encoding:")) {
        transverEncoding = _getAfterDots(lineArray[0]);
      }
      if (lineArray[0].startsWith("Content-Disposition:")) {
        //print(lineArray[0]);
      }

      //remove data line
      lineArray.removeAt(0);
    }

    return EmailText(type, charset, transverEncoding, lineArray.join("\r\n"));
  }

  static Tuple2<String, EmailTextType> _getContentType(String line) {
    int indexStartType = line.indexOf(":") + 2;
    int indexEndType = line.indexOf(";");
    int indexStartCharset = line.indexOf('"') + 1;
    int indexEndCharset = line.indexOf('"', indexStartCharset);
    //todo: charset not in ""
    String charsetString =
        ""; //line.substring(indexStartCharset, indexEndCharset);
    String typeString = line.substring(indexStartType, indexEndType);

    return Tuple2<String, EmailTextType>(
        charsetString, _emailTextTypeByString(typeString));
  }

  static String _getAfterDots(String line) {
    int indexStart = line.indexOf(":") + 2;

    return line.substring(indexStart);
  }

  static EmailTextType _emailTextTypeByString(String text) {
    switch (text) {
      case 'text/plain':
        return EmailTextType.text;
      case 'text/html':
        return EmailTextType.html;
    }

    throw "unable to get type";
  }
}
