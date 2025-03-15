// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hq_arena/main.dart';

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(); // Initialize Firebase for tests
  });
  testWidgets('Quiz question appears on the screen',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the quiz question text appears (replace with an actual question from your app).
    expect(find.text('What is the capital of France?'), findsOneWidget);

    // Verify that at least one answer choice appears.
    expect(find.text('Paris'), findsOneWidget);
    expect(
        find.text('London'), findsNothing); // Assuming London is not the answer

    // Tap on an answer (adjust this according to your app's button structure).
    await tester.tap(find.text('Paris'));
    await tester.pump();

    // Verify if the next question appears or a result is shown.
    expect(
        find.text('Next'), findsOneWidget); // Adjust based on your app behavior
  });
}
