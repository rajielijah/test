import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/size.dart';
import 'package:test/views/login.dart';
import 'package:test/widget/text.dart';
import 'package:test/widget/textfield.dart';


class RegisterView extends StatefulWidget {
  const RegisterView({ Key? key }) : super(key: key);

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  bool isloading = false;
  @override
  Widget build(BuildContext context) {
    double sHeight = MediaQuery.of(context).size.height;
    double sWidth = MediaQuery.of(context).size.width;
     Future<Map<String, dynamic>> register(String email, String phone, String username, 
          String password,
     ) async {
       isloading = true;
      var headers = {
        'Content-Type': 'application/json'
      };
      var request = http.Request('POST',
          Uri.parse('https://api.wowcatholic.org/dating/auth/signup?system=WebAPI&key=Web45k87u23bNR64g094h5wFWa9v56Q1L'));
      request.body = json.encode({"email" : email, "phone": phone, "username": username, "password": password,
                          "progress": {"NEXTSTEP": "PROFILE_UPDATE"}              
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
        print(result);
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
                child: TXT(text: "Register",
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
                        TXT(
                          text: "Register",
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
                        controller:userNameController,
                        hintText: "UserName",
                      ),
                       SizedBox(
                          height: resHeight(20, sHeight),
                        ),
                      TF(
                        keyboardType: TextInputType.number,
                        controller: phoneNoController,
                        hintText: "Phone Number",
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
                SizedBox(height: resHeight(40, sHeight),),
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: GestureDetector(
                    onTap: () async{
                      register(emailController.value.text, phoneNoController.value.text, 
                      userNameController.value.text, _passwordController.value.text);
                    },
                    child: Container(
                      height: resHeight(50, sHeight),
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(8)
                      ),
                      child: isloading ? const Center(
                        child: CircularProgressIndicator(color: Colors.white,),
                      )  :Center(
                        child: Text("Sign Up"),
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
                        text: "Already Have an Account?",
                        fontSize: resHeight(14, sHeight),
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (_)=> const LoginView()));
                        },
                        child: TXT(
                            text: " Login",
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
  TextEditingController userNameController =  TextEditingController(text: '');
  TextEditingController phoneNoController =  TextEditingController(text: '');
  TextEditingController _passwordController =  TextEditingController(text: '');

failAlertDialog(BuildContext context) {
     Widget okButton = FlatButton(  
    child: const Text("Sign Up"),  
    onPressed: () {  
      Navigator.of(context).pop();
    },  
  );  
  AlertDialog alert = AlertDialog(  
    title: const Text("No record"),  
    content: const Text("Kindly Sign up with correct details"),  
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
    title: const Text("Your have successfully registered"),  
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