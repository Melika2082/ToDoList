import 'package:database/data/task_type.dart';
import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 1)
class Task extends HiveObject {
  Task({
    required this.title,
    required this.subTitle,
    required this.time,
    required this.taskType,
    this.isDone = false,
  });

  @HiveField(0)
  String title;

  @HiveField(1)
  String subTitle;

  @HiveField(2)
  bool isDone;

  @HiveField(3)
  DateTime time;

  @HiveField(4)
  TaskType taskType;
}
