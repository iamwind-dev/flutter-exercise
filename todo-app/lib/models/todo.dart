/// Todo model class to represent a task
/// Contains title, completion status, and serialization methods
class Todo {
  String title;
  bool completed;

  Todo({
    required this.title,
    this.completed = false,
  });

  /// Convert Todo object to Map for storage
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'completed': completed,
    };
  }

  /// Create Todo object from Map
  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      title: json['title'] as String,
      completed: json['completed'] as bool,
    );
  }
}
