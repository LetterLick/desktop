import 'package:tuple/tuple.dart';

enum ImapStatus { ok, bad }

List<String> invalidChars = [
  '"',
  '%',
  '(',
  ')',
  '*',
  r'\',
  '[',
  ']',
  '{',
  '}',
  '\n',
  '\r'
];

class ImapResponse {
  final ImapStatus status;
  final String tag;
  final bool isTaged;
  final String msg;
  final List<List<String>> data;

  const ImapResponse(this.status, this.tag, this.isTaged, this.msg, this.data);

  factory ImapResponse.fromResp(String dataString) {
    //data store
    String tag = "";
    bool isTaged = true;
    ImapStatus status = ImapStatus.bad;
    List<List<String>> data = [[]];
    String msg = "";

    String cleanData = _dataCleanUp(dataString);

    //status stuff
    msg = _getStatusLIne(cleanData);
    tag = _getTagFromString(msg);
    if (tag == "*") isTaged = false;
    status = _getStateFromString(msg);

    //data
    String rawData = _removeStatusLine(cleanData);
    List<String> charArray = rawData.split("");

    bool createNewSting = true;
    //create first empty list
    for (int i = 0; i < charArray.length; i++) {
      switch (charArray[i]) {
        case '"':
          var res = _readQuotes(i, charArray);
          i = res.item1;
          data.last.add(res.item2);
          createNewSting = true;
          break;
        case '{':
          var res = _readLiteral(i, charArray);
          i = res.item1;
          data.last.add(res.item2);
          createNewSting = true;
          break;
        case r'\':
          var res = _readFlag(i, charArray);
          i = res.item1;
          data.last.add(res.item2);
          createNewSting = true;
          break;
        default:
          if (createNewSting) {
            data.last.add("");
            createNewSting = false;
          }
          //create new on new line
          if (charArray[i] == '\r') {
            data.add([]);
            createNewSting = true;
            break;
          }
          if (_isValicChar(charArray[i])) {
            data.last.last += charArray[i];
          }
      }
    }
    data = _removeEmptWhiteSpace(data);

    return ImapResponse(status, tag, isTaged, msg, data);
  }

/*
  clean up
 */

  static String _dataCleanUp(String dataString) {
    List<String> data = dataString.split("");

    while ((data[data.length - 1] == "\n") || (data[data.length - 1] == "\r")) {
      data.removeLast();
    }

    return data.join();
  }

  static List<List<String>> _removeEmptWhiteSpace(List<List<String>> array) {
    for (int i = 0; i < array.length; i++) {
      for (int j = 0; j < array[i].length; j++) {
        //check if empty or space
        if (array[i][j] == " " || array[i][j].isEmpty) {
          array[i].removeAt(j);
          continue;
        }
        //remove leading/ending spaces
        array[i][j] = array[i][j].trim();
      }
      //remove empty lists
      if (array[i].isEmpty) {
        array.removeAt(i);
      }
    }

    return array;
  }

/*
  Status line logic
 */

  static String _getStatusLIne(String dataString) {
    List<String> data = dataString.split("\r\n");
    return data.last;
  }

  static String _removeStatusLine(String dataString) {
    List<String> data = dataString.split("\r\n");
    data.removeLast();
    return data.join("\r\n");
  }

  static String _getTagFromString(String statusLine) {
    String tag = "";
    List<String> charArray = statusLine.split("");
    int index = 0;

    while (charArray[index] != " ") {
      tag += charArray[index];
      index++;
    }

    return tag;
  }

  static ImapStatus _getStateFromString(String statusLine) {
    List<String> words = statusLine.split(" ");

    switch (words[1]) {
      case 'OK':
        return ImapStatus.ok;
      default:
        return ImapStatus.bad;
    }
  }

/*
  data
*/

  static Tuple2<int, String> _readLiteral(int index, List<String> charArray) {
    String res = "";
    String charCountString = "";
    int charCountInt = 0;
    //get number of chars
    for (index += 1; charArray[index] != '}'; index++) {
      charCountString += charArray[index];
    }
    charCountInt = int.parse(charCountString);
    //get string
    int indexOld = index;
    for (index += charCountString.length;
        index < (indexOld + charCountInt);
        index++) {
      res += charArray[index];
    }

    return Tuple2<int, String>(index, res);
  }

  static Tuple2<int, String> _readQuotes(int index, List<String> charArray) {
    String result = "";
    index += 1;

    while (charArray[index] != '"') {
      result += charArray[index];
      index++;
    }

    return Tuple2<int, String>(index, result);
  }

  static Tuple2<int, String> _readFlag(int index, List<String> charArray) {
    String result = "";

    while (charArray[index] != ' ') {
      //remove end brackets
      if (charArray[index] == ")" && charArray[index + 1] == ' ') break;
      result += charArray[index];
      index++;
    }

    return Tuple2<int, String>(index, result);
  }

  static bool _isValicChar(String char) {
    if (invalidChars.contains(char)) return false;

    return true;
  }

/*
  Local
 */
  bool hasItFailed() {
    if (status == ImapStatus.ok) return false;
    return true;
  }

  @override
  String toString() {
    return "{$tag, $isTaged, ${status.name}, $msg, $data}";
  }
}
