class Proposal {
  String title;
  String details;
  String status;

  Proposal({
    required this.title,
    required this.details,
    required this.status,
  });

  // A method to convert a Proposal into a map, for later use (optional for future expansions)
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'details': details,
      'status': status,
    };
  }
}
