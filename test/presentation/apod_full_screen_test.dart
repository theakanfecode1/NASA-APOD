import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nasa_apod/models/apod.dart';
import 'package:nasa_apod/view/apod_full_screen_view.dart';
import 'package:nasa_apod/view/components/apod_details.dart';

void main() {
  testWidgets('ApodFullScreenView widget test', (WidgetTester tester) async {
    // Create a mock Apod object for testing
    final apod = Apod(
        title: 'Animation',
        date: '2022-05-10',
        m64: 'Recently, modern computer modeling of missing components is allowing for the creation of a more complete replica of this surprising ancient',
        explanation: 'It does what?  No one knew that 2,000 years ago, the technology existed to build such a device',
        url: 'https://apod.nasa.gov/apod/image/2307/antikythera_wikipedia_960.jpg',
        hdUrl: 'https://apod.nasa.gov/apod/image/2307/antikythera_wikipedia_960.jpg');

    // Build the widget
    await tester.pumpWidget(
      MaterialApp(
        home: MediaQuery(
          data: const MediaQueryData(),
          child: ApodFullScreenView(apod: apod),
        ),
      ),
    );
    // Verify that the widget tree is correctly rendered
    expect(find.text('Animation'), findsOneWidget);
    expect(find.text('May 10, 2022'), findsOneWidget);

    // Verify the presence of certain widgets or components
    expect(find.byType(ApodDetails), findsOneWidget);
  });
}
