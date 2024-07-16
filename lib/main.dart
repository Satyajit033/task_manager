import 'package:flutter/material.dart';
import 'package:task_manager/screens/onboarding/emailVerificationScreen.dart';
import 'package:task_manager/screens/onboarding/loginScreen.dart';
import 'package:task_manager/screens/onboarding/pinVerificationScreen.dart';
import 'package:task_manager/screens/onboarding/registrationScreen.dart';
import 'package:task_manager/screens/onboarding/setPasswordScreen.dart';
import 'package:task_manager/screens/profile/profileUpdateScreen.dart';
import 'package:task_manager/screens/task/homeScreen.dart';
import 'package:task_manager/screens/task/taskCreateScreen.dart';
import 'package:task_manager/utility/utility.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String? token = await getUserData("token");
  if(token == null){
    runApp(MyApp('/login'));
  }else{
    runApp(MyApp('/'));
  }
}

class MyApp extends StatelessWidget {
  final String firstRoute;
  const MyApp(this.firstRoute);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager',
      debugShowCheckedModeBanner: false,
      initialRoute: firstRoute,
      routes: {
        '/' : (context) => HomeScreen(),
        '/taskCreate' : (context) => TaskCreateScreen(),

        '/emailVerification' : (context) => EmailVerificationScreen(),
        '/login' : (context) => LoginScreen(),
        '/pinVerification' : (context) => PinVerificationScreen(),
        '/registration' : (context) => RegistrationScreen(),
        '/setPassword' : (context) => SetPasswordScreen(),

        '/profileUpdate' : (context) => ProfileUpdateScreen(),

        //'/newTaskList' : (context) => NewTaskList(),
        //'/completedTaskList' : (context) => CompletedTaskList(),
        //'/cancelTaskList' : (context) => CancelTaskList(),
        //'/progressTaskList' : (context) => ProgressTaskList(),
        //'/home' : (context) => HomeScreen(),
      },

    );
  }
}




