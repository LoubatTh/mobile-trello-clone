import 'package:app/models/board_model.dart';
import 'package:app/services/api_service.dart';
import 'package:dio/dio.dart';

class BoardService {
  ApiService apiService;

  BoardService({ApiService? apiService})
      : apiService = apiService ?? ApiService();

  Future<List<ShortBoardModel>> getAllBoards() async {
    Response response = await apiService
        .get('/members/me/boards', {'fields': 'name,desc,idOrganization'});

    return response.data.map<ShortBoardModel>((e) {
      return ShortBoardModel.fromJson(e);
    }).toList();
  }

  Future<List<ShortBoardModel>> getAllWorkspaceBoards(String id) async {
    Response response = await apiService.get(
        '/organization/$id/boards', {'fields': 'name,desc,idOrganization'});

    return response.data.map<ShortBoardModel>((e) {
      return ShortBoardModel.fromJson(e);
    }).toList();
  }

  Future<BoardModel> getBoard(String id) async {
    Response response = await apiService.get('/members/me/boards/$id');
    return response.data;
  }

  Future<String> createBoard(String name, {String? idOrganization}) async {
    Map<String, dynamic> data = {'name': name};
    if (idOrganization != null) data['idOrganization'] = idOrganization;
    Response response = await apiService.post('/boards', data: data);
    return response.data['id'];
  }

  Future<String> renameBoard(String id, String name) async {
    Response response =
        await apiService.put('/boards/$id', data: {'name': name});
    return response.data['id'];
  }

  Future<void> deleteBoard(String id) async {
    await apiService.delete('/boards/$id');
  }
}
