import 'package:flutter_test/flutter_test.dart';
import 'package:quizly_app/pages/settings.dart';

void main() {
  testWidgets('Widget Home display Image', (WidgetTester tester) async {
    await tester.pumpWidget(const SettingsPage());
    expect(find.text('Settings'), findsOneWidget);
    expect(find.text('Music'), findsOneWidget);
    expect(find.text('Sound'), findsOneWidget);
    expect(find.text('Back'), findsOneWidget);
  });
}
