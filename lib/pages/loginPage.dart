import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

Widget socialLogo(String asset) {
  return Padding(padding: EdgeInsets.all(5),
    child:Container(
      height: 50,
      width: 100,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(15))

        ),
        child: Center(
          child: Image(
            image: AssetImage(asset),
          ),
        ),
      ),
    )
    );

}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.cyan,
          body: Column(
            children:  [
              SizedBox(height: 40,),
              Center(
                child: Image(image: AssetImage('assets/images/Group 5.png')),
              ),
              SizedBox(height: 40,),
              Center(
                child: Text(
                  'Welcome to Quizly!',
                  style: TextStyle(color: Colors.white,fontSize: 43,fontWeight: FontWeight.bold),

                ),
              ),
              SizedBox(height: 10,),
              Center(
                child: Text(
                  'Sign in:',
                  style: TextStyle(color: Colors.white,fontSize: 43,fontWeight: FontWeight.bold),

                ),
              ),
            Padding(
              padding:  EdgeInsets.all(15),
              child: Center(
                child: TextField(
                style:  TextStyle(

                  color: Colors.grey[50],

                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor:  Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none
                  ),
                  hintText: "Username",
                  ),
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: TextField(

              style:  TextStyle(
                color: Colors.grey[50],
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor:  Colors.white,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(36.84),
                    borderSide: BorderSide.none
                ),
                hintText: "Password",
                suffixIcon: IconButton(
                    icon: Image.asset('assets/images/Arrow 1.png'),
                    onPressed: (){}
                ),
              ),
            ),
          ),
           
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  socialLogo('assets/images/Facebook (icon — Colour).png'),
                  socialLogo('assets/images/Google (icon — Colour).png'),
                  socialLogo('assets/images/Mask group.png'),
                ],
              ),
              SizedBox(height: 5,),
              Text("or",
                style: TextStyle(color: Colors.white,fontSize: 43,fontWeight: FontWeight.bold),),
          Padding(padding: EdgeInsets.all(5),
              child:Container(
                height: 80,
                width: 300,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(Radius.circular(25))

                  ),
                  child:Center(child: Text('Play  as guest',style: TextStyle(color: Colors.black,fontSize: 38,fontWeight: FontWeight.bold),),),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
