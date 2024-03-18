import 'package:app/models/member_model.dart';
import 'package:app/services/api_service.dart';

class MemberService {
  ApiService apiService;

  MemberService({ApiService? apiService})
      : apiService = apiService ?? ApiService();

  Future<List<MemberModel>> getMember() async {
    var response = await ApiService().get('/members/me',);
    List <dynamic> decodedJson = response.data;
    return decodedJson
        .map<MemberModel>(
            (json) => MemberModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
