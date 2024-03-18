import 'package:app/models/board_model.dart';
import 'package:app/services/api_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class BoardService {
  ApiService apiService;

  BoardService({ApiService? apiService})
      : apiService = apiService ?? ApiService();

  // GET all the member's boards
  Future<List<ShortBoard>> getMemberBoards() async {
    Response response =
        await ApiService().get('/members/me/boards', {'fields': 'name,desc,idMemberCreator,idOrganization'});
    List<dynamic> decodedJson = response.data;
     return decodedJson
        .map<ShortBoard>(
            (json) => ShortBoard.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<List<ShortBoard>> getAllWorkspaceBoards(String id) async {
    Response response;
    response = await ApiService().get('/organization/$id/boards');

    final boards = <ShortBoard>[];

    for (var board in response.data) {
      boards.add(ShortBoard.fromJson(board));
    }

    return boards;
  }

  Future<Board> getBoard(String id) async {
    Response response = await ApiService().get('/members/me/boards/$id');

    return Board.fromJson(response.data);
  }

  void createBoard(String name, {String? idOrganization}) async {
    Response response = await ApiService().post('/boards', {'name': name});

    if (kDebugMode) {
      print("createBoard(): $response");
    }
  }

  void renameBoard(String id, String name) async {
    await ApiService().put('/boards/$id', {'name': name});
  }

  void deleteBoard(String id) async {
    await ApiService().delete('/boards/$id');
  }
}
