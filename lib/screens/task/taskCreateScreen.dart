import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/api/apiClient.dart';
import 'package:task_manager/component/taskAppBar.dart';
import 'package:task_manager/style/style.dart';
import 'package:task_manager/utility/utility.dart';

class TaskCreateScreen extends StatefulWidget {
  const TaskCreateScreen({Key? key}) : super(key: key);

  @override
  State<TaskCreateScreen> createState() => _TaskCreateScreenState();
}

class _TaskCreateScreenState extends State<TaskCreateScreen> {
  bool isLoading = false;

  Map<String, String> FormValues = {
    "title": "",
    "description": "",
    "status": "New"
  };

  InputOnChange(MapKey, Textvalue) {
    setState(() {
      FormValues.update(MapKey, (value) => Textvalue);
    });
  }

  FormOnSubmit() async {
    if (FormValues['title']!.length == 0) {
      ErrorToast("title required!");
    } else if (FormValues['description']!.length == 0) {
      ErrorToast("description required!");
    } else {
      setState(() {
        isLoading = true;
      });
      bool res = await TaskCreateRequest(FormValues);
      if (res == true) {
        Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
      } else {
        setState(() {
          isLoading = false;
        });
      }
    }
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: TaskAppBar(context,ProfileData),
        body: Stack(
      children: [
        ScreenBackground(context),
        Container(
          alignment: Alignment.center,
          child: isLoading
              ? (Center(
                  child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(colorGreen)),
                ))
              : SingleChildScrollView(
                  padding: EdgeInsets.all(30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Add New Task", style: Head1Text(colorDarkBlue)),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        onChanged: (Textvalue) {
                          InputOnChange("title", Textvalue);
                        },
                        decoration: AppInputDecoration("Title"),
                        cursorColor: colorDarkBlue,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        onChanged: (Textvalue) {
                          InputOnChange("description", Textvalue);
                        },
                        decoration: AppInputDecoration(
                          "Description",
                        ),
                        cursorColor: colorDarkBlue,
                        maxLines: 10,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          FormOnSubmit();
                        },
                        child: SuccessButtonChild(Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: colorWhite,
                        )),
                        style: AppButtonStyle(),
                      ),
                    ],
                  ),
                ),
        )
      ],
    ));
  }
}
