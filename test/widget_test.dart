import 'package:flutter_test/flutter_test.dart';
import 'package:google_ml_kit_test_app/app_bootstrap.dart';

void main() {
  testWidgets('Arranca en splash y llega a home', (WidgetTester tester) async {
    await tester.pumpWidget(const AppBootstrap());
    expect(find.byType(AppBootstrap), findsOneWidget);

    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();

    expect(find.text('Home'), findsOneWidget);
  });
}
