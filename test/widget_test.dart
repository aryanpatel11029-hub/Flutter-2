import 'package:flutter_test/flutter_test.dart';
import 'package:reread/main.dart';

void main() {
  testWidgets('App launches smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const BookApp());
    expect(find.byType(BookApp), findsOneWidget);
  });
}
