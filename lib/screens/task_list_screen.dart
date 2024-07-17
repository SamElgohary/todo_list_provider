import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import '../widgets/task_item.dart';
import 'add_task_screen.dart';

class TaskListScreen extends StatelessWidget {
  static const routeName = '/task-list';

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    final tasks = taskProvider.tasks;

    return Scaffold(
      appBar: AppBar(
        title: Text('Task Manager'),
      ),
      body: tasks.isEmpty
          ? Center(child: Text('No tasks added yet.'))
          : ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (ctx, index) => TaskItem(tasks[index]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(AddTaskScreen.routeName);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
