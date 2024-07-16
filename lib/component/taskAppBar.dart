
import 'package:flutter/material.dart';
import 'package:task_manager/style/style.dart';
import 'package:task_manager/utility/utility.dart';

AppBar TaskAppBar(context,ProfileData){
  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: colorGreen,
    flexibleSpace: Container(
      margin: EdgeInsets.fromLTRB(10, 40, 10, 0),
      child: Row(
        children: [
            CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 24,
              child: ClipOval(
                child: Image.memory(ShowBase64Img(ProfileData["photo"])),
              ),
            ),
            SizedBox(width: 10,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${ProfileData["firstName"]} ${ProfileData["lastName"]}",style: Head6Text(colorWhite),),
                Text(ProfileData["email"],style: Head7Text(colorWhite),)
              ],
            )
        ],
      ),
    ),
    actions: [
      IconButton(
          onPressed: () async {
              await RemoveToken();
              Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);
          },
          icon: Icon(Icons.output_outlined,color: colorWhite,)
      )
    ],

  );
}