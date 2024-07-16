
import 'package:flutter/material.dart';
import 'package:task_manager/component/appBottomNav.dart';
import 'package:task_manager/component/cancelTaskList.dart';
import 'package:task_manager/component/completedTaskList.dart';
import 'package:task_manager/component/newTaskList.dart';
import 'package:task_manager/component/progressTaskList.dart';
import 'package:task_manager/component/taskAppBar.dart';
import 'package:task_manager/style/style.dart';
import 'package:task_manager/utility/utility.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int bottomTabIndex = 0;

  onItemTap(int index){
    setState(() {
      bottomTabIndex = index;
    });
  }

  Map<String, String> ProfileData = {
    "email": "",
    "firstName": "",
    "lastName": "",
    "photo": appBarDefaultPhoto
  };

  ReadAppBarData() async {
    String? email = await getUserData("email");
    String? firstName = await getUserData("firstName");
    String? lastName = await getUserData("lastName");
    String? photo = await getUserData("photo");

    setState(() {
      ProfileData = {
        "email": "$email",
        "firstName": "$firstName",
        "lastName": "$lastName",
        "photo": "$photo"
      };
    });
  }


  @override
  void initState() {
    ReadAppBarData();
    super.initState();
  }


  final widgetOptions=[
    NewTaskList(),
    CompletedTaskList(),
    CancelTaskList(),
    ProgressTaskList()

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TaskAppBar(context,ProfileData),
      body:Stack(
        children: [
          ScreenBackground(context),
          widgetOptions.elementAt(bottomTabIndex),
        ],
      ),
      bottomNavigationBar: appBottomNav(bottomTabIndex,onItemTap),
      floatingActionButton: Padding(
          padding: EdgeInsets.all(5),
          child: FloatingActionButton(
            onPressed: (){
              Navigator.pushNamed(context, '/taskCreate');
            },
            backgroundColor: colorGreen,
            shape: CircleBorder(),
            elevation: 10,
            child: Icon(Icons.add,color: Colors.white,size: 30,),
          ),
        )
    );
  }
}
