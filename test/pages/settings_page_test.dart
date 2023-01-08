import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quizly_app/pages/settings.dart';
import 'package:get/get.dart';
import '../widgets/mock.dart';

void main() async {
  setupFirebaseAuthMocks();
  TestWidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  testWidgets('Widget Home display Image', (WidgetTester tester) async {
    await tester.pumpWidget(const GetMaterialApp(home: SettingsPage()));
    expect(find.text('Settings'), findsOneWidget);
    expect(find.text('Music'), findsOneWidget);
    expect(find.text('Sound'), findsOneWidget);
    expect(find.text('Back'), findsOneWidget);
    expect(find.byKey(const Key("Blur filter")), findsOneWidget);
  });
}
