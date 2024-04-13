import 'package:database/data/task_type.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class taskTypeItemList extends StatelessWidget {
  taskTypeItemList({
    super.key,
    required this.taskType,
    required this.index,
    required this.selectedItemList,
  });

  TaskType taskType;

  int selectedItemList;
  int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      width: MediaQuery.of(context).size.width * 0.35,
      decoration: BoxDecoration(
        color: (selectedItemList == index) ? Color(0xff18DAA3) : Colors.white,
        border: Border.all(
          color: (selectedItemList == index) ? Color(0xff18DAA3) : Colors.grey,
          width: (selectedItemList == index) ? 3 : 2,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Column(
        children: [
          Image.asset(taskType.image),
          Text(
            taskType.title,
            style: TextStyle(
              fontFamily: 'SM',
              fontSize: (selectedItemList == index) ? 20 : 18,
              color: (selectedItemList == index) ? Colors.white : Colors.black,
              fontWeight: (selectedItemList == index)
                  ? FontWeight.bold
                  : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
