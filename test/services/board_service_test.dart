import 'package:app/models/board_model.dart';
import 'package:app/services/board_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../mock/mock_api_service.mocks.dart';

void main() async {
  group('BoardService Tests', () {
    late BoardService boardService;
    late MockApiService mockApiService;
    late BoardModel boardModel;
    late ShortBoardModel shortBoardModel;

    setUp(() {
      mockApiService = MockApiService();
      boardService = BoardService(apiService: mockApiService);
      shortBoardModel = ShortBoardModel(
        id: "1",
        name: "Test Board",
        idOrganization: "1",
      );
      boardModel = BoardModel(
        id: "1",
        name: "Test Board",
        desc: "A test board",
        descData: "A test board",
        closed: false,
        idMemberCreator: "1",
        idOrganization: "1",
        pinned: false,
        url: "https://example.com",
        shortUrl: "https://example.com",
        prefs: Prefs(
          permissionLevel: "private",
          hideVotes: true,
          voting: "disabled",
          comments: "members",
          selfJoin: false,
          cardCovers: true,
          isTemplate: false,
          cardAging: "regular",
          calendarFeedEnabled: false,
          background: "blue",
          backgroundImage: "https://example.com",
          backgroundImageScaled: [],
          backgroundTile: false,
          backgroundBrightness: "dark",
          backgroundBottomColor: "blue",
          backgroundTopColor: "blue",
          canBePublic: true,
          canBeEnterprise: true,
          canBeOrg: true,
          canBePrivate: true,
          canInvite: true,
        ),
        labelNames: {
          "green": "label1",
          "yellow": "label2",
          "orange": "label3",
          "red": "label4",
          "purple": "label5",
          "blue": "label6",
          "sky": "label7",
          "lime": "label8",
          "pink": "label9",
          "black": "label10",
        },
        limits: Limits(
          attachments: Attachments(
            status: "ok",
            disableAt: 1000,
            warnAt: 900,
          ),
        ),
        starred: false,
        memberships: "<string>",
        shortLink: "<string>",
        subscribed: true,
        powerUps: "<string>",
        dateLastActivity: "<string>",
        dateLastView: "<string>",
        idTags: "<string>",
        datePluginDisable: "<string>",
        creationMethod: "<string>",
        ixUpdate: 1,
        templateGallery: "<string>",
        enterpriseOwned: true,
      );
    });

    test('create board', () async {
      const String expectedId = "1";
      String name = "Test Board";

      when(mockApiService.post('/boards', data: anyNamed('data')))
          .thenAnswer((_) async => Response(
                data: {'id': expectedId},
                statusCode: 200,
                requestOptions: RequestOptions(path: '/boards'),
              ));

      String resultId = await boardService.createBoard(name);

      expect(resultId, equals(expectedId));
      verify(mockApiService.post('/boards', data: {'name': name})).called(1);
    });

    test('get board', () async {
      when(mockApiService.get('/members/me/boards/1'))
          .thenAnswer((_) async => Response(
                data: boardModel,
                statusCode: 200,
                requestOptions: RequestOptions(path: '/members/me/boards/1'),
              ));

      BoardModel result = await boardService.getBoard("1");

      expect(result, equals(boardModel));
      verify(mockApiService.get('/members/me/boards/1')).called(1);
    });

    test('get all boards', () async {
      when(mockApiService.get('/members/me/boards',
              data: {'fields': 'name,desc'}))
          .thenAnswer((_) async => Response(
                data: [shortBoardModel],
                statusCode: 200,
                requestOptions: RequestOptions(path: '/members/me/boards'),
              ));

      List<ShortBoardModel> result = await boardService.getAllBoards();

      expect(result, equals([shortBoardModel]));
      verify(mockApiService.get('/members/me/boards',
          data: {'fields': 'name,desc'})).called(1);
    });

    test('get all workspace boards', () async {
      when(mockApiService.get('/organization/1/boards'))
          .thenAnswer((_) async => Response(
                data: [shortBoardModel],
                statusCode: 200,
                requestOptions: RequestOptions(path: '/organization/1/boards'),
              ));

      List<ShortBoardModel> result = await boardService.getAllWorkspaceBoards("1");

      expect(result, equals([shortBoardModel]));
      verify(mockApiService.get('/organization/1/boards')).called(1);
    });

    test('update board', () async {
      String name = "Rename Test Board";

      when(mockApiService.put('/boards/1', data: anyNamed('data')))
          .thenAnswer((_) async => Response(
                data: name,
                statusCode: 200,
                requestOptions: RequestOptions(path: '/boards/1'),
              ));

      String result = await boardService.renameBoard("1", name);

      expect(result, equals(name));
      verify(mockApiService.put('/boards/1', data: {'name': name})).called(1);
    });

    test('delete board', () async {
      when(mockApiService.delete('/boards/1')).thenAnswer((_) async => Response(
            data: {'id': "1"},
            statusCode: 200,
            requestOptions: RequestOptions(path: '/boards/1'),
          ));

      String result = await boardService.deleteBoard("1");

      expect(result, equals("1"));
      verify(mockApiService.delete('/boards/1')).called(1);
    });
  });
}
