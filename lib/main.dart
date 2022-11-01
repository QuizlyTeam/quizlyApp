import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({required this.title, super.key});

  // Fields in a Widget subclass are always marked "final".

  final Widget title;
  Widget upperBar(){
    return Container(
      height: 56.0, // in logical pixels
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(color: Colors.cyan),
      // Row is a horizontal, linear layout.
      child: Row(
        children: const [
          IconButton(
            icon: Image(image: AssetImage('assets/images/back.png')),
            tooltip: 'Navigation menu',
            onPressed: null, // null disables the button
          ),
          // Expanded expands its child
          // to fill the available space.
          Expanded(
            child: Image(
              image: AssetImage('assets/images/logo.png'),
            ),
          ),
          IconButton(
            icon: Image(image: AssetImage('assets/images/settings.png')),
            tooltip: 'Search',
            onPressed: null,
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

class MyScaffold extends StatelessWidget {
  const MyScaffold({super.key});


  @override
  Widget build(BuildContext context) {
    // Material is a conceptual piece
    // of paper on which the UI appears.
    return Material(
      // Column is a vertical, linear layout.
      child: Column(
        children: [
          MyAppBar(
            title: Text(
              'Example title',
              style: Theme.of(context) //
                  .primaryTextTheme
                  .headline6,
            ),
          ),
          const Expanded(
            child: Center(
              child: Text('Hello, world!'),
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(
    const MaterialApp(
      title: 'My app', // used by the OS task switcher
      home: SafeArea(
        child: MyScaffold(),
      ),
    ),
  );
}

