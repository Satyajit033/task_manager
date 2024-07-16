import 'package:flutter/material.dart';
import 'package:task_manager/api/apiClient.dart';
import 'package:task_manager/style/style.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  Map<String, String> FormValues = {"email": "", "password": ""};
  bool isLoading = false;

  InputOnChange(MapKey, Textvalue) {
    setState(() {
      FormValues.update(MapKey, (value) => Textvalue);
    });
  }

  FormOnSubmit() async {
    if (FormValues['email']!.length == 0) {
      ErrorToast("email required");
    } else if (FormValues['password']!.length == 0) {
      ErrorToast("password required");
    } else {
      setState(() {isLoading = true;});
      bool res = await LoginRequest(FormValues);
      if (res == true) {
        Navigator.pushNamedAndRemoveUntil(context,"/", (route) => false);
      }
      else {
        setState(() {isLoading = false;});
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
                      Text("Get Started With", style: Head1Text(colorDarkBlue)),
                      SizedBox(
                        height: 30,
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
                          InputOnChange("password", Textvalue);
                        },
                        decoration: AppInputDecoration("Password"),
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
                        onTap: () {
                          Navigator.pushNamed(context, "/emailVerification");
                        },
                        child: Center(
                            child: Text("Forget Password?",
                                style: Head7Text(
                                  colorLightGray,
                                ))),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: (){
                        Navigator.pushNamed(context, "/registration");
                      },
                        child:Center(
                            child: RichText(
                              text: new TextSpan(
                                style: new TextStyle(
                                  fontFamily: 'poppins',
                                  fontSize: 14.0,
                                  color: Colors.black,
                                ),
                                children: <TextSpan>[
                                  new TextSpan(
                                      text: "Don't have account?",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: colorDarkBlue)),
                                  new TextSpan(
                                      text: ' Sign Up',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: colorGreen)),
                                ],
                              ),
                            )
                        )
                      )
                    ],
                  ),
                ),
        )
      ],
    ));
  }
}
