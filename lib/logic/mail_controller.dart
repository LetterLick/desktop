import 'package:desktop/logic/mail/data/email.dart';
import 'package:desktop/logic/mail/data/mailbox.dart';
import 'package:desktop/logic/mail/imap.dart';
import 'package:desktop/logic/mail_acc_details.dart';

class MailController {
  List<IMAP> mailClients = [];

  MailController(); //TODO: store & load clients

// discover stuff:
  Future<void> connectToAccounts(List<MailAccDetails> accList) async {
    for (var acc in accList) {
      mailClients.add(IMAP());
      await mailClients.last.connect(acc.domain, acc.port);
      await mailClients.last.login(acc.userName, acc.passwd);
    }
  }

  Future<void> selectMailbox(Mailbox box) async {
    for (var client in mailClients) {
      await client.selectMailbox(box);
    }
  }

  Future<List<List<int>>> getEmailIds() async {
    List<List<int>> idList = [];
    for (var client in mailClients) {
      idList.add(await client.search());
    }
    return idList;
  }

  Future<Email> getEmail(int id) async {
    return await mailClients[0].fetch(id);
  }
}
