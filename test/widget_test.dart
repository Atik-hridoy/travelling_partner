import 'package:flutter_test/flutter_test.dart';
import 'package:voyenta/app.dart';

void main() {
  testWidgets('VoyentaApp smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const VoyentaApp());

    // Verify that the tagline is present (on Splash Screen)
    expect(find.text('Know Before You Go'), findsOneWidget);

    // Let the navigation timer fire to prevent "Timer is still pending" errors
    await tester.pump(const Duration(milliseconds: 2600));
  });
}
