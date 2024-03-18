import 'package:app/models/workspace_model.dart';
import 'package:app/services/api_service.dart';

class WorkspaceService {
  ApiService apiService;

  WorkspaceService({ApiService? apiService})
      : apiService = apiService ?? ApiService();

  // GET all the member's organizations
  Future<List<WorkspaceModel>> getMemberOrganizations() async {
    var response = await apiService.get('/members/me/organizations', {'fields': 'displayName,desc,idMemberCreator,idBoards'});
    List<dynamic> decodedJson = response.data;
    return decodedJson
        .map<WorkspaceModel>(
            (json) => WorkspaceModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  // POST /a new organization
  Future<String> createOrganization(WorkspaceModel workspaceModel) async {
    Map<String, dynamic> postData = workspaceModel.toJson();
    var response = await apiService.post("/organizations", data:  postData);
    return response.data['id'];
  }

  // GET /organizations/{id}
  Future<WorkspaceModel> getOrganization(String id) async {
    var response = await apiService.get("/organizations/$id", {'fields': 'displayName,desc,idMemberCreator,idBoards'});
    return response.data;
  }

  // PUT /organizations/{id}
  Future<String> updateOrganization(
      String id, Map<String, dynamic> updateData) async {
    var response = await apiService.put("/organizations/$id", updateData);
    return response.data['id'];
  }

  // DELETE /organizations/{id}
  Future<void> deleteOrganization(String id) async {
    await apiService.delete("/organizations/$id");
  }

  // GET /organizations/{id}/boards
  Future<dynamic> getOrganizationBoards(String id) async {
    var response = await apiService.get("/organizations/$id/boards");
    return response.data;
  }

  // GET /organizations/{id}/members
  Future<dynamic> getOrganizationMembers(String id) async {
    var response = await apiService.get("/organizations/$id/members");
    return response.data;
  }

  // PUT /organizations/{id}/members
  Future<void> updateOrganizationMembers(
      String id, Map<String, dynamic> updateData) async {
    await apiService.put("/organizations/$id/members", data:  updateData);
  }

  // PUT /organizations/{id}/members/{idMember}
  Future<dynamic> updateOrganizationMember(
      String id, String idMember, Map<String, dynamic> updateData) async {
    var response = await apiService.put(
        "/organizations/$id/members/$idMember", updateData);
    return response.data;
  }

  // DEL /organizations/{id}/members/{idMember}
  Future<void> deleteOrganizationMember(String id, String idMember) async {
    await apiService.delete("/organizations/$id/members/$idMember");
  }
}
