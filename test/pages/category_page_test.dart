import 'package:flutter_test/flutter_test.dart';
import 'package:quizly_app/pages/category_page.dart';

void main() {
  testWidgets('Widget Home display Image', (WidgetTester tester) async {
    await tester.pumpWidget(CategoryPage());

    expect(find.text("Film & TV"), findsOneWidget);
    expect(find.text("Arts & Literature"), findsOneWidget);
    expect(find.text("Food & Drink"), findsOneWidget);
    expect(find.text("General Knowledge"), findsOneWidget);
    expect(find.text("Science"), findsOneWidget);
    expect(find.text("History"), findsOneWidget);
    expect(find.text("Sport & Leisure"), findsOneWidget);
  });
}
