import 'package:app/models/workspace_model.dart';
import 'package:app/services/api_service.dart';

class WorkspaceService {
  ApiService apiService;

  WorkspaceService({ApiService? apiService})
      : apiService = apiService ?? ApiService();

  // POST /organizations
  Future<String> createOrganization(WorkspaceModel workspaceModel) async {
    Map<String, dynamic> postData = workspaceModel.toJson();
    var response = await apiService.post("/organizations", postData);
    return response.data['id'];
  }

  // GET /organizations/{id}
  Future<String> getOrganization(String id) async {
    var response = await apiService.get("/organizations/$id");
    return response.data['id'];
  }

  // PUT /organizations/{id}
  Future<String> updateOrganization(
      String id, Map<String, dynamic> updateData) async {
    var response = await apiService.put("/organizations/$id",  updateData);
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
    await apiService.put("/organizations/$id/members", updateData);
  }

  // PUT /organizations/{id}/members/{idMember}
  Future<dynamic> updateOrganizationMember(
      String id, String idMember, Map<String, dynamic> updateData) async {
    var response = await apiService.put("/organizations/$id/members/$idMember",
        updateData);
    return response.data;
  }

  // DEL /organizations/{id}/members/{idMember}
  Future<void> deleteOrganizationMember(String id, String idMember) async {
    await apiService.delete("/organizations/$id/members/$idMember");
  }
}
