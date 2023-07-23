
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:nasa_apod/models/apod.dart';
import 'package:nasa_apod/repository/apod_repository.dart';
import 'package:nasa_apod/res/components/loading_indicator.dart';
import 'package:nasa_apod/view/components/apods_grid.dart';
import 'package:nasa_apod/view_model/apod_view_model.dart';

// Custom HttpOverrides to handle HTTPS requests
class MockHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

// Fake implementation of ApodRepository for testing
class FakeRepository implements ApodRepository {
  @override
  Future<List<Apod>> getApods() async {
    // Return a list of fake apods for testing
    return [
      Apod(
          title: 'Animation',
          date: '2022-05-10',
          m64: 'Recently, modern computer modeling of missing components is allowing for the creation of a more complete replica of this surprising ancient',
          explanation: 'It does what?  No one knew that 2,000 years ago, the technology existed to build such a device',
          url: 'https://apod.nasa.gov/apod/image/2307/antikythera_wikipedia_960.jpg',
          hdUrl: 'https://apod.nasa.gov/apod/image/2307/antikythera_wikipedia_960.jpg'),
      Apod(
          title: 'Moon',
          date: '2022-05-10',
          m64: 'Recently, modern computer modeling of missing components is allowing for the creation of a more complete replica of this surprising ancient',
          explanation: 'It does what?  No one knew that 2,000 years ago, the technology existed to build such a device',
          url: 'https://apod.nasa.gov/apod/image/2307/antikythera_wikipedia_960.jpg',
          hdUrl: 'https://apod.nasa.gov/apod/image/2307/antikythera_wikipedia_960.jpg')    ];  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Renders grid items with title',
          (WidgetTester tester) async {
        // Run the test within the custom HttpOverrides
        HttpOverrides.runZoned(
              () async {
            await tester.pumpWidget(
              ProviderScope(
                overrides: [
                  // Override the apodRepositoryProvider with FakeRepository
                  apodRepositoryProvider.overrideWith((ref) {
                    return FakeRepository();
                  })
                ],
                child: MaterialApp(
                  home: Consumer(
                    builder: (BuildContext context, WidgetRef ref, Widget? child) {
                      // Watch the apodViewModelStateNotifier
                      final apodVM =
                      ref.watch(apodViewModelStateNotifierProvider);

                      // Call getApods after the frame has been rendered
                      TestWidgetsFlutterBinding.instance.addPostFrameCallback((_) {
                        ref
                            .read(apodViewModelStateNotifierProvider.notifier)
                            .getApods();
                      });

                      // Render the UI based on the state of apodVM
                      return apodVM.when(
                          idle: () => const LoadingIndicator(),
                          loading: () => const Center(child: LoadingIndicator()),
                          success: (data) => ApodGrid(
                            apods: data as List<Apod>,
                          ),
                          error: (error) => Container());
                    },
                  ),
                ),
              ),
            );

            // Assert that grid is initially loading
            expect(find.byType(LoadingIndicator), findsOneWidget);

            // Re-render.
            await tester.pump();

            // No longer loading
            expect(find.byType(LoadingIndicator), findsNothing);


            // Assert that the grid items with descriptions are rendered
            expect(find.text('Animation'), findsOneWidget);
            expect(find.text('Moon'), findsOneWidget);
          },
          createHttpClient: (SecurityContext? context) {
            // Create a custom HttpClient with the overridden HttpOverrides
            return MockHttpOverrides().createHttpClient(context);
          },
        );
      });
}
