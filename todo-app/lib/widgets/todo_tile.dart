import 'package:flutter/material.dart';
import '../models/todo.dart';

/// Individual Todo tile widget displayed in a Card
/// Shows checkbox, title (with line-through if completed), and delete button
class TodoTile extends StatelessWidget {
  final Todo todo;
  final Function(bool?) onChanged;
  final VoidCallback onDelete;

  const TodoTile({
    super.key,
    required this.todo,
    required this.onChanged,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      // Clean spacing with margin
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      // Rounded corners for friendly UI
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 2,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        // Checkbox to mark task as complete
        leading: Checkbox(
          value: todo.completed,
          onChanged: onChanged,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        // Task title with line-through style if completed
        title: Text(
          todo.title,
          style: TextStyle(
            fontSize: 16,
            // Apply line-through decoration if task is completed
            decoration: todo.completed
                ? TextDecoration.lineThrough
                : TextDecoration.none,
            // Lighter color for completed tasks
            color: todo.completed
                ? Colors.grey
                : Theme.of(context).textTheme.bodyLarge?.color,
          ),
        ),
        // Delete icon button
        trailing: IconButton(
          icon: const Icon(Icons.delete_outline, color: Colors.red),
          onPressed: onDelete,
          tooltip: 'Delete task',
        ),
      ),
    );
  }
}
