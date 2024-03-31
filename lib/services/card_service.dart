import 'dart:ffi';

import 'package:app/models/card_model.dart';
import 'package:app/services/api_service.dart';
import 'package:dio/dio.dart';

class CardService {
  ApiService apiService;

  CardService({ApiService? apiService})
      : apiService = apiService ?? ApiService();

  Future<List<ShortCard>> getCards(String id) async {
    Response response = await apiService.get('/lists/$id/cards');

    final cards = <ShortCard>[];

    for (var card in response.data) {
      cards.add(ShortCard.fromJson(card));
    }
    await fillMembers(cards);
    await fillChecklists(cards);
    await setListnameCard(cards);

    return cards;
  }

  Future<void> setListnameCard(List<ShortCard> cards) async {
    for (var card in cards) {
      Response response = await apiService.get('/cards/${card.id}/list');
      card.setListName(response.data['name']);
    }
  }

  Future<void> fillMembers(List<ShortCard> cards) async {
    for (var card in cards) {
      if (card.idMembers != null && card.idMembers!.isNotEmpty) {
        for (var id in card.idMembers!) {
          Response response = await apiService.get('/members/$id');
          card.addMember(Member.fromJson(response.data));
        }
      }
    }
  }

  Future<void> fillChecklists(List<ShortCard> cards) async {
    for (var card in cards) {
      if (card.idChecklists != null && card.idChecklists!.isNotEmpty) {
        for (var id in card.idChecklists!) {
          Response response = await apiService.get('/checklists/$id');
          card.addChecklist(Checklist.fromJson(response.data));
        }
      }
    }
  }

  Future<List<Label>> getLabels(String boardId) async {
    Response response = await apiService.get('/boards/$boardId/labels');

    final labels = <Label>[];

    for (var label in response.data) {
      labels.add(Label.fromJson(label));
    }

    return labels;
  }

  Future<List<ShortMember>> getMembers(String boardId) async {
    Response response = await apiService.get('/boards/$boardId/members');

    final members = <ShortMember>[];

    for (var member in response.data) {
      members.add(ShortMember.fromJson(member));
    }
    await fillAvatar(members);

    return members;
  }

  Future<void> fillAvatar(List<ShortMember> members) async {
    for (var member in members) {
      Response response =
          await apiService.get('/members/${member.id}/avatarUrl');
      member.setMemberAvatar(response.data['_value']);
    }
  }

  Future<void> updateCard(String cardId, String typeData, String data) async {
    try {
      await apiService.put('/cards/$cardId', data: {typeData: data});
      print("updateDate() called");
    } catch (e) {
      rethrow;
    }
  }

Future<void> updateMember(ShortCard card) async {
  try {
    List<String>? idMembers = card.idMembers ; 

    await apiService.put('/cards/${card.id}', data: {'idMembers': idMembers});

    print("updateCard() called");
  } catch (e) {
    rethrow;
  }
}

  Future<List<Lists>> getLists(String cardId) async {
    List<Lists> lists = [];

    try{
      Response response = await apiService.get('/boards/$cardId/lists');
      for (var list in response.data) {
        lists.add(Lists.fromJson(list));
      }
    } catch (e) {
      print('Erreur lors de la récupération des listes : $e');
    }

    return lists;
  }

  Future<void> updateLabels(String cardId, List<String> data) async {
    try {
      await apiService.put('/cards/$cardId', data: {'idLabels': data});
      print("updateLabels() called $data");
    } catch (e) {
      rethrow;
    }
  }

  Future<void> createCard(String name, String? description, String listId) async {
    try {
      await apiService.post('/cards', data: {
        'name': name,
        'description': description,
        'idList': listId,
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteCard(String id) async {
    await apiService.delete('/cards/$id');
  }

}