class Todo {
  String title, description, date, time, priority;
  bool isNotify;

  Todo({
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.priority,
    required this.isNotify,
  });

  // Convert Todo object to Map
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'date': date,
      'time': time,
      'priority': priority,
      'isNotify': isNotify,
    };
  }
}
