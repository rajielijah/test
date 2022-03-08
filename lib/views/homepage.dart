import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/size.dart';
import 'package:test/views/register.dart';
import 'package:test/widget/text.dart';

String _email = "";
String _firsName = "";
String _lastName = "";
class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
    @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _email = (prefs.getString('email')??'');
      _firsName = (prefs.getString('firstName')??'');
      _lastName = (prefs.getString('lastName')??'');
    });
  }
  @override
  Widget build(BuildContext context) {
     double sHeight = MediaQuery.of(context).size.height;
    double sWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top:resHeight(58, sHeight)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Center(
                child: TXT(text: "Your Details",
                fontSize: resHeight(20, sHeight),
                textAlign: TextAlign.center,
                  edgeInset: const  EdgeInsets.all(0),
                ),
              )
            ),
            SizedBox(height: resHeight(30, sHeight),),
            Container(
              padding: EdgeInsets.only(
              left: resHeight(20, sHeight),
              right: resHeight(20, sHeight)),
              child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TXT(text: "Email :",),
                TXT(text: _email,),
            SizedBox(height: resHeight(30, sHeight),),
              TXT(text: "First Name :",),
              TXT(text: _firsName),
             SizedBox(height: resHeight(30, sHeight),),
              TXT(text: "Last Name :",),
              TXT(text: _lastName)
              ],
            )),
          SizedBox(height: resHeight(30, sHeight),),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: GestureDetector(
              onTap: () async{
                Navigator.of(context).push(MaterialPageRoute(builder: (_)=> const RegisterView()));
                // SharedPreferences 
              },
              child: Container(
                height: resHeight(50, sHeight),
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(8)
                ),
                child: const Center(
                  child: Text("Input Another Details"),
                ),
              ),
            ),
          ),
          ],
        ),
      ),
    );
  }
}