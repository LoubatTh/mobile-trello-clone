import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiService {
  late Dio dio;
  String? apiUrl = dotenv.env['API_URL'];

  ApiService({Dio? dioClient}) {
    apiUrl = dotenv.env['API_URL'];
    dio = dioClient ??
        Dio(BaseOptions(
          baseUrl: apiUrl ?? "",
          queryParameters: {
            'key': dotenv.env['API_KEY'],
            'token': dotenv.env['API_TOKEN'],
          },
        ));
  }

  Future<Response> get(String path,
      [Map<String, dynamic>? queryParameters]) async {
    try {
      isParam(queryParameters) ? queryParameters = {} : queryParameters;

      return await dio.get(path, queryParameters: {...?queryParameters});
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> post(String path,
      [Map<String, dynamic>? queryParameters, dynamic data]) async {
    try {
      isParam(queryParameters) ? queryParameters = {} : queryParameters;
      isData(data) ? data = {} : data;

      return await dio.post(path,
          queryParameters: {...?queryParameters}, data: data);
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> put(String path,
      [Map<String, dynamic>? queryParameters, dynamic data]) async {
    try {
      isParam(queryParameters) ? queryParameters = {} : queryParameters;
      isData(data) ? data = {} : data;

      return await dio.put(path,
          queryParameters: {...?queryParameters}, data: data);
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> delete(String path) async {
    try {
      return await dio.delete(path);
    } catch (e) {
      rethrow;
    }
  }
}

bool isParam(Map<String, dynamic>? param) => param == null || param.isEmpty;

bool isData(dynamic data) => data != null && data.isNotEmpty;
