import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/size.dart';
import 'package:test/views/homepage.dart';
import 'package:test/views/register.dart';
import 'package:test/widget/text.dart';
import 'package:test/widget/textfield.dart';
import 'package:http/http.dart' as http;


class LoginView extends StatefulWidget {
  const LoginView({ Key? key }) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool isloading = false;
  @override
  Widget build(BuildContext context) {
    double sHeight = MediaQuery.of(context).size.height;
    double sWidth = MediaQuery.of(context).size.width;
    Future<Map<String, dynamic>> login(String email, String username, 
          String password,
     ) async {
       isloading = true;
      var headers = {
        'Content-Type': 'application/json'
      };
      var request = http.Request('POST',
          Uri.parse('https://api.wowcatholic.org/dating/auth/login?system=WebAPI&key=Web45k87u23bNR64g094h5wFWa9v56Q1L'));
      request.body = json.encode({"email" : email, "username": username, "password": password,
      });
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
      body: Container(
        padding: EdgeInsets.only(top:resHeight(58, sHeight)),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Center(
                child: TXT(text: "Login",
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
                    child: Form(
                      key: _formKey,
                      child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                            height: resHeight(76, sHeight),
                          ),
                        TXT(
                          text: "Welcome back,",
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
                      TF(
                        controller: usernameController,
                        hintText: "Username",
                      ), 
                    SizedBox(
                          height: resHeight(20, sHeight),
                        ),
                      TF(
                        controller:_passwordController,
                        hintText: "Password",
                      )
                      ],
                    ))
                ),
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: GestureDetector(
                    onTap: () async {
                      login(emailController.value.text, usernameController.value.text, _passwordController.value.text);
                    },
                    child: Container(
                      height: resHeight(50, sHeight),
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(8)
                      ),
                      child: const Center(
                        child: Text("Login"),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      top: resHeight(40, sHeight)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TXT(
                        text: "New User?",
                        fontSize: resHeight(14, sHeight),
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (_)=> const RegisterView()));
                        },
                        child: TXT(
                            text: " Create Account",
                            fontSize: resHeight(14, sHeight),
                      ))
                    ],
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
  TextEditingController usernameController =  TextEditingController(text: '');
  TextEditingController _passwordController =  TextEditingController(text: '');
  
failAlertDialog(BuildContext context) {
     Widget okButton = FlatButton(  
    child: const Text("Login"),  
    onPressed: () {  
      Navigator.of(context).pop();  
    },  
  );  
  AlertDialog alert = AlertDialog(  
    title: const Text("No record"),  
    content: const Text("Wrong username/email or Password."),  
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
    child: const Text("Ok"),  
    onPressed: () {  
      Navigator.of(context).pop();  
    },  
  );  
  AlertDialog alert = AlertDialog(  
    title: const Text("Successful"),  
    content: const Text("You have logged in successfully"),  
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