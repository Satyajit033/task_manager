import 'package:flutter/material.dart';
import 'package:task_manager/api/apiClient.dart';
import 'package:task_manager/style/style.dart';
import 'package:task_manager/utility/utility.dart';

class SetPasswordScreen extends StatefulWidget {
  const SetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<SetPasswordScreen> createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {
  bool isLoading = false;

  Map<String, String> FormValues = {
    "email": "",
    "OTP": "",
    "password": "",
    "cpassword": ""
  };

  @override
  initState() {
    callStoreData();
    super.initState();
  }

  callStoreData() async {
    String? OTP = await getUserData("OTPVerification");
    String? Email = await getUserData("EmailVerification");
    InputOnChange("email", Email);
    InputOnChange("OTP", OTP);
  }

  InputOnChange(MapKey, Textvalue) {
    setState(() {
      FormValues.update(MapKey, (value) => Textvalue);
    });
  }

  FormOnSubmit() async {
    if (FormValues['password']!.length == 0) {
      ErrorToast('Password Required !');
    } else if (FormValues['password'] != FormValues['cpassword']) {
      ErrorToast('Confirm password should be same!');
    } else {
      setState(() {
        isLoading = true;
      });
      bool res = await SetPasswordRequest(FormValues);
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
                      valueColor: AlwaysStoppedAnimation(colorGreen)),
                ))
              : SingleChildScrollView(
                  padding: EdgeInsets.all(30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Set Password", style: Head1Text(colorDarkBlue)),
                      SizedBox(
                        height: 1,
                      ),
                      Text(
                          "Minimum length password 8 character with Latter and number combination",
                          style: Head6Text(colorLightGray)),
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
                        child: SuccessButtonChild2("Confirm"),
                        style: AppButtonStyle(),
                      ),
                      SizedBox(
                        height: 45,
                      ),
                      InkWell(
                        onTap: () {
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
                                      fontWeight: FontWeight.bold,
                                      color: colorGreen)),
                            ],
                          ),
                        )),
                      )
                    ],
                  ),
                ),
        )
      ],
    ));
  }
}
