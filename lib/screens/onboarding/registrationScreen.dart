import 'package:flutter/material.dart';
import 'package:task_manager/api/apiClient.dart';
import 'package:task_manager/style/style.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool isLoading = false;

  Map<String, String> FormValues = {
    "email": "",
    "firstName": "",
    "lastName": "",
    "mobile": "",
    "password": "",
    "photo": "",
    "cpassword": ""
  };

  InputOnChange(MapKey, Textvalue) {
    setState(() {
      FormValues.update(MapKey, (value) => Textvalue);
    });
  }

  FormOnSubmit() async {
    if (FormValues['email']!.length == 0) {
      ErrorToast("email required");
    } else if (FormValues['firstName']!.length == 0) {
      ErrorToast("first name required");
    } else if (FormValues['lastName']!.length == 0) {
      ErrorToast("last name required");
    } else if (FormValues['mobile']!.length == 0) {
      ErrorToast("mobile number required");
    } else if (FormValues['password']!.length == 0) {
      ErrorToast("Password required");
    } else if (FormValues['password'] != FormValues['cpassword']) {
      ErrorToast("Password and Confirm password should be same!");
    } else {
      setState(() {
        isLoading = true;
      });
      bool res = await RegistrationRequest(FormValues);
      if (res == true) {
        Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);
      } else {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        ScreenBackground(context),
        Container(
          alignment: Alignment.center,
            child: isLoading
                ? (Center(
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(colorGreen)
              ),
            ))
            : SingleChildScrollView(
            padding: EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Join With Us", style: Head1Text(colorDarkBlue)),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  onChanged: (Textvalue) {
                    InputOnChange("email", Textvalue);
                  },
                  decoration: AppInputDecoration("Email"),
                  cursorColor: colorDarkBlue,
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  onChanged: (Textvalue) {
                    InputOnChange("firstName", Textvalue);
                  },
                  decoration: AppInputDecoration("First Name"),
                  cursorColor: colorDarkBlue,
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  onChanged: (Textvalue) {
                    InputOnChange("lastName", Textvalue);
                  },
                  decoration: AppInputDecoration("Last Name"),
                  cursorColor: colorDarkBlue,
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  onChanged: (Textvalue) {
                    InputOnChange("mobile", Textvalue);
                  },
                  decoration: AppInputDecoration("Mobile"),
                  cursorColor: colorDarkBlue,
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  onChanged: (Textvalue) {
                    InputOnChange("password", Textvalue);
                  },
                  decoration: AppInputDecoration("Password"),
                  cursorColor: colorDarkBlue,
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  onChanged: (Textvalue) {
                    InputOnChange("cpassword", Textvalue);
                  },
                  decoration: AppInputDecoration("Confirm Password"),
                  cursorColor: colorDarkBlue,
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
                SizedBox(
                  height: 45,
                ),
                InkWell(
                  onTap: (){
                    Navigator.pushNamed(context, "/login");
                  },
                  child: Center(
                      child: RichText(
                        text: new TextSpan(
                          style: new TextStyle(
                            fontFamily: 'poppins',
                            fontSize: 14.0,
                            color: Colors.black,
                          ),
                          children: <TextSpan>[
                            new TextSpan(
                                text: "Have account?",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: colorDarkBlue)),
                            new TextSpan(
                                text: ' Sign In',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, color: colorGreen)),
                          ],
                        ),
                      )
                  ),
                )
              ],
            ),
          ),
        )
      ],
    ));
  }
}
