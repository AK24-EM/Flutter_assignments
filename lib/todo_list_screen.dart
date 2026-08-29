import 'package:flutter/material.dart';

// Data model for Todo Item
class TodoItem {
  final String id;
  String title;
  bool isCompleted;

  TodoItem({
    required this.id,
    required this.title,
    this.isCompleted = false,
  });
}

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  // State variables managed with setState()
  final List<TodoItem> _todoList = [
    TodoItem(id: '1', title: 'Complete Flutter assignment', isCompleted: true),
    TodoItem(id: '2', title: 'Study Dart Async/Await & Null Safety', isCompleted: true),
    TodoItem(id: '3', title: 'Build responsive dashboard layout', isCompleted: false),
    TodoItem(id: '4', title: 'Prepare presentation for team meeting', isCompleted: false),
  ];

  final TextEditingController _taskController = TextEditingController();
  String _filter = 'All'; // 'All', 'Active', 'Completed'

  // Operation 1: Add a new Todo item using setState()
  void _addTodo(String title) {
    if (title.trim().isEmpty) return;
    setState(() {
      _todoList.add(
        TodoItem(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          title: title.trim(),
          isCompleted: false,
        ),
      );
    });
    _taskController.clear();
  }

  // Operation 2: Mark-complete toggle using setState()
  void _toggleComplete(TodoItem item) {
    setState(() {
      item.isCompleted = !item.isCompleted;
    });
  }

  // Operation 3: Delete a Todo item using setState()
  void _deleteTodo(String id) {
    setState(() {
      _todoList.removeWhere((item) => item.id == id);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Task deleted'),
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // Helper method to clear all completed items
  void _clearCompleted() {
    setState(() {
      _todoList.removeWhere((item) => item.isCompleted);
    });
  }

  // Filter list based on selected tab
  List<TodoItem> get _filteredList {
    if (_filter == 'Active') {
      return _todoList.where((item) => !item.isCompleted).toList();
    } else if (_filter == 'Completed') {
      return _todoList.where((item) => item.isCompleted).toList();
    }
    return _todoList;
  }

  @override
  Widget build(BuildContext context) {
    int completedCount = _todoList.where((item) => item.isCompleted).length;

    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        title: const Text(
          'My Tasks & Todos',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF1E293B),
        elevation: 1,
        actions: [
          if (completedCount > 0)
            TextButton.icon(
              onPressed: _clearCompleted,
              icon: const Icon(Icons.cleaning_services_outlined, size: 16, color: Color(0xFFF43F5E)),
              label: const Text(
                'Clear Completed',
                style: TextStyle(color: Color(0xFFF43F5E), fontSize: 12),
              ),
            ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // 1. Task Creation Input Bar (Container + TextField + ElevatedButton)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E293B),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _taskController,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          hintText: 'Add a new task...',
                          hintStyle: TextStyle(color: Colors.white38),
                          border: InputBorder.none,
                        ),
                        onSubmitted: (val) => _addTodo(val),
                      ),
                    ),
                    IconButton(
                      onPressed: () => _addTodo(_taskController.text),
                      icon: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF38BDF8),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.add, color: Colors.black, size: 20),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // 2. Stats & Filter Tabs (Row + Chips)
              Row(
                children: [
                  Text(
                    '$completedCount of ${_todoList.length} completed',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.white.withValues(alpha: 0.6),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  _buildFilterChip('All'),
                  const SizedBox(width: 6),
                  _buildFilterChip('Active'),
                  const SizedBox(width: 6),
                  _buildFilterChip('Completed'),
                ],
              ),

              const SizedBox(height: 12),

              // 3. Todo List Items View (ListView.builder with Dismissible + Checkbox)
              Expanded(
                child: _filteredList.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.task_alt_rounded,
                              size: 64,
                              color: Colors.white.withValues(alpha: 0.2),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              _todoList.isEmpty
                                  ? 'No tasks yet! Add one above.'
                                  : 'No $_filter tasks.',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white.withValues(alpha: 0.5),
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: _filteredList.length,
                        itemBuilder: (context, index) {
                          final item = _filteredList[index];

                          // Dismissible widget for swipe-to-delete
                          return Dismissible(
                            key: Key(item.id),
                            direction: DismissDirection.endToStart,
                            background: Container(
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.only(right: 20),
                              margin: const EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF43F5E),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(Icons.delete_outline, color: Colors.white),
                            ),
                            onDismissed: (direction) => _deleteTodo(item.id),
                            child: Card(
                              margin: const EdgeInsets.only(bottom: 10),
                              color: const Color(0xFF1E293B),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side: BorderSide(
                                  color: item.isCompleted
                                      ? const Color(0xFF10B981).withValues(alpha: 0.3)
                                      : Colors.white.withValues(alpha: 0.08),
                                ),
                              ),
                              child: ListTile(
                                leading: Checkbox(
                                  value: item.isCompleted,
                                  activeColor: const Color(0xFF10B981),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  onChanged: (bool? value) {
                                    _toggleComplete(item);
                                  },
                                ),
                                title: Text(
                                  item.title,
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: item.isCompleted
                                        ? Colors.white.withValues(alpha: 0.4)
                                        : Colors.white,
                                    decoration: item.isCompleted
                                        ? TextDecoration.lineThrough
                                        : TextDecoration.none,
                                    decorationColor: Colors.white.withValues(alpha: 0.4),
                                  ),
                                ),
                                trailing: IconButton(
                                  icon: const Icon(
                                    Icons.delete_outline,
                                    color: Color(0xFFF43F5E),
                                    size: 20,
                                  ),
                                  onPressed: () => _deleteTodo(item.id),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Filter chip widget
  Widget _buildFilterChip(String label) {
    bool isSelected = _filter == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          _filter = label;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF38BDF8)
              : Colors.white.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected ? Colors.black : Colors.white70,
          ),
        ),
      ),
    );
  }
}
