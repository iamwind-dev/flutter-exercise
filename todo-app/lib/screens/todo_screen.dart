import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/todo.dart';
import '../widgets/todo_tile.dart';

/// Main Todo screen with all app functionality
/// Manages todo list, search, persistence, and theme toggle
class TodoScreen extends StatefulWidget {
  final VoidCallback onThemeToggle;
  final bool isDarkMode;

  const TodoScreen({
    super.key,
    required this.onThemeToggle,
    required this.isDarkMode,
  });

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  // List to store all todos
  List<Todo> _todos = [];
  // List to store filtered todos based on search
  List<Todo> _filteredTodos = [];
  // Controller for search text field
  final TextEditingController _searchController = TextEditingController();
  // Controller for new task input
  final TextEditingController _taskController = TextEditingController();
  // Key for SharedPreferences
  static const String _todosKey = 'todos';

  @override
  void initState() {
    super.initState();
    _loadTodos();
    // Listen to search text changes
    _searchController.addListener(_filterTodos);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _taskController.dispose();
    super.dispose();
  }

  /// Load todos from SharedPreferences
  /// If no todos exist, add dummy initial tasks
  Future<void> _loadTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final String? todosJson = prefs.getString(_todosKey);

    if (todosJson != null) {
      // Parse stored todos from JSON
      final List<dynamic> decoded = jsonDecode(todosJson);
      setState(() {
        _todos = decoded.map((item) => Todo.fromJson(item)).toList();
        _filteredTodos = List.from(_todos);
      });
    } else {
      // Add dummy initial tasks on first launch
      setState(() {
        _todos = [
          Todo(title: 'Welcome to Todo App!', completed: false),
          Todo(title: 'Tap checkbox to mark as complete', completed: false),
          Todo(title: 'Tap + button to add new tasks', completed: false),
        ];
        _filteredTodos = List.from(_todos);
      });
      await _saveTodos();
    }
  }

  /// Save todos to SharedPreferences
  Future<void> _saveTodos() async {
    final prefs = await SharedPreferences.getInstance();
    // Convert todos to JSON string
    final String todosJson = jsonEncode(
      _todos.map((todo) => todo.toJson()).toList(),
    );
    await prefs.setString(_todosKey, todosJson);
  }

  /// Filter todos based on search query
  void _filterTodos() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredTodos = List.from(_todos);
      } else {
        _filteredTodos = _todos
            .where((todo) => todo.title.toLowerCase().contains(query))
            .toList();
      }
    });
  }

  /// Show dialog to add a new task
  void _showAddTaskDialog() {
    _taskController.clear();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Task'),
        content: TextField(
          controller: _taskController,
          decoration: const InputDecoration(
            hintText: 'Enter task title',
            border: OutlineInputBorder(),
          ),
          autofocus: true,
          // Allow adding task by pressing Enter
          onSubmitted: (value) {
            if (value.trim().isNotEmpty) {
              _addTask();
              Navigator.pop(context);
            }
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              _addTask();
              Navigator.pop(context);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  /// Add a new task to the list
  void _addTask() {
    final title = _taskController.text.trim();
    
    // Input validation: check if title is not empty
    if (title.isEmpty) {
      _showSnackBar('Task title cannot be empty');
      return;
    }

    setState(() {
      _todos.add(Todo(title: title));
      _filterTodos(); // Update filtered list
    });
    _saveTodos();
    _showSnackBar('Task added successfully');
  }

  /// Toggle task completion status
  void _toggleTodo(int index, bool? value) {
    setState(() {
      // Find the original todo in the main list
      final todo = _filteredTodos[index];
      final originalIndex = _todos.indexOf(todo);
      _todos[originalIndex].completed = value ?? false;
      _filterTodos(); // Update filtered list
    });
    _saveTodos();
  }

  /// Show confirmation dialog before deleting a task
  void _confirmDeleteTask(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Task'),
        content: const Text('Are you sure you want to delete this task?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              _deleteTask(index);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  /// Delete a task from the list
  void _deleteTask(int index) {
    final todo = _filteredTodos[index];
    final originalIndex = _todos.indexOf(todo);
    
    setState(() {
      _todos.removeAt(originalIndex);
      _filterTodos(); // Update filtered list
    });
    _saveTodos();
    _showSnackBar('Task deleted');
  }

  /// Show SnackBar with a message
  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
        centerTitle: true,
        actions: [
          // Theme toggle icon button
          IconButton(
            icon: Icon(
              widget.isDarkMode ? Icons.light_mode : Icons.dark_mode,
            ),
            onPressed: widget.onThemeToggle,
            tooltip: 'Toggle theme',
          ),
        ],
      ),
      body: Column(
        children: [
          // Search box
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search tasks...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Theme.of(context).brightness == Brightness.dark
                    ? Colors.grey[800]
                    : Colors.grey[100],
              ),
            ),
          ),
          // Todo list or empty state
          Expanded(
            child: _filteredTodos.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    itemCount: _filteredTodos.length,
                    physics: const BouncingScrollPhysics(), // Smooth scrolling
                    itemBuilder: (context, index) {
                      return TodoTile(
                        todo: _filteredTodos[index],
                        onChanged: (value) => _toggleTodo(index, value),
                        onDelete: () => _confirmDeleteTask(index),
                      );
                    },
                  ),
          ),
        ],
      ),
      // FloatingActionButton to add new task
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskDialog,
        tooltip: 'Add task',
        child: const Icon(Icons.add),
      ),
    );
  }

  /// Build empty state widget when no tasks
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.task_alt,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            _searchController.text.isEmpty
                ? 'No tasks yet'
                : 'No tasks found',
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _searchController.text.isEmpty
                ? 'Tap + button to add a new task'
                : 'Try a different search term',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }
}
