import 'package:app/models/board_model.dart';
import 'package:app/services/api_service.dart';
import 'package:dio/dio.dart';

class BoardService {
  ApiService apiService;
  BoardService({ApiService? apiService})
      : apiService = apiService ?? ApiService();

  // GET all the member's boards
  Future<List<ShortBoard>> getMemberBoards() async {
    try {
      Response response = await ApiService().get('/members/me/boards',
          {'fields': 'name,desc,idMemberCreator,idOrganization'});
      List<dynamic> decodedJson = response.data;
      return decodedJson
          .map<ShortBoard>(
              (json) => ShortBoard.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ShortBoard>> getAllWorkspaceBoards(String id) async {
    try {
      Response response;
      response = await ApiService().get('/organization/$id/boards');

      final boards = <ShortBoard>[];

      for (var board in response.data) {
        boards.add(ShortBoard.fromJson(board));
      }

      return boards;
    } catch (e) {
      rethrow;
    }
  }

  Future<Board> getBoard(String id) async {
    try {
      Response response = await ApiService().get('/members/me/boards/$id');

      return Board.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  // Create a new board with or without a template
  Future<void> createBoard(NewBoard newBoard) async {
    try {
      Map<String, dynamic> postData = newBoard.toJson();
      await apiService.post('/boards/', postData);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  void renameBoard(String id, String name) async {
    try {
      await ApiService().put('/boards/$id', {'name': name});
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
