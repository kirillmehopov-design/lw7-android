import 'package:flutter_test/flutter_test.dart';
import 'package:lab7_android/main.dart';

void main() {
  testWidgets('Detail navigation and favorites preserve the home state',
      (tester) async {
    await tester.pumpWidget(const SneakerLab7App());

    expect(find.text('Velocity Runner'), findsOneWidget);
    await tester.tap(find.text('Velocity Runner'));
    await tester.pumpAndSettle();

    expect(find.text('Description'), findsOneWidget);
    expect(find.text('Back to previous screen'), findsOneWidget);

    await tester.ensureVisible(find.text('Save to Favorites'));
    await tester.tap(find.text('Save to Favorites'));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Back to previous screen'));
    await tester.tap(find.text('Back to previous screen'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Favorites'));
    await tester.pumpAndSettle();
    expect(find.text('Velocity Runner'), findsOneWidget);
  });
}
