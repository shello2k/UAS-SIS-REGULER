class Email {
  final String subject;
  final String body;
  String status;
  final String sender;
  final String recipient;
  String? forwardTo;

  Email({
    required this.subject,
    required this.body,
    required this.status,
    required this.sender,
    required this.recipient,
    this.forwardTo,
  });
}
