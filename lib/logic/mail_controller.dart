import 'package:enough_mail/enough_mail.dart';

class MailController {
  List<MailClient> mailClients = [];

  MailController(); //TODO: store & load clients

// discover stuff:
  Future<void> autoDiscover(String name, String email, String passwd) async {
    final ClientConfig? config = await Discover.discover(email);

    if (config == null) throw ("unable to auto connect");

    addAccount(name, config, email, passwd);
    await connectToAccounts();
    //await subToMails();
  }

// account management
  void addAccount(
      String name, ClientConfig config, String email, String passwd) {
    //create account
    final account =
        MailAccount.fromDiscoveredSettings(name, email, passwd, config);

    // add client to list
    mailClients.add(MailClient(account));
  }

  Future<void> connectToAccounts() async {
    for (var client in mailClients) {
      //already connected
      if (client.isConnected) continue;
      await client.connect();
    }
  }

// Sub to emails:

  Future<void> subToMails() async {
    await mailClients[0].connect();

    for (var client in mailClients) {
      subToMail(client);
    }
  }

  void subToMail(MailClient client) async {
    //if already polling return
    if (client.isPolling()) return;

    client.eventBus.on<MailLoadEvent>().listen(newMail);
    await client.selectInbox(); //TODO: user changeable
    //sub
    await client.startPolling();
  }

  void newMail(MailLoadEvent event) {
    print("new mail");
    print(event.eventType);
    print(event.mailClient.account.name);
  }

//get emails
  Future<List<MimeMessage>> getEmails() async {
    await mailClients[0].selectInbox();
    final messages = await mailClients[0].fetchMessages(count: 2);
    return messages;
  }
}
