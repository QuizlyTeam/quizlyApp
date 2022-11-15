import 'package:flutter/material.dart';
import 'pages/settings.dart';

void main() => runApp(MaterialApp(initialRoute: '/settings', routes: {
      '/settings': (context) => const SettingsPage(),
    }));
