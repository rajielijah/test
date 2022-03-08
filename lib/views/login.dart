import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/size.dart';
import 'package:test/views/homepage.dart';
import 'package:test/views/register.dart';
import 'package:test/widget/text.dart';
import 'package:test/widget/textfield.dart';


class LoginView extends StatefulWidget {
  const LoginView({ Key? key }) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
                    child: Form(child: Column(
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
                      final prefs = await SharedPreferences.getInstance();
                      await  prefs.setString("email", emailController.value.text);
                      Navigator.of(context).push(MaterialPageRoute(builder: (_) => HomePage()));
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

  TextEditingController _passwordController =  TextEditingController(text: '');
}