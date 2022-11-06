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
  @override
  Widget build(BuildContext context) {
    // Material is a conceptual piece
    // of paper on which the UI appears.
    return Material(
      // Column is a vertical, linear layout.
      child: Column(

        children:  [
        const  Header(),
          const SizedBox(height: 20),
          const Text(
           "Pytanie 3:",
           style: TextStyle(fontSize: 50, height: 1,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic),
         ),
          const SizedBox(height: 20),
          const SizedBox(
            child: Text(
                "Jakiego kraju \n to flaga?",
                  textAlign: TextAlign.center,
                style: TextStyle(height: 1.2,fontSize: 40),
          ),
          ),
          const SizedBox(height: 30),
          const Image(
              image: AssetImage('assets/images/flag.png'),
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
           ansButton("Kiribati"),
           ansButton("Liberia")
         ],
       ),
      const SizedBox(height: 10,),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ansButton("Tuvalu"),
          ansButton("Macedonia")
        ],
      )
        ],
      ),
    );
  }
}
