import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pinput/pinput.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:test_app/phone.dart';
import 'package:http/http.dart';

class EmailOTP extends StatefulWidget {
  final String email;
  const EmailOTP(this.email);

  @override
  State<EmailOTP> createState() => _EmailOTPState(this.email);
}

class _EmailOTPState extends State<EmailOTP> {
  
  String email;
  _EmailOTPState(this.email);

  final FirebaseAuth auth = FirebaseAuth.instance;
  
  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(fontSize: 20, color: Color.fromRGBO(30, 60, 87, 1), fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Color.fromRGBO(234, 239, 243, 1),
      ),
    );

    var smsCode = "";

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(left:25,right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/img1.png',
                 width: 150,
                 height: 150,
              ),
              SizedBox(
                height: 25,
              ),
              Text('Phone verification',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text('We need to register your phone before getting started !',
                  style: TextStyle(
                    fontSize: 16
                  ),
                  textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30,
              ),
              Pinput(
                length: 6,
                showCursor: true,
                onChanged: (value) => smsCode = value,
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
              height: 40,
              width: double.infinity,
              child: ElevatedButton(onPressed: () async {
                var url = 'https://nodemailer-test.onrender.com/verifyotp?email='+email+'&otp='+smsCode;
                var response = await get(Uri.parse(url));
                print(response.body);
                print(response.statusCode);
                if(response.body=="OTP Verified"){
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('OTP Verified')));
                  Navigator.pushNamed(context, 'home');
                }
                else{
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('OTP not Verified')));
                }
              }, child: Text('Verify phone number'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.green.shade600,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                )
              ),
            ),
            TextButton(onPressed: (){
              Navigator.pushNamedAndRemoveUntil(context,'phone',(route)=>false);
            }, child: Text('Edit Phone Number?'),
              style: TextButton.styleFrom(
                primary: Colors.black,
              ),
            ),
            ],
          ),
        ),
      ),
    );
  }
}
