class Address {
  final String email;
  final String name;

  const Address(this.name, this.email);

  @override
  String toString() {
    return "$name <$email>";
  }
}
