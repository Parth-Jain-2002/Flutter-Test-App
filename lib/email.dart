
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart';
import 'package:test_app/emailotp.dart';


class EmailWidget extends StatefulWidget {
  const EmailWidget({super.key});

  static String verify = "";

  @override
  State<EmailWidget> createState() => _EmailWidgetState();
}

class _EmailWidgetState extends State<EmailWidget> {
  var _recipientController = TextEditingController();
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              Text('Email verification',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text('We need to register your email before getting started !',
                  style: TextStyle(
                    fontSize: 16
                  ),
                  textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                padding: EdgeInsets.only(left: 20),
                height:55,
                decoration: BoxDecoration(
                  border: Border.all(width:1,color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child:Expanded(
                      child: TextField(
                        controller: _recipientController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Email',
                          hintStyle: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ),
                    )
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
              height: 40,
              width: double.infinity,
              child: ElevatedButton(onPressed: () async {
                print(_recipientController.text);
                var url = 'https://nodemailer-test.onrender.com/sendmail?to='+_recipientController.text;
                var response = await get(Uri.parse(url));
                print(response.body);
                if(response.body=="Email sent"){
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('OTP sent to your email')));
                  Navigator.push(context,MaterialPageRoute(builder: (context)=> EmailOTP(_recipientController.text)));
                }
                else{
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error sending OTP')));
                }
              }, child: Text('Send the OTP'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.green.shade600,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                )
              ),
            )
            ],
          ),
        ),
      ),
    );
  }
}