import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../models/task_model.dart';


class TaskProvider with ChangeNotifier {
  List<Task> _tasks = [];

  List<Task> get tasks {
    return [..._tasks];
  }

  TaskProvider() {
    loadTasks();
  }

  Future<void> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('tasks')) {
      final data = prefs.getString('tasks')!;
      final List<dynamic> decodedData = json.decode(data);
      _tasks = decodedData.map((item) => Task(
        id: item['id'],
        title: item['title'],
        details: item['details'],
        isCompleted: item['isCompleted'],
      )).toList();
      notifyListeners();
    }
  }

  Future<void> addTask(Task task) async {
    _tasks.add(task);
    await saveTasks();
    notifyListeners();
  }

  Future<void> editTask(Task updatedTask) async {
    final taskIndex = _tasks.indexWhere((task) => task.id == updatedTask.id);
    if (taskIndex >= 0) {
      _tasks[taskIndex] = updatedTask;
      await saveTasks();
      notifyListeners();
    }
  }

  Future<void> deleteTask(String id) async {
    _tasks.removeWhere((task) => task.id == id);
    await saveTasks();
    notifyListeners();
  }

  Future<void> saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final data = json.encode(_tasks.map((task) => {
      'id': task.id,
      'title': task.title,
      'details': task.details,
      'isCompleted': task.isCompleted,
    }).toList());
    prefs.setString('tasks', data);
  }
}
