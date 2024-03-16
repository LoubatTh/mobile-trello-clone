import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dio/dio.dart';
import 'package:app/models/workspace_model.dart';
import 'package:app/services/workspace_service.dart';
import '../mock/mock_api_service.mocks.dart';

void main() {
  group('WorkspaceService Tests', () {
    late WorkspaceService workspaceService;
    late MockApiService mockApiService;
    late WorkspaceModel workspaceModel;

    setUp(() {
      mockApiService = MockApiService();
      workspaceService = WorkspaceService(apiService: mockApiService);
      workspaceModel = WorkspaceModel(
          id: "1",
          displayName: "Test Workspace",
          desc: "A test workspace",
          idBoards: ["Workspace1", "Workspace2"],
          idMemberCreator: "https://example.com");
    });

    // Test for createOrganization method
    test(
        'createOrganization successfully creates a workspace and returns its ID',
        () async {
      const String expectedId = "2";
      Map<String, dynamic> postData = workspaceModel.toJson();
      
      when(mockApiService.post('/organizations', data: anyNamed('data')))
          .thenAnswer((_) async => Response(
                data: {'id': expectedId},
                statusCode: 200,
                requestOptions: RequestOptions(path: '/organizations'),
              ));

      String resultId =
          await workspaceService.createOrganization(workspaceModel);

      expect(resultId, equals(expectedId));
      verify(mockApiService.post('/organizations', data: postData)).called(1);
    });

    // Rest for getOrganization method
    test('getOrganization successfully returns a workspace ID', () async {
      const String expectedId = "1";

      when(mockApiService.get('/organizations/1')).thenAnswer((_) async =>
          Response(
              data: {'id': expectedId},
              statusCode: 200,
              requestOptions: RequestOptions(path: '/organizations/1')));

      String resultId = await workspaceService.getOrganization("1");

      expect(resultId, equals(expectedId));
      verify(mockApiService.get('/organizations/1')).called(1);
    });

    // Test for updateOrganization method
    test(
        'updateOrganization successfully updates a workspace and returns its ID',
        () async {
      const String expectedId = "1";
      Map<String, dynamic> updateData = {
        'displayName': 'Updated Workspace',
        'desc': 'An updated workspace',
        'name': 'Workspace1',
        'website': 'https://example.com'
      };

      when(mockApiService.put('/organizations/1', data: anyNamed('data')))
          .thenAnswer((_) async => Response(
                data: {'id': expectedId},
                statusCode: 200,
                requestOptions: RequestOptions(path: '/organizations/1'),
              ));

      String resultId =
          await workspaceService.updateOrganization("1", updateData);

      expect(resultId, equals(expectedId));
      verify(mockApiService.put('/organizations/1', data: updateData))
          .called(1);
    });

    // Test for deleteOrganization method
    test('deleteOrganization successfully deletes a workspace', () async {
      when(mockApiService.delete('/organizations/1')).thenAnswer((_) async =>
          Response(
              statusCode: 200,
              requestOptions: RequestOptions(path: '/organizations/1')));

      await workspaceService.deleteOrganization("1");

      verify(mockApiService.delete('/organizations/1')).called(1);
    });

    // Test for getOrganizationBoards method
    test('getOrganizationBoards successfully returns a list of boards',
        () async {
      when(mockApiService.get('/organizations/1/boards')).thenAnswer(
          (_) async => Response(
              data: ['Board1', 'Board2'],
              statusCode: 200,
              requestOptions: RequestOptions(path: '/organizations/1/boards')));

      dynamic result = await workspaceService.getOrganizationBoards("1");

      expect(result, equals(['Board1', 'Board2']));
      verify(mockApiService.get('/organizations/1/boards')).called(1);
    });

    // Test for getOrganizationMembers method
    test('getOrganizationMembers successfully returns a list of members',
        () async {
      when(mockApiService.get('/organizations/1/members')).thenAnswer(
          (_) async => Response(
              data: ['Member1', 'Member2'],
              statusCode: 200,
              requestOptions:
                  RequestOptions(path: '/organizations/1/members')));

      dynamic result = await workspaceService.getOrganizationMembers("1");

      expect(result, equals(['Member1', 'Member2']));
      verify(mockApiService.get('/organizations/1/members')).called(1);
    });

    // Test for updateOrganizationMembers method
    test('updateOrganizationMembers successfully updates a list of members',
        () async {
      Map<String, dynamic> updateData = {
        'members': ['Member1', 'Member2']
      };

      when(mockApiService.put('/organizations/1/members',
              data: anyNamed('data')))
          .thenAnswer((_) async => Response(
                statusCode: 200,
                requestOptions:
                    RequestOptions(path: '/organizations/1/members'),
              ));

      await workspaceService.updateOrganizationMembers("1", updateData);

      verify(mockApiService.put('/organizations/1/members', data: updateData))
          .called(1);
    });

    // Test for updateOrganizationMember method
    test('updateOrganizationMember successfully updates a member', () async {
      const String expectedId = "1";
      Map<String, dynamic> updateData = {
        'displayName': 'Updated Member',
        'email': 'allo@test.com',
        'id': '1'
      };

      when(mockApiService.put('/organizations/1/members/1',
              data: anyNamed('data')))
          .thenAnswer((_) async => Response(
                data: {'id': expectedId},
                statusCode: 200,
                requestOptions:
                    RequestOptions(path: '/organizations/1/members/1'),
              ));

      dynamic result =
          await workspaceService.updateOrganizationMember("1", "1", updateData);

      expect(result, equals({'id': expectedId}));
      verify(mockApiService.put('/organizations/1/members/1', data: updateData))
          .called(1);
    });

    // Test for deleteOrganizationMember method
    test('deleteOrganizationMember successfully deletes a member', () async {
      when(mockApiService.delete('/organizations/1/members/1')).thenAnswer(
          (_) async => Response(
              statusCode: 200,
              requestOptions:
                  RequestOptions(path: '/organizations/1/members/1')));

      await workspaceService.deleteOrganizationMember("1", "1");

      verify(mockApiService.delete('/organizations/1/members/1')).called(1);
    });
  });
}
