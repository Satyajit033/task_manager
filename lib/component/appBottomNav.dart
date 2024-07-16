

import 'package:flutter/material.dart';
import 'package:task_manager/style/style.dart';

BottomNavigationBar appBottomNav(index,onItemTap){
  return BottomNavigationBar(
      items: [
          BottomNavigationBarItem(icon:Icon(Icons.list_alt_outlined),label:"New Task",),
          BottomNavigationBarItem(icon:Icon(Icons.check_circle_outline),label:"Completed"),
          BottomNavigationBarItem(icon:Icon(Icons.cancel_outlined),label:"Canceled"),
          BottomNavigationBarItem(icon:Icon(Icons.alarm_outlined),label:"Progress"),
      ],

    selectedItemColor: colorGreen,
    unselectedItemColor: colorLightGray,
    showSelectedLabels: true,
    showUnselectedLabels: true,
    currentIndex: index,
    onTap: onItemTap,
    type: BottomNavigationBarType.fixed,
  );

}