class Proposal {
  String category;
  String title;
  String details;
  String status;

  Proposal({
    required this.category,
    required this.title,
    required this.details,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'category': category,
      'title': title,
      'details': details,
      'status': status,
    };
  }
}
