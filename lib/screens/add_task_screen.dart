import 'package:database/widget/task_type_item.dart';
import 'package:time_pickerr/time_pickerr.dart';
import 'package:database/utility/utility.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:database/data/task.dart';
import 'package:flutter/material.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController controllerTasksubTitle = TextEditingController();
  final TextEditingController controllerTaskTitle = TextEditingController();

  final box = Hive.box<Task>('taskBox');

  int _selectedTaskTypeItemList = 0;

  DateTime? _time;

  FocusNode negahban1 = FocusNode();
  FocusNode negahban2 = FocusNode();

  @override
  void initState() {
    super.initState();
    negahban1.addListener(() {
      setState(() {});
    });
    negahban2.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 44),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: TextField(
                  controller: controllerTaskTitle,
                  focusNode: negahban1,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    labelText: '  عنوان تسک  ',
                    labelStyle: TextStyle(
                      fontFamily: 'SM',
                      fontSize: 20,
                      color: negahban1.hasFocus
                          ? Color(0xff18DAA3)
                          : Color(0xffC5C5C5),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide(
                        color: Color(0xffC5C5C5),
                        width: 3.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide(
                        color: Color(0xff18DAA3),
                        width: 3.0,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 44),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: TextField(
                  controller: controllerTasksubTitle,
                  focusNode: negahban2,
                  maxLines: 3,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    labelText: '  توضیحات متن تسک  ',
                    labelStyle: TextStyle(
                      fontFamily: 'SM',
                      fontSize: 20,
                      color: negahban2.hasFocus
                          ? Color(0xff18DAA3)
                          : Color(0xffC5C5C5),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide(
                        color: Color(0xffC5C5C5),
                        width: 3.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide(
                        color: Color(0xff18DAA3),
                        width: 3.0,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: CustomHourPicker(
                title: 'انتخاب زمان',
                titleStyle: TextStyle(
                  fontFamily: 'SM',
                  fontSize: 18,
                  color: Color(0xff18DAA3),
                ),
                negativeButtonText: 'حذف',
                negativeButtonStyle: TextStyle(
                  fontFamily: 'SM',
                  color: Colors.red,
                  fontSize: 18,
                ),
                positiveButtonText: 'انتخاب',
                positiveButtonStyle: TextStyle(
                  fontFamily: 'SM',
                  fontSize: 18,
                  color: Color(0xff18DAA3),
                ),
                onPositivePressed: (context, time) {
                  _time = time;
                },
                onNegativePressed: (context) {
                  Navigator.of(context).pop();
                },
                elevation: 0,
              ),
            ),
            Container(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: getTaskTypeList().length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        _selectedTaskTypeItemList = index;
                      });
                    },
                    child: taskTypeItemList(
                      taskType: getTaskTypeList()[index],
                      index: index,
                      selectedItemList: _selectedTaskTypeItemList,
                    ),
                  );
                },
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff18DAA3),
                  minimumSize: Size(200, 45),
                ),
                onPressed: () {
                  String taskSubTitle = controllerTasksubTitle.text;
                  String taskTitle = controllerTaskTitle.text;
                  addTask(taskTitle, taskSubTitle);
                  Navigator.of(context).pop();
                },
                child: Text(
                  'اضافه کردن تسک',
                  style: TextStyle(
                    fontFamily: 'SM',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  addTask(String taskTitle, String taskSubTitle) {
    var task = Task(
      title: taskTitle,
      subTitle: taskSubTitle,
      time: _time!,
      taskType: getTaskTypeList()[_selectedTaskTypeItemList],
    );
    box.add(task);
  }
}
