import 'package:desktop/logic/mail/data/email.dart';
import 'package:desktop/logic/mail/data/mailbox.dart';
import 'package:desktop/logic/mail/imap.dart';

class MailAccount {
  final String name;
  final String domain;
  final String user;
  final String passwd;
  final int id;

  MailAccount(this.name, this.id, this.domain, this.user, this.passwd);

  //logic
  final IMAP imapCon = IMAP();
  //cache
  List<Mailbox>? _mailboxTree;
  bool _fetchedMailbox = false;

  //connect and login to account
  Future<void> connect() async {
    await imapCon.connect(domain);
    await imapCon.login(user, passwd);
  }

  //refresh all data
  Future<void> refreshAll() async {
    if (!imapCon.isConnected) return;
    await _getMailboxes();
  }

  //mailboxes get from cache
  Future<List<Mailbox>> get mailboxTree async {
    await imapCon.isConnectedAsync;
    if (_mailboxTree != null) {
      //fetch without await result
      if (!_fetchedMailbox) _getMailboxes();
      return _mailboxTree!;
    }
    return await _getMailboxes();
  }

  //mailboxes get from server
  Future<List<Mailbox>> _getMailboxes() async {
    List<Mailbox> list = await imapCon.listMailBoxes();
    _mailboxTree = Mailbox.sortTree(list);
    _fetchedMailbox = true;
    return _mailboxTree!;
  }

  Future<void> setMailbox(Mailbox box) async {
    await imapCon.selectMailbox(box);
  }

  Future<List<int>> search() async {
    return await imapCon.search();
  }

  Future<Email> fetch(int id) async {
    return await imapCon.fetch(id);
  }

  // save and load logic

  factory MailAccount.fromJson(dynamic data) {
    return MailAccount(
        data['name'], data['domain'], data['user'], data['passwd'], data['id']);
  }

  dynamic toJson() {
    dynamic json = {
      "name": name,
      "domain": domain,
      "user": user,
      "passwd": passwd,
      "id": id
    };

    return json;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
