
import 'package:flutter/material.dart';
import 'package:task_manager/api/apiClient.dart';
import 'package:task_manager/component/taskList.dart';
import 'package:task_manager/style/style.dart';

class CompletedTaskList extends StatefulWidget {
  const CompletedTaskList({Key? key}) : super(key: key);

  @override
  State<CompletedTaskList> createState() => _CompletedTaskListState();
}

class _CompletedTaskListState extends State<CompletedTaskList> {


  List taskItems = [];
  bool isLoading = true;
  String Status="Completed";

  @override
  initState(){
    CallData();
    super.initState();
  }

  CallData() async {
    var data = await TaskListRequestByStatus("Completed");
    setState(() {
      taskItems = data;
      isLoading = false;
    });
  }

  DeleteItem(id)async{
    showDialog(
      barrierDismissible: false,
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text("Delete!",style: Head6Text(colorDarkBlue)),
            content: Text("once delete,you can not get it back",style: Head7Text(colorLightGray)),
            actions: [
              ElevatedButton(onPressed: () async {
                Navigator.pop(context);
                setState(() {
                  isLoading=true;
                });
                await TaskDeleteRequest(id);
                await CallData();
              }, child: Text("Yes",style:Head7Text(colorRed))),
              ElevatedButton(onPressed: (){
                Navigator.pop(context);
              }, child: Text("No",style: Head7Text(colorGreen)))
            ],
          );
        }
    );
  }

  UpdateStatus(id) async{
    setState(() {isLoading=true;});
    await TaskUpdateRequest(id,Status);
    await CallData();
    setState(() {Status = "Completed";});
  }


  StatusChange(id) async{
    showModalBottomSheet(context: context,
        builder: (context){
          return StatefulBuilder(
              builder: (BuildContext context,StateSetter setState){
                return Container(
                  padding: EdgeInsets.all(30),
                  height: 360,
                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      RadioListTile(title: Text("New"), value: "New", groupValue: Status,activeColor: colorGreen,
                        onChanged: (value){
                          setState(() {
                            Status = value.toString();
                          });
                        },
                      ),
                      RadioListTile(title: Text("Progress"), value: "Progress", groupValue: Status,activeColor: colorGreen,
                        onChanged: (value){
                          setState(() {
                            Status = value.toString();
                          });
                        },
                      ),
                      RadioListTile(title: Text("Completed"), value: "Completed", groupValue: Status,activeColor: colorGreen,
                        onChanged: (value){
                          setState(() {
                            Status = value.toString();
                          });
                        },
                      ),
                      RadioListTile(title: Text("Canceled"), value: "Canceled", groupValue: Status,activeColor: colorGreen,
                        onChanged: (value){
                          setState(() {
                            Status = value.toString();
                          });
                        },
                      ),
                      Container(child: ElevatedButton(
                        style: AppButtonStyle(),
                        child: SuccessButtonChild2('Confirm'),
                        onPressed: (){
                          Navigator.pop(context);
                          UpdateStatus(id);
                        },
                      ),)
                    ],
                  ),
                );
              }
          );
        }
    );
  }


  @override
  Widget build(BuildContext context) {
    return isLoading ? (Center(
      child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(colorGreen)
      ),
    )) : RefreshIndicator(
        color: colorGreen,
        child: taskList(taskItems,DeleteItem,StatusChange),
        onRefresh: ()async{
          await CallData();
        }
    );
  }
}
