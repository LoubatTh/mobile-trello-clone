import 'package:app/models/member_model.dart';
import 'package:app/services/api_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

Future<Member> getMember() async {
  Response response = await ApiService().get('/', {
    'fields': 'avatarUrl,username,idOrganizations,idBoards',
  });

  if (kDebugMode) {
    print("getMember()\n$response.data");
  }

  return Member.fromJson(response.data);
}
