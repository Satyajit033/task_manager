import 'package:flutter/material.dart';
import 'package:task_manager/api/apiClient.dart';
import 'package:task_manager/style/style.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({Key? key}) : super(key: key);

  @override
  State<EmailVerificationScreen> createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {

  bool isLoading = false;

  Map<String, String> FormValues = {"email": ""};

  InputOnChange(MapKey, Textvalue) {
    setState(() {
      FormValues.update(MapKey, (value) => Textvalue);
    });
  }

  FormOnSubmit() async {
    if (FormValues['email']!.length == 0) {
      ErrorToast("email required");
    } else {
      setState(() {
        isLoading = true;
      });
      bool res = await VerifyEmailRequest(FormValues["email"]);
      if (res == true) {
        Navigator.pushNamed(context, "/pinVerification");
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
                )) : SingleChildScrollView(
                padding: EdgeInsets.all(30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Your Email Address",style: Head1Text(colorDarkBlue)),
                    SizedBox(height: 1,),
                    Text("A 6 digit verification pin will send to your email address",style: Head6Text(colorLightGray)),
                    SizedBox(height: 20,),
                    TextFormField(
                      onChanged: (Textvalue) {
                        InputOnChange("email", Textvalue);
                      },
                      decoration: AppInputDecoration("Email"),
                      cursorColor: colorDarkBlue,
                    ),
                    SizedBox(height: 20,),
                    ElevatedButton(onPressed: (){
                      FormOnSubmit();
                    }, child:SuccessButtonChild(Icon(Icons.arrow_forward_ios_rounded,color:colorWhite,)),style: AppButtonStyle(),),
                    SizedBox(height: 45,),
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
        )
    );
  }
}
