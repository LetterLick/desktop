class Mailbox {
  final String name;
  final String location;
  final List<String> tags;
  List<Mailbox> children;

  Mailbox(this.name, this.location, this.tags, [this.children = const []]);

  String get cleanName {
    int pos = name.lastIndexOf("/");

    if (pos < 0) return name;

    return name.substring(pos + 1);
  }

  factory Mailbox.fromResp(List<String> data) {
    //data
    String mailboxName;
    String location;
    List<String> tags = [];

    //name
    mailboxName = data.removeLast();
    //path
    location = data.removeLast();

    //tags
    for (int i = 0; data.length > 1; i++) {
      tags.add(data.removeLast());
    }

    return Mailbox(mailboxName, location, tags);
  }

  static List<Mailbox> sortTree(List<Mailbox> boxs) {
    return _sortTree("", boxs);
  }

  static List<Mailbox> _sortTree(String path, List<Mailbox> boxs) {
    List<Mailbox> resList = [];
    for (var box in boxs) {
      if (box.name.startsWith(path) &&
          !box.name.substring(path.length).contains("/")) {
        box.children = _sortTree("${box.name}/", boxs);
        resList.add(box);
      }
    }
    return resList;
  }

  @override
  String toString() {
    return "{$name, $location, $tags, $children}";
  }
}
