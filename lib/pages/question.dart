import 'package:flutter/material.dart';



class UpperBar extends StatelessWidget {
  const UpperBar({super.key});


  Widget upperBar() {
    return AppBar(
      backgroundColor: Colors.cyan,
      toolbarHeight: 75,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(35),
          bottomRight: Radius.circular(35),
        ),
      ),
      title: Row(
        children: [
          IconButton(
            icon: const Image(image: AssetImage('assets/images/back.png'),height: 90,),
            onPressed: (){}, // null disables the button
            iconSize: 58  ,
          ),
          const Expanded(
            child: Image(
              image: AssetImage('assets/images/logo.png'),
              height: 60,
            ),
          ),
          IconButton(
            icon: const Image(
                image: AssetImage('assets/images/settings.png'),

            ),
            iconSize: 58,
            onPressed: (){},
          ),
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return upperBar();
  }
}

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
        const  UpperBar(),
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
