import 'package:app/models/workspace_model.dart';
import 'package:app/services/api_service.dart';

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
}
