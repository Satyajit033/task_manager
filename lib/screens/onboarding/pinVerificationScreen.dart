import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager/api/apiClient.dart';
import 'package:task_manager/style/style.dart';
import 'package:task_manager/utility/utility.dart';

class PinVerificationScreen extends StatefulWidget {
  const PinVerificationScreen({Key? key}) : super(key: key);

  @override
  State<PinVerificationScreen> createState() => _PinVerificationScreenState();
}

class _PinVerificationScreenState extends State<PinVerificationScreen> {

  bool isLoading = false;

  Map<String, String> FormValues = {"otp": ""};

  InputOnChange(MapKey, Textvalue) {
    setState(() {
      FormValues.update(MapKey, (value) => Textvalue);
    });
  }

  FormOnSubmit() async {
    if (FormValues['otp']!.length != 6) {
      ErrorToast("OTP required");
    } else {
      setState(() {
        isLoading = true;
      });
      String? emailAddress=await getUserData('EmailVerification');
      bool res = await VerifyOTPRequest(emailAddress,FormValues["otp"]);
      if (res == true) {
        Navigator.pushNamed(context, "/setPassword");
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
                    Text("PIN Verification",style: Head1Text(colorDarkBlue)),
                    const SizedBox(height: 1,),
                    Text("A 6 digit verification pin will send to your email address",style: Head6Text(colorLightGray)),
                    SizedBox(height: 20,),
                    PinCodeTextField(
                        appContext: context,
                        length: 6,
                        pinTheme: AppOTPStyle(),
                        animationType: AnimationType.fade,
                        animationDuration: Duration(milliseconds: 300),
                        enableActiveFill: true,
                        onCompleted: (v) {

                        },
                        onChanged: (value) {
                         InputOnChange("otp",value);
                        }
                    ),
                    SizedBox(height: 20,),
                    ElevatedButton(onPressed: (){
                      FormOnSubmit();
                    }, child:SuccessButtonChild2("Verify"),style: AppButtonStyle(),),
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
