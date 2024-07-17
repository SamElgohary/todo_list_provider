import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/task_model.dart';
import '../providers/task_provider.dart';

class TaskItem extends StatelessWidget {
  final Task task;

  TaskItem(this.task);

  void _editTask(BuildContext context) {
    final titleController = TextEditingController(text: task.title);
    final detailsController = TextEditingController(text: task.details);

    showModalBottomSheet(
      context: context,
      builder: (_) {
        return Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: detailsController,
                decoration: InputDecoration(labelText: 'Details'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  final updatedTask = Task(
                    id: task.id,
                    title: titleController.text,
                    details: detailsController.text,
                    isCompleted: task.isCompleted,
                  );
                  Provider.of<TaskProvider>(context, listen: false).editTask(updatedTask);
                  Navigator.of(context).pop();
                },
                child: Text('Save Changes'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(task.title),
      subtitle: Text(task.details),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: () {
          Provider.of<TaskProvider>(context, listen: false).deleteTask(task.id);
        },
      ),
      onTap: () => _editTask(context),
    );
  }
}
