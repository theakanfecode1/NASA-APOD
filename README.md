# Astronomy Picture of the Day (APOD) Viewer App

Welcome to the Astronomy Picture of the Day (APOD) Viewer application!This app allows you to explore
and enjoy a collection of captivating astronomy pictures fetched from NASA's APOD API.

This repo is a tutorial dedicated to showcasing the use of MVVM, Riverpod, Caching(HIVE DB), Offline Capabilities and Flutter Test

## Prerequisites

Before running the application, please make sure you have the following installed on your machine:

- Flutter SDK: [Installation Guide](https://flutter.dev/docs/get-started/install)
- Dart SDK: [Installation Guide](https://dart.dev/get-dart)
- My local version (Flutter 3.7.12, Dart 2.19.6)

## Getting Started

To get started with the application, follow these steps:

1. Clone the repository to your local machine:
    - git clone https://github.com/theakanfecode1/NASA-APOD.git

2. Navigate to the project directory:
    - cd nasa_apod

3. Install the dependencies:
    - flutter pub get

4. Run the application:
    - flutter run

This will launch the application on an available emulator or connected device.

## ADDITIONAL INFORMATION ABOUT IMPLEMENTATION OR DESIGN CHOICES

The application was designed using the MVVM (Model-View-ViewModel) architecture pattern, combined
with the Riverpod state management library. This architecture promotes separation of concerns and
helps maintain a clear separation between the UI components (View), the data and business logic (
ViewModel), and the data models (Model).

Here are some key design choices and implementations in the application:

1. Riverpod State Management: Riverpod is a state management library that follows the Provider
   pattern. It allows for easy and efficient management of application state, providing a clean and
   scalable solution for handling state changes across different components. Riverpod was used to
   manage the state of the apods, including fetching and displaying apods, handling loading
   and error states, and updating the UI as the state changes.

2. API Integration: The application integrates with an API to fetch the apod data.
   The `ApodDataSource` class handles the API requests and responses using the Dio HTTP client
   library. The `getApods` method fetches a list of apods based on the provided count number. The
   received JSON response was then mapped to a list of `Apod` objects.

3. Pagination: The default count is set to 10 because the APOD API does not provide pagination
   options such
   as page or pageNum. As a result, I utilize the 'count' parameter for pagination, which allows me
   to
   retrieve a random selection of images.

4. Caching Mechanism and Offline Retrieval: The app employs the Hive database library for caching,
   enabling offline data loading.
   Fetched astronomy pictures are stored in the Hive database using the `cacheApods` method, saving
   them as a JSON representation.
   When users access the app offline, the `getCachedApods` method checks for cached apods in
   Hive, displaying them in the interface for seamless viewing.
   This caching mechanism enhances the user experience by providing uninterrupted access to
   previously fetched astronomy pictures, even without an internet connection.

5. Image Caching: The application includes caching functionality to enhance performance and minimize
   unnecessary network requests. It utilizes the `CachedNetworkImage` widget from
   the `cached_network_image` package, which enables loading and caching of images from the network.
   To manage the caching process, a custom cache manager implementation called `CustomCacheManager`
   was employed. This caching mechanism effectively reduces data usage and enhances the user
   experience by ensuring faster image loading on subsequent requests.

6. Testing: Unit and Widget tests are included to verify the functionality and behavior of key
   components, such
   as the `ApodDataSource`, `ApodGridView`, `ApodFullScreenView` classes and the ViewModel.
   Tests are written using the Flutter test framework and cover scenarios like fetching apods,
   handling errors, and verifying the structure and properties of the received data. The tests
   ensure that the application functions as expected and help in identifying and fixing issues
   during development.

These design choices and implementations provided a scalable, performant, and maintainable
application. The MVVM architecture with Riverpod enables a clear separation of concerns, making the
codebase more modular and testable. The pagination and caching mechanisms optimize the application's
performance by efficiently managing data loading and minimizing unnecessary network requests. The
inclusion of unit tests helps ensure the correctness of the implemented features and aids in
catching bugs early in the development process.

## PERFORMANCE OPTIMIZATIONS

1. Lazy Loading / Infinite Scrolling: Instead of loading all the data at once, lazy loading or
   infinite scrolling loaded data incrementally as the user scrolled. This reduced the initial load
   time and improved the performance of the application. It also reduced network bandwidth and
   memory consumption as only the necessary data was loaded. It led to faster page load times and
   better user experience.

2. Caching: To optimize performance and reduce unnecessary network requests, the application
   incorporates caching mechanisms. The `CachedNetworkImage` widget from the `cached_network_image`
   package is used to load and cache images from the network. The `CustomCacheManager` class
   provides a custom cache manager implementation to handle caching of the network images. This
   helps in minimizing data usage and improves the overall user experience by loading images faster
   on subsequent requests.

3. Optimized Rendering: This was accomplished by utilizing efficient UI components such
   as `GridView.builder`, which only rendered the visible items on the screen. This approach avoided
   rendering all the data at once, resulting in reduced memory usage and improved rendering
   performance. Additionally, the use of `const` for widgets that have constant properties helped in
   optimizing rendering by reusing widget instances and skipping unnecessary rebuilds, leading to
   better performance, especially in scenarios with large or frequently changing widget trees.

4. Asynchronous Operations: Asynchronous operations, such as API requests, are handled using Future
   and async/await syntax. This allows for non-blocking execution and ensures a smooth user
   experience

Overall, the user experience was improved through enhanced load times, reduced network latency, and
the provision of a responsive and smooth UI, resulting in higher user satisfaction.

## Running Tests

The application includes unit tests to ensure the functionality is working correctly. To execute the
tests, follow these steps:

1. Navigate to the project directory if you're not already there:
    - cd nasa_apod

2. Run the tests:
   To separately run test for each test file
    - For apod_grid_view_test.dart: flutter test test/presentation/apod_grid_view_test.dart
    - For apod_full_screen_test.dart: flutter test test/presentation/apod_full_screen_test.dart
    - For apod_datasource_test.dart: flutter test test/datasource/apod_datasource_test.dart

To run test files all together

- flutter test test/datasource/apod_datasource_test.dart
  test/presentation/apod_full_screen_test.dart
  test/presentation/apod_grid_view_test.dart

This command will run all the unit tests and display the results in the console.

## Additional Configuration

If you encounter any issues running the application or the tests, you can try the following steps:

- Ensure you have a stable internet connection to fetch data from the API.
- Check that your Flutter and Dart SDK versions are compatible with the project. You can use the
  following commands to verify:
  flutter --version
  dart --version

- If you're running the tests and they fail due to network-related issues, make sure you have a
  stable internet connection and that the API server is accessible.

If you need any questions, please feel free to reach out to me at
danielogundiranakanfe@gmail.com.
