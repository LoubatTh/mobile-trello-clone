import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dio/dio.dart';
import 'package:app/services/api_service.dart';
import 'mock/mock_dio.mocks.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();

  late ApiService apiService;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    apiService = ApiService(dioClient: mockDio);
  });

  group('ApiService Tests', () {
    // test for get method returns a successful response
    test('get method returns a successful response', () async {
      const path = 'test_endpoint';
      final mockResponse = Response(
        requestOptions: RequestOptions(path: path),
        data: 'Mock Get Response',
        statusCode: 200,
      );

      when(mockDio.get(any, options: anyNamed('options')))
          .thenAnswer((_) async => mockResponse);

      final result = await apiService.get(path);

      expect(result.data, equals('Mock Get Response'));
      expect(result.statusCode, 200);
    });

    // failed test for get method
    test('get method returns a failed response', () async {
      const path = 'test_endpoint';
      final mockResponse = Response(
        requestOptions: RequestOptions(path: path),
        data: 'Mock Get Response',
        statusCode: 404,
      );

      when(mockDio.get(any, options: anyNamed('options')))
          .thenAnswer((_) async => mockResponse);

      final result = await apiService.get(path);

      expect(result.data, equals('Mock Get Response'));
      expect(result.statusCode, 404);
    });

    // test for get method throws an exception
    test('get method throws an exception', () async {
      const path = 'test_endpoint';
      when(mockDio.get(any, options: anyNamed('options')))
          .thenThrow(Exception('Test Exception'));

      expect(() async => await apiService.get(path), throwsException);
    });

    // test for post method returns a successful response
    test('post method returns a successful response', () async {
      const path = 'test_endpoint';
      final mockResponse = Response(
        requestOptions: RequestOptions(path: path),
        data: 'Mock Post Response',
        statusCode: 201,
      );

      when(mockDio.post(any,
              data: anyNamed('data'), options: anyNamed('options')))
          .thenAnswer((_) async => mockResponse);

      final result = await apiService.post(path, data: {});

      expect(result.data, equals('Mock Post Response'));
      expect(result.statusCode, 201);
    });

    // failed test for post method
    test('post method returns a failed response', () async {
      const path = 'test_endpoint';
      final mockResponse = Response(
        requestOptions: RequestOptions(path: path),
        data: 'Mock Post Response',
        statusCode: 400,
      );

      when(mockDio.post(any,
              data: anyNamed('data'), options: anyNamed('options')))
          .thenAnswer((_) async => mockResponse);

      final result = await apiService.post(path, data: {});

      expect(result.data, equals('Mock Post Response'));
      expect(result.statusCode, 400);
    });

    // test for post method throws an exception
    test('post method throws an exception', () async {
      const path = 'test_endpoint';
      when(mockDio.post(any,
              data: anyNamed('data'), options: anyNamed('options')))
          .thenThrow(Exception('Test Exception'));

      expect(
          () async => await apiService.post(path, data: {}), throwsException);
    });

    // test for put method returns a successful response
    test('put method returns a successful response', () async {
      const path = 'test_endpoint';
      final mockResponse = Response(
        requestOptions: RequestOptions(path: path),
        data: 'Mock Put Response',
        statusCode: 200,
      );

      when(mockDio.put(any,
              data: anyNamed('data'), options: anyNamed('options')))
          .thenAnswer((_) async => mockResponse);

      final result = await apiService.put(path, data: {});

      expect(result.data, equals('Mock Put Response'));
      expect(result.statusCode, 200);
    });

    // failed test for put method
    test('put method returns a failed response', () async {
      const path = 'test_endpoint';
      final mockResponse = Response(
        requestOptions: RequestOptions(path: path),
        data: 'Mock Put Response',
        statusCode: 400,
      );

      when(mockDio.put(any,
              data: anyNamed('data'), options: anyNamed('options')))
          .thenAnswer((_) async => mockResponse);

      final result = await apiService.put(path, data: {});

      expect(result.data, equals('Mock Put Response'));
      expect(result.statusCode, 400);
    });

    // test for put method throws an exception
    test('put method throws an exception', () async {
      const path = 'test_endpoint';
      when(mockDio.put(any,
              data: anyNamed('data'), options: anyNamed('options')))
          .thenThrow(Exception('Test Exception'));

      expect(() async => await apiService.put(path, data: {}), throwsException);
    });

    // test for delete method returns a successful response
    test('delete method returns a successful response', () async {
      const path = 'test_endpoint';
      final mockResponse = Response(
        requestOptions: RequestOptions(path: path),
        data: 'Mock Delete Response',
        statusCode: 200,
      );

      when(mockDio.delete(any, options: anyNamed('options')))
          .thenAnswer((_) async => mockResponse);

      final result = await apiService.delete(path);

      expect(result.data, equals('Mock Delete Response'));
      expect(result.statusCode, 200);
    });
  });

  // failed test for delete method
  test('delete method returns a failed response', () async {
    const path = 'test_endpoint';
    final mockResponse = Response(
      requestOptions: RequestOptions(path: path),
      data: 'Mock Delete Response',
      statusCode: 400,
    );

    when(mockDio.delete(any, options: anyNamed('options')))
        .thenAnswer((_) async => mockResponse);

    final result = await apiService.delete(path);

    expect(result.data, equals('Mock Delete Response'));
    expect(result.statusCode, 400);
  });

  // test for delete method throws an exception
  test('delete method throws an exception', () async {
    const path = 'test_endpoint';
    when(mockDio.delete(any, options: anyNamed('options')))
        .thenThrow(Exception('Test Exception'));

    expect(() async => await apiService.delete(path), throwsException);
  });
}
