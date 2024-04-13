import 'package:database/screens/edit_task_screen.dart';
import 'package:database/data/task.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// ignore: must_be_immutable
class TaskWidget extends StatefulWidget {
  TaskWidget({super.key, required this.task});
  Task task;

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  bool isBoxChecked = false;

  @override
  void initState() {
    super.initState();
    isBoxChecked = widget.task.isDone;
  }

  @override
  Widget build(BuildContext context) {
    return getTaskItem();
  }

  Widget getTaskItem() {
    return GestureDetector(
      onTap: () {
        setState(() {
          isBoxChecked = !isBoxChecked;
          widget.task.isDone = isBoxChecked;
          widget.task.save();
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 25,
          vertical: 15,
        ),
        height: MediaQuery.of(context).size.height * 0.16,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xffffffff),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: EdgeInsets.all(12),
          child: getMainContent(),
        ),
      ),
    );
  }

  Row getMainContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Transform.scale(
                    scale: 1.4,
                    child: Checkbox(
                      checkColor: Colors.white,
                      activeColor: Color(0xff18DAA3),
                      value: isBoxChecked,
                      onChanged: (isChacked) {},
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                    ),
                  ),
                  Text(
                    widget.task.title,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontFamily: 'SM',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.001),
              Directionality(
                textDirection: TextDirection.rtl,
                child: Text(
                  widget.task.subTitle,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(fontFamily: 'SM', fontSize: 12),
                ),
              ),
              Spacer(),
              getTimeAndEditBadgs(),
            ],
          ),
        ),
        SizedBox(width: MediaQuery.of(context).size.width * 0.01),
        Image.asset(widget.task.taskType.image),
      ],
    );
  }

  LayoutBuilder getTimeAndEditBadgs() {
    return LayoutBuilder(
      builder: (context, constraints) {
        double width = constraints.maxWidth;
        return Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.20,
              height: MediaQuery.of(context).size.height * 0.035,
              decoration: BoxDecoration(
                color: Color(0xff18DAA3),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${widget.task.time.hour}:${getMinUnderTen(widget.task.time)}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontFamily: 'SM',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: width * 0.025),
                  Image.asset(
                    'images/icon_time.png',
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                ],
              ),
            ),
            SizedBox(width: width * 0.05),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => EditTaskScreen(
                      task: widget.task,
                    ),
                  ),
                );
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.20,
                height: MediaQuery.of(context).size.height * 0.035,
                decoration: BoxDecoration(
                  color: Color(0xffE2F6F1),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'ویرایش',
                      style: TextStyle(
                        color: Color(0xff18DAA3),
                        fontSize: 12,
                        fontFamily: 'SM',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: width * 0.025),
                    Image.asset(
                      'images/icon_edit.png',
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  String getMinUnderTen(DateTime time) {
    if (time.minute < 10) {
      return '0${time.minute}';
    } else {
      return time.minute.toString();
    }
  }
}
