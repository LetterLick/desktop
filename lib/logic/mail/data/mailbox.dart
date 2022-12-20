class Mailbox {
  final String name;
  final String location;
  final List<String> tags;

  const Mailbox(this.name, this.location, this.tags);

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

  @override
  String toString() {
    return "{$name, $location, $tags}";
  }
}
