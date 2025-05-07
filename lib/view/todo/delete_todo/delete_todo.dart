import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wecodethat/controller/todo_controller.dart';

class DeleteTodoDialog extends StatelessWidget {
  final int index;

  const DeleteTodoDialog({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Consumer<TodoProvider>(builder: (context, todoProvider, child) {
      return AlertDialog(
        title: const Text('Delete Todo'),
        content: const Text('Are you sure you want to delete this todo item?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              todoProvider.deleteTodo(index);
              Navigator.pop(context);
            },
            child: const Text('Delete'),
          ),
        ],
      );
    });
  }
}
