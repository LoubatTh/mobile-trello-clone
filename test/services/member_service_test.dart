import 'package:app/models/workspace_model.dart';
import 'package:app/services/member_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dio/dio.dart';
import '../mock/mock_api_service.mocks.dart';

void main() {
  group('WorkspaceService Tests', () {
    late MemberService memberService;
    late MockApiService mockApiService;

    setUp(() {
      mockApiService = MockApiService();
      memberService = MemberService(apiService: mockApiService);
    });

    // Test for getMemberOrganizations method
    test('getMemberOrganizations successfully returns a list of organizations',
        () async {
      const String memberId = "1";
      // Define the expected JSON response
      final List<Map<String, dynamic>> expectedOrganizationsJson = [
        {
          "id": "Org1",
          "displayName": "Organization 1",
          "desc": "Description 1",
          "idBoards": [],
          "idMemberCreator": "CreatorId1"
        },
        {
          "id": "Org2",
          "displayName": "Organization 2",
          "desc": "Description 2",
          "idBoards": [],
          "idMemberCreator": "CreatorId2"
        },
      ];
      // Mock the API call to return the expected JSON response
      when(mockApiService.get('/members/$memberId/organizations'))
          .thenAnswer((_) async => Response(
                data: expectedOrganizationsJson,
                statusCode: 200,
                requestOptions:
                    RequestOptions(path: '/members/$memberId/organizations'),
              ));

      final List<WorkspaceModel> resultOrganizations =
          await memberService.getMemberOrganizations(memberId);
      // Ensure that we're getting the correct number of organizations back
      expect(
          resultOrganizations.length, equals(expectedOrganizationsJson.length));
      expect(resultOrganizations.first.id,
          equals(expectedOrganizationsJson.first['id']));
      expect(resultOrganizations.first.displayName,
          equals(expectedOrganizationsJson.first['displayName']));
      verify(mockApiService.get('/members/$memberId/organizations')).called(1);
    });
  });
}
