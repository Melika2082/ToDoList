import 'package:database/data/task_type.dart';
import 'package:database/data/type_enum.dart';

List<TaskType> getTaskTypeList() {
  var list = [
    TaskType(
      image: 'images/meditate.png',
      title: 'استراحت',
      taskTypeEnum: TaskTypeEnum.focus,
    ),
    TaskType(
      image: 'images/social_frends.png',
      title: 'دورهمی',
      taskTypeEnum: TaskTypeEnum.date,
    ),
    TaskType(
      image: 'images/hard_working.png',
      title: 'کار کردن',
      taskTypeEnum: TaskTypeEnum.working,
    ),
    TaskType(
      image: 'images/banking.png',
      title: 'پرداخت',
      taskTypeEnum: TaskTypeEnum.working,
    ),
    TaskType(
      image: 'images/work_meeting.png',
      title: 'قرار کاری',
      taskTypeEnum: TaskTypeEnum.working,
    ),
    TaskType(
      image: 'images/workout.png',
      title: 'ورزش و تفریح',
      taskTypeEnum: TaskTypeEnum.date,
    ),
  ];

  return list;
}
