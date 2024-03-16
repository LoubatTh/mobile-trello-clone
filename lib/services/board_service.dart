import 'package:app/models/board_model.dart';
import 'package:app/services/api_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

Future<List<ShortBoard>> getAllBoards() async {
  Response response =
      await ApiService().get('/members/me/boards', {'fields': 'name,desc'});

  final boards = <ShortBoard>[];

  for (var board in response.data) {
    boards.add(ShortBoard.fromJson(board));
  }

  return boards;
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
