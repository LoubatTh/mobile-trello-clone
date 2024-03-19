import 'package:app/models/workspace_model.dart';
import 'package:app/models/member_model.dart';
import 'package:app/services/api_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class MemberService {
  ApiService apiService;

  MemberService({ApiService? apiService})
      : apiService = apiService ?? ApiService();

  Future<List<WorkspaceModel>> getMemberOrganizations(String id) async {
    var response = await apiService.get("/members/$id/organizations");
    List<dynamic> decodedJson = response.data;
    return decodedJson
        .map<WorkspaceModel>(
            (json) => WorkspaceModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<Member> getMember() async {
    Response response = await ApiService().get('/', data: {
      'fields': 'avatarUrl,username,idOrganizations,idBoards',
    });

    if (kDebugMode) {
      print("getMember()\n$response.data");
    }

    return Member.fromJson(response.data);
  }
}
