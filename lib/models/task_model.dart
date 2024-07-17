class Task {
  String id;
  String title;
  String details;
  bool isCompleted;

  Task({
    required this.id,
    required this.title,
    required this.details,
    this.isCompleted = false,
  });
}
