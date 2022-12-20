import 'dart:async';
import 'dart:io';

import 'package:desktop/logic/mail/data/response.dart';

class ImapConnection {
  late Socket sock;
  int tag = 0;
  Map<String, Function> callbackMap = {};

  String generateTag() {
    //get tag as hex string
    String s = tag.toRadixString(16);
    tag++;
    return s;
  }

  void registerCallback(String localTag, Function func) {
    callbackMap[localTag] = func;
  }

  Future<bool> connect(String domain, int port, bool secure) async {
    try {
      if (secure) {
        sock = await SecureSocket.connect(domain, port);
      } else {
        sock = await Socket.connect(domain, port);
      }
    } on Error {
      return true;
    }

    //register callbacks
    sock.listen(dataHandler,
        onError: errorHandler, onDone: doneHandler, cancelOnError: false);

    return false;
  }

  Future<ImapResponse> command(String cmd) async {
    //create future
    Completer<ImapResponse> comp = Completer<ImapResponse>();
    String localTag = generateTag();
    //set callback
    registerCallback(localTag, (ImapResponse data) {
      comp.complete(data);
    });
    //login with passwd and user
    sock.writeln('$localTag $cmd');

    //return future and wait for callback execution
    return comp.future;
  }

  void dataHandler(data) {
    String respString = String.fromCharCodes(data);

    ImapResponse resp = ImapResponse.fromResp(respString);

    if (!resp.isTaged) return;

    if (!callbackMap.containsKey(resp.tag)) return;
    callbackMap[resp.tag]!.call(resp);
    callbackMap.remove(resp.tag);
  }

  void errorHandler(error, StackTrace trace) {
    print("error");
    print(error);
  }

  void doneHandler() {
    print("server left");
  }

  void dispose() {
    sock.destroy();
  }
}
