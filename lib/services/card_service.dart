import 'package:app/models/card_model.dart';
import 'package:app/services/api_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

Future<List<ShortCard>> getCards(String id) async {
  Response response = await ApiService().get('/lists/$id/cards');

  final cards = <ShortCard>[];

  for (var card in response.data) {
    cards.add(ShortCard.fromJson(card));
    print('aaaa $card');
  }
  await fillMembers(cards);
  await fillChecklists(cards);

  return cards;
}

Future<void> fillMembers(List<ShortCard> cards) async {
  for (var card in cards) {
    if (card.idMembers != null && card.idMembers!.isNotEmpty) {
      for (var id in card.idMembers!) {
        Response response = await ApiService().get('/members/$id');
        card.addMember(Member.fromJson(response.data));
      }
    }
  }
}


Future<void> fillChecklists(List<ShortCard> cards) async {
  for (var card in cards) {
    if (card.idChecklists != null && card.idChecklists!.isNotEmpty) {
      for (var id in card.idChecklists!) {
        Response response = await ApiService().get('/checklists/$id');
        card.addChecklist(Checklist.fromJson(response.data));
      }
    }
  }
}

Future<Card> getCard(String id) async {
  Response response = await ApiService().get('/cards/$id');

  return Card.fromJson(response.data);
}

Future<void> createCard(String name, String idList) async {
  await ApiService().post('/cards', {'name': name, 'idList': idList});

  if (kDebugMode) {
    print("createCard(): $name, $idList");
  }
}

Future<void> renameCard(String id, String name) async {
  await ApiService().put('/cards/$id', {'name': name});
}

Future<void> deleteCard(String id) async {
  await ApiService().delete('/cards/$id');
}