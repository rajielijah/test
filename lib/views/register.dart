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
  @override
  Widget build(BuildContext context) {
    double sHeight = MediaQuery.of(context).size.height;
    double sWidth = MediaQuery.of(context).size.width;
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
                    child: Form(child: Column(
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
                        controller:firstNameController,
                        hintText: "First Name",
                      ),
                       SizedBox(
                          height: resHeight(20, sHeight),
                        ),
                      TF(
                        controller: lastNameController,
                        hintText: "Last Name",
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
                      final prefs = await SharedPreferences.getInstance();
                      await  prefs.setString("email", emailController.value.text);
                      await  prefs.setString("firstName", firstNameController.value.text);
                      await  prefs.setString("lastName", lastNameController.value.text);
                     Navigator.of(context).push(MaterialPageRoute(builder: (_)=> const LoginView()));
                      // SharedPreferences 
                    },
                    child: Container(
                      height: resHeight(50, sHeight),
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(8)
                      ),
                      child: const Center(
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
  TextEditingController firstNameController =  TextEditingController(text: '');
  TextEditingController lastNameController =  TextEditingController(text: '');
  // TextEditingController emailController =  TextEditingController(text: '');
  // TextEditingController emailController =  TextEditingController(text: '');
  TextEditingController _passwordController =  TextEditingController(text: '');
}