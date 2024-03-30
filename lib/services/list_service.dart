import 'package:app/models/list_model.dart';
import 'package:app/services/api_service.dart';
import 'package:dio/dio.dart';

class ListService {
  ApiService apiService;

  ListService({ApiService? apiService})
      : apiService = apiService ?? ApiService();

  Future<List<ListModel>> getAllBoardLists(String boardId) async {
    Response response = await apiService.get('/boards/$boardId/lists');

    List<ListModel> lists = [];
    for (var list in response.data) {
      lists.add(ListModel.fromJson(list));
    }

    return lists;
  }

  Future<ListModel> getList(String id) async {
    Response response = await apiService.get('/lists/$id');
    return response.data;
  }

  Future<String> createBoardList(String boardId, String name, var pos) async {
    Response response = await apiService
        .post('/boards/$boardId/lists', data: {'name': name, 'pos': pos});
    return response.data['id'];
  }
  
  Future<String> moveList(String id, var pos) async {
    Response response =
        await apiService.put('/lists/$id', data: {'pos': pos});
    return response.data;
  }

  Future<String> renameList(String id, String name) async {
    Response response =
        await apiService.put('/lists/$id', data: {'name': name});
    return response.data;
  }

  Future<String> archiveList(String id, bool value) async {
    Response response =
        await apiService.put('/lists/$id', data: {'closed': value});
    return response.data['id'];
  }
}
