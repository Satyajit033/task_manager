
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/style/style.dart';

ListView taskList(taskItems,DeleteItem,StatusChange){
  return ListView.builder(
    itemCount: taskItems.length,
    itemBuilder: (context,index){

      Color statusColor ;
      if(taskItems[index]['status']=="New"){
        statusColor = colorBlue;

      }else if(taskItems[index]['status']=="Progress"){
        statusColor = colorOrange;

      }else if(taskItems[index]['status']=="Canceled"){
        statusColor = colorRed;
      }else{
        statusColor = colorGreen;
      }

      return Card(
        elevation: 1,
        child: itemSizeBox(
         Column(
           mainAxisAlignment: MainAxisAlignment.start,
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Text(taskItems[index]['title'],style: Head6Text(colorDarkBlue)),
             Text(taskItems[index]['description'],style: Head7Text(colorLightGray),),
             Text(taskItems[index]['createdDate'],style: Head9Text(colorDarkBlue),),
             SizedBox(height: 10,),
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 StatusChild(taskItems[index]['status'],statusColor),
                 Container(
                   child: Row(
                     children: [
                       SizedBox(
                         width: 50,
                         height: 30,
                         child: ElevatedButton(
                             onPressed: (){
                               StatusChange(taskItems[index]["_id"]);
                             },
                             child: Icon(Icons.edit,size: 16,),
                           style: AppStatusButtonStyle(colorGreen),
                         ),
                       ),
                       SizedBox(width: 10,),
                       SizedBox(
                         width: 50,
                         height: 30,
                         child: ElevatedButton(
                             onPressed: (){
                               DeleteItem(taskItems[index]["_id"]);
                             },
                               child:Icon(Icons.delete,size: 16,),
                           style: AppStatusButtonStyle(colorRed),
                         ),
                       )
                     ],
                   ),
                 )
               ],
             )
           ],
         )
        )
      );
    },
  );
}