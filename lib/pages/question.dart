import 'package:flutter/material.dart';
import 'package:quizly_app/widgets/header.dart';




class Questionpage extends StatelessWidget {
  const Questionpage({super.key});


 Widget ansButton(String answer) {
   return ElevatedButton(
       onPressed: () {},
       style: ElevatedButton.styleFrom(
         backgroundColor: Colors.cyan,
         fixedSize: const  Size( 190 , 120),
         shape: RoundedRectangleBorder(
           borderRadius: BorderRadius.circular(32.0),
         )
       ),
       child: Text(
        answer,
        style: const  TextStyle(
          fontSize: 30,
          color: Colors.black

        ),
         ),
       );
 }
 Widget bodyOfQuestion(int questionNumber,String question, String ans1, String ans2, String ans3, String ans4) {
   return Column(

         children:  [
            const SizedBox(height: 20),
             Text(
             "Pytanie $questionNumber:",
             style: const TextStyle(fontSize: 50, height: 1,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic),
           ),
           const SizedBox(height: 20),
            SizedBox(
             child: Text(
               question,
               textAlign: TextAlign.center,
               style: const TextStyle(height: 1.2,fontSize: 40),
             ),
           ),
           const SizedBox(height: 30),
           const Image(
             image: AssetImage('assets/images/flag.png' ),
             height: 200,
           ),
           const SizedBox(height: 20,),
           const Image(
             image: AssetImage('assets/images/time.png'),
             width: 350,
           ),
           const SizedBox(height: 20,),
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
             children: [
               ansButton(ans1),
               ansButton(ans2)
             ],
           ),
           const SizedBox(height: 10,),
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
             children: [
               ansButton(ans3),
               ansButton(ans3)
             ],
           )
         ],
   );
 }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
       home: SafeArea(
         child: Scaffold(
         backgroundColor: Colors.grey[300],
       appBar: const PreferredSize(
           preferredSize: Size.fromHeight(70),
           child:Header(leftIcon:'assets/images/back.png',rightIcon: 'assets/images/settings.png'),
               ),

        body:
            SingleChildScrollView(
              child: bodyOfQuestion(4,"Jakiego kraju \n to flaga?","Kiribati","Liberia","Tuvalu","Macedonia"),
            ),
       ),
        )
    );


  }
}
