import 'package:database/widget/task_type_item.dart';
import 'package:time_pickerr/time_pickerr.dart';
import 'package:database/utility/utility.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:database/data/task.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class EditTaskScreen extends StatefulWidget {
  EditTaskScreen({super.key, required this.task});
  Task task;

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  TextEditingController? controllerTasksubTitle;
  TextEditingController? controllerTaskTitle;

  final box = Hive.box<Task>('taskBox');

  int _selectedTaskTypeItemList = 0;

  FocusNode negahban1 = FocusNode();
  FocusNode negahban2 = FocusNode();

  DateTime? _time;

  @override
  void initState() {
    super.initState();

    controllerTasksubTitle = TextEditingController(text: widget.task.subTitle);
    controllerTaskTitle = TextEditingController(text: widget.task.title);

    negahban1.addListener(() {
      setState(() {});
    });
    negahban2.addListener(() {
      setState(() {});
    });

    var index = getTaskTypeList().indexWhere(
      (element) => element.taskTypeEnum == widget.task.taskType.taskTypeEnum,
    );

    _selectedTaskTypeItemList = index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
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
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextField(
                    controller: controllerTasksubTitle,
                    focusNode: negahban2,
                    maxLines: 10,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      labelText: '  توضیحات تسک  ',
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
                margin: EdgeInsets.symmetric(horizontal: 10),
                height: MediaQuery.of(context).size.height * 0.23,
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
              Padding(
                padding: const EdgeInsets.only(bottom: 10, top: 20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff18DAA3),
                    minimumSize: Size(200, 45),
                  ),
                  onPressed: () {
                    String taskSubTitle = controllerTasksubTitle!.text;
                    String taskTitle = controllerTaskTitle!.text;
                    editTask(taskTitle, taskSubTitle);
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'ویرایش کردن تسک',
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
      ),
    );
  }

  editTask(String taskTitle, String taskSubTitle) {
    widget.task.subTitle = taskSubTitle;
    widget.task.title = taskTitle;
    widget.task.time = _time!;
    widget.task.taskType = getTaskTypeList()[_selectedTaskTypeItemList];
    widget.task.save();
  }
}
