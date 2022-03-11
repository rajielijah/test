import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:test/size.dart';
import 'package:test/views/login.dart';
import 'package:test/views/register.dart';
import 'package:test/widget/text.dart';
import 'package:test/widget/textfield.dart';
import 'package:http/http.dart' as http;


class UserExitView extends StatefulWidget {
  const UserExitView({ Key? key }) : super(key: key);

  @override
  _UserExitViewState createState() => _UserExitViewState();
}

class _UserExitViewState extends State<UserExitView> {
  bool isloading = false;
  @override
  Widget build(BuildContext context) {
     double sHeight = MediaQuery.of(context).size.height;
    double sWidth = MediaQuery.of(context).size.width;
     Future<Map<String, dynamic>> getUser(String email) async {
       isloading = true;
      var headers = {
        'Content-Type': 'application/json'
      };
      var request = http.Request('GET',
          Uri.parse('https://api.wowcatholic.org/dating/user-exist?system=WebAPI&key=Web45k87u23bNR64g094h5wFWa9v56Q1L&email=$email'));
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        isloading = false;
         var responseData = await http.Response.fromStream(response);
        final result = jsonDecode(responseData.body);
        if(result["status"] == "OK"){
        final result = jsonDecode(responseData.body);
        successAlertDialog(context);
        return result;
        }
        else {
        final result = jsonDecode(responseData.body);
        failAlertDialog(context);
        return result;
        }
      }
      else{
        var responseData = await http.Response.fromStream(response);
        final result = jsonDecode(responseData.body);
        isloading = false;
        return result;
      }
    }
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Center(
                child: TXT(text: "Verify User",
                textAlign: TextAlign.center,
                  edgeInset: const  EdgeInsets.all(0),
                ),
              )
            ),
            SizedBox(
              height: resHeight(79, sHeight),
            ),
            Expanded(child: ListView(
              children: [
                Container(
                  padding: EdgeInsets.only(
                    left: resHeight(20, sHeight),
                    right: resHeight(20, sHeight)),
                    child: Form(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                            height: resHeight(76, sHeight),
                          ),
                        TXT(
                          text: "Verify,",
                          fontWeight: FontWeight.bold,
                          fontSize: resHeight(27, sHeight),
                        ),
                        SizedBox(
                          height: resHeight(30, sHeight),
                        ),
                      TF(
                        controller: emailController,
                        hintText: "Email",
                      ),
                       SizedBox(
                          height: resHeight(20, sHeight),
                        ),
                    
                      ],
                    ))
                ),
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: GestureDetector(
                    onTap: () async {
                      getUser(emailController.value.text);
                    },
                    child: Container(
                      height: resHeight(50, sHeight),
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(8)
                      ),
                      child: isloading ? const Center(
                        child: CircularProgressIndicator(color: Colors.white,),
                      ) : const Center(
                        child: Text("Login"),
                      ),
                    ),
                  ),
                ),
               
              ],
            ))
          ],
        ),
      ),
    );
  }
final _formKey = GlobalKey<FormState>();

  TextEditingController emailController =  TextEditingController(text: '');

  failAlertDialog(BuildContext context) {
     Widget okButton = FlatButton(  
    child: const Text("Sign Up"),  
    onPressed: () {  
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => RegisterView()));  
    },  
  );  
  AlertDialog alert = AlertDialog(  
    title: const Text("No record"),  
    content: const Text("Kindly Sign up."),  
    actions: [  
      okButton,  
    ],  
  );  
  showDialog(  
    context: context,  
    builder: (BuildContext context) {  
      return alert;  
    },  
  );  
  }
 successAlertDialog(BuildContext context) {
     Widget okButton = FlatButton(  
    child: const Text("Login"),  
    onPressed: () {  
      Navigator.of(context).push(MaterialPageRoute(builder: (_)=> LoginView()));  
    },  
  );  
  AlertDialog alert = AlertDialog(  
    title: const Text("Your email has been verified"),  
    content: const Text("Kindly Sign in."),  
    actions: [  
      okButton,  
    ],  
  );  
  showDialog(  
    context: context,  
    builder: (BuildContext context) {  
      return alert;  
    },  
  );  
  }
}