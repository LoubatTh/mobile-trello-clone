import 'package:app/models/board_model.dart';
import 'package:app/services/api_service.dart';
import 'package:dio/dio.dart';

class BoardService {
  ApiService apiService;
  BoardService({ApiService? apiService})
      : apiService = apiService ?? ApiService();

  // GET all the member's boards
  Future<List<ShortBoardModel>> getMemberBoards() async {
    try {
      Response response = await ApiService().get('/members/me/boards',
          {'fields': 'name,desc,idMemberCreator,idOrganization'});
      List<dynamic> decodedJson = response.data;
      return decodedJson
          .map<ShortBoardModel>(
              (json) => ShortBoardModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ShortBoardModel>> getAllWorkspaceBoards(String id) async {
    try {
      Response response;
      response = await ApiService().get('/organization/$id/boards');

      final boards = <ShortBoardModel>[];

      for (var board in response.data) {
        boards.add(ShortBoardModel.fromJson(board));
      }

      return boards;
    } catch (e) {
      rethrow;
    }
  }

  Future<BoardModel> getBoard(String id) async {
    try {
      Response response = await ApiService().get('/members/me/boards/$id');

      return BoardModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  // Create a new board with or without a template
  Future<void> createBoard(NewBoardModel newBoard) async {
    try {
      Map<String, dynamic> postData = newBoard.toJson();
      print (postData);
      await apiService.post('/boards/', data :postData);
    } catch (e) {
      rethrow;
    }
  }

  void renameBoard(String id, String name) async {
    try {
      await ApiService().put('/boards/$id', data :{'name': name});
    } catch (e) {
      rethrow;
    }
  }

  void deleteBoard(String id) async {
    try {
      await ApiService().delete('/boards/$id');
    } catch (e) {
      rethrow;
    }
  }
}
