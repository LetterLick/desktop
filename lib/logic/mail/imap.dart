import 'package:desktop/logic/mail/data/email.dart';
import 'package:desktop/logic/mail/data/mailbox.dart';
import 'package:desktop/logic/mail/data/response.dart';
import 'package:desktop/logic/mail/imap_connection.dart';

class IMAP {
  ImapConnection con = ImapConnection();
  IMAP();

  Future<bool> connect(String domain, [int port = 993]) async {
    return await con.connect(domain, port, true);
  }

  Future<bool> login(String user, String passwd) async {
    //login with passwd and user
    ImapResponse resp = await con.command('LOGIN $user "$passwd"');
    return resp.hasItFailed();
  }

  Future<List<Mailbox>> listMailBoxes() async {
    List<Mailbox> mailBoxList = [];
    ImapResponse resp = await con.command('LIST "" *');

    for (List<String> boxArray in resp.data) {
      mailBoxList.add(Mailbox.fromResp(boxArray));
    }

    return mailBoxList;
  }

  Future<bool> selectMailbox(Mailbox mailBox) async {
    ImapResponse resp = await con.command('SELECT ${mailBox.name}');
    return resp.hasItFailed();
  }

  Future<List<int>> search() async {
    //returns email ids
    List<int> ids = [];
    ImapResponse resp = await con.command('SEARCH ALL');
    for (var num in resp.data[0][0].split(" ")) {
      int? tempNum = int.tryParse(num);
      if (tempNum != null) {
        ids.add(tempNum);
      }
    }

    return ids;
  }

  Future<Email> fetch(int id) async {
    ImapResponse resp = await con.command(
        /*
      * BODY[TEXT] => Text and html
      * FLAGS => read, etc
      * ENVELOPE => sender, date, etc
      */
        'FETCH ${id.toString()} (FLAGS ENVELOPE BODY[TEXT])');

    return Email.fromResp(resp.data[0]);
  }
}
