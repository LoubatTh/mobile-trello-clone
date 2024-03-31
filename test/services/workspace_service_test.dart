import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dio/dio.dart';
import 'package:app/models/workspace_model.dart';
import 'package:app/services/workspace_service.dart';
import '../mock/mock_api_service.mocks.dart';

void main() {
  group('WorkspaceService Tests', () {
    late MockApiService mockApiService;
    late WorkspaceService workspaceService;

    setUp(() {
      mockApiService = MockApiService();
      workspaceService = WorkspaceService(apiService: mockApiService);
    });

    test('getMemberOrganizations returns a list of WorkspaceModel', () async {
      final fakeResponseData = [
        {
          "id": "1",
          "displayName": "Test Workspace",
          "desc": "Description of Test Workspace",
          "idMemberCreator": "member123",
          "idBoards": ["board1", "board2"]
        },
        // Add more fake workspace data if needed
      ];

      when(mockApiService.get('/members/me/organizations', any))
          .thenAnswer((_) async => Response(
                data: fakeResponseData,
                statusCode: 200,
                requestOptions: RequestOptions(path: ''),
              ));

      final organizations = await workspaceService.getMemberOrganizations();

      expect(organizations, isA<List<WorkspaceModel>>());
      expect(organizations.length, fakeResponseData.length);
      expect(organizations.first.displayName, "Test Workspace");
    });

    // Example for createOrganization - modify as needed
    test('createOrganization successfully creates a workspace', () async {
      final workspaceModel = WorkspaceModel(
        id: '1',
        displayName: 'New Workspace',
        desc: 'Description',
        idMemberCreator: 'member123',
        idBoards: [],
      );

      when(mockApiService.post("/organizations", data: anyNamed('data')))
          .thenAnswer((_) async => Response(
                data: {"id": "1"},
                statusCode: 200,
                requestOptions: RequestOptions(path: ''),
              ));

      final resultId =
          await workspaceService.createOrganization(workspaceModel);

      expect(resultId, isNotNull);
      expect(resultId, "1");
    });

        // Testing getOrganizationMembers method
    test('getOrganizationMembers returns a list of member usernames', () async {
      const organizationId = '1';
      final fakeResponseData = [
        {"username": "user1"},
        {"username": "user2"},
      ];

      when(mockApiService.get("/organizations/$organizationId/members", any))
          .thenAnswer((_) async => Response(
                data: fakeResponseData,
                statusCode: 200,
                requestOptions: RequestOptions(path: ''),
              ));

      final members = await workspaceService.getOrganizationMembers(organizationId);

      expect(members, isA<List<dynamic>>());
      expect(members.length, fakeResponseData.length);
      expect(members.first['username'], "user1");
    });

    // Testing addOrganizationMember method
    test('addOrganizationMember successfully adds a member to the organization', () async {
      const organizationId = '1';
      const memberId = 'member123';
      const memberType = 'normal';
      final fakeResponseData = {"success": true};

      when(mockApiService.put("/organizations/$organizationId/members/$memberId", data: anyNamed('data')))
          .thenAnswer((_) async => Response(
                data: fakeResponseData,
                statusCode: 200,
                requestOptions: RequestOptions(path: ''),
              ));

      final result = await workspaceService.addOrganizationMember(organizationId, memberId, memberType);

      expect(result, fakeResponseData);
    });

    // Testing deleteOrganization method
    test('deleteOrganization successfully deletes an organization', () async {
      const organizationId = '1';
      when(mockApiService.delete("/organizations/$organizationId"))
          .thenAnswer((_) async => Response(
                data: {},
                statusCode: 200,
                requestOptions: RequestOptions(path: ''),
              ));

      await workspaceService.deleteOrganization(organizationId);

      // Since delete doesn't return a body, we check if the method was called
      verify(mockApiService.delete("/organizations/$organizationId")).called(1);
    });

    // Testing getOrganizationBoards method
    test('getOrganizationBoards returns a list of boards within the organization', () async {
      const organizationId = '1';
      final fakeResponseData = [
        {"id": "board1", "name": "Board 1"},
        {"id": "board2", "name": "Board 2"},
      ];

      when(mockApiService.get("/organizations/$organizationId/boards", any))
          .thenAnswer((_) async => Response(
                data: fakeResponseData,
                statusCode: 200,
                requestOptions: RequestOptions(path: ''),
              ));

      final boards = await workspaceService.getOrganizationBoards(organizationId);

      expect(boards, isA<List<dynamic>>());
      expect(boards.length, fakeResponseData.length);
      expect(boards.first['name'], "Board 1");
    });

    // Testing deleteOrganizationMember method
    test('deleteOrganizationMember successfully removes a member from the organization', () async {
      const organizationId = '1';
      const memberId = 'member123';

      when(mockApiService.delete("/organizations/$organizationId/members/$memberId"))
          .thenAnswer((_) async => Response(
                data: {},
                statusCode: 200,
                requestOptions: RequestOptions(path: ''),
              ));

      await workspaceService.deleteOrganizationMember(organizationId, memberId);

      // Since delete doesn't return a body, we check if the method was called
      verify(mockApiService.delete("/organizations/$organizationId/members/$memberId")).called(1);
    });
  });
}
