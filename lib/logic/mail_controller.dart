import 'package:desktop/logic/mail/data/email.dart';
import 'package:desktop/logic/mail/data/mailbox.dart';
import 'package:desktop/logic/mail/imap.dart';
import 'package:desktop/logic/mail/mail_account.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class MailController {
  List<MailAccount> mailAccounts = [];
  int activeAccountId = 0;

  MailController(); //TODO: store & load clients

  void addAccount(MailAccount account) {
    mailAccounts.add(account);
  }

  MailAccount _getAccountById(int id) {
    for (var acc in mailAccounts) {
      if (acc.id == id) return acc;
    }
    throw "unknown id";
  }

// discover stuff:
  Future<void> connectToAccounts() async {
    for (var acc in mailAccounts) {
      acc.connect();
    }
  }

  //set active mailbox
  void setMailbox(Mailbox box, int accId) async {
    var acc = _getAccountById(accId);
    activeAccountId = acc.id;
    await acc.setMailbox(box);
    updateMailList();
  }

  void syncAll() async {
    for (var acc in mailAccounts) {
      await acc.refreshAll();
    }

    updateNavigator();
  }

  Future<List<int>> search() async {
    var acc = _getAccountById(activeAccountId);
    return await acc.search();
  }

//update stuff
  VoidCallback? _updateNavigator;

  set setUpdateNavigator(VoidCallback callback) {
    _updateNavigator = callback;
  }

  void updateNavigator() {
    if (_updateNavigator == null) return;
    _updateNavigator!();
  }

  VoidCallback? _updateMailList;

  set setupdateMailList(VoidCallback callback) {
    _updateNavigator = callback;
  }

  void updateMailList() {
    if (_updateNavigator == null) return;
    _updateNavigator!();
  }

  Future<Email> fetch(int id) async {
    var acc = _getAccountById(activeAccountId);

    return await acc.fetch(id);
  }
}
