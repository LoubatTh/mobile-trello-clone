import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:app/services/user_helper.dart';

class ApiService {
  Dio dio = Dio();
  final dbHelper = DatabaseHelper.instance;
  String? apiUrl = dotenv.env['API_URL'];

  ApiService({Dio? dioClient}) {
    _initializeDio();
  }

  Future<void> _initializeDio() async {
    apiUrl = dotenv.env['API_URL'];
    final token = await dbHelper.getToken();

    dio = Dio(BaseOptions(
      baseUrl: apiUrl ?? "",
      queryParameters: {
        'key': dotenv.env['API_KEY'],
        'token': token,
      },
    ));
  }

  Future<Response> get(String path, [Map<String, dynamic>? data]) async {
    await dbHelper.printDatabase();
    try {
      isParam(data) ? data = {} : data;

      return await dio.get(path, queryParameters: {...?data});
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> post(String path, {Map<String, dynamic>? data}) async {
    try {
      isParam(data) ? data = {} : data;

      return await dio.post(path, data: {...?data});
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> put(String path, {Map<String, dynamic>? data}) async {
    try {
      isParam(data) ? data = {} : data;

      return await dio.put(path, data: {...?data});
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
