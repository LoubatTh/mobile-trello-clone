import 'package:app/models/workspace_model.dart';
import 'package:app/services/api_service.dart';

class WorkspaceService {
  ApiService apiService;

  WorkspaceService({ApiService? apiService})
      : apiService = apiService ?? ApiService();

  // GET all member's organizations
  Future<List<WorkspaceModel>> getMemberOrganizations() async {
    try {
      var response = await apiService.get('/members/me/organizations',
          {'fields': 'displayName,desc,idMemberCreator,idBoards'});
      List<dynamic> decodedJson = response.data;
      return decodedJson
          .map<WorkspaceModel>(
              (json) => WorkspaceModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  // POST a new organization
  Future<String> createOrganization(WorkspaceModel workspaceModel) async {
    try {
      Map<String, dynamic> postData = workspaceModel.toJson();
      var response = await apiService.post("/organizations", postData);
      return response.data['id'];
    } catch (e) {
      rethrow;
    }
  }

  // GET all the members username of an organization
  Future<List<dynamic>> getOrganizationMembers(String id) async {
    try {
      var response = await apiService
          .get("/organizations/$id/members", {'fields': 'username'});
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  // GET /organizations/{id}
  Future<WorkspaceModel> getOrganization(String id) async {
    try {
      var response = await apiService.get("/organizations/$id",
          {'fields': 'displayName,desc,idMemberCreator,idBoards'});
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  // Add a new member to the workspace
  Future<dynamic> addOrganizationMember(String id, String idMember, String type) async {
    try {
      var response = await apiService.put(
          "/organizations/$id/members/$idMember", { "type" : type });
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  // PUT /organizations/{id}
  Future<String> updateOrganization(
      String id, Map<String, dynamic> updateData) async {
    try {
      var response = await apiService.put("/organizations/$id", updateData);
      return response.data['id'];
    } catch (e) {
      rethrow;
    }
  }

  // DELETE /organizations/{id}
  Future<void> deleteOrganization(String id) async {
    try {
      await apiService.delete("/organizations/$id");
    } catch (e) {
      rethrow;
    }
  }

  // GET /organizations/{id}/boards
  Future<dynamic> getOrganizationBoards(String id) async {
    try {
      var response = await apiService.get("/organizations/$id/boards");
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  // PUT /organizations/{id}/members
  Future<void> updateOrganizationMembers(
      String id, Map<String, dynamic> updateData) async {
    try {
      var response =
          await apiService.put("/organizations/$id/members", updateData);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  // DEL /organizations/{id}/members/{idMember}
  Future<void> deleteOrganizationMember(String id, String idMember) async {
    try {
      await apiService.delete("/organizations/$id/members/$idMember");
    } catch (e) {
      rethrow;
    }
  }
}
