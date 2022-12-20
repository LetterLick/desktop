class MailAccDetails {
  final String domain;
  final int port;
  final bool secure;
  final String userName;
  final String passwd;

  const MailAccDetails(
      this.domain, this.port, this.secure, this.userName, this.passwd);
}
