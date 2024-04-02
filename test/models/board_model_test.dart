import 'package:flutter_test/flutter_test.dart';
import 'package:app/models/board_model.dart';

void main() {
  group('ShortBoardModel', () {
    test('fromJson creates a valid instance', () {
      final json = {
        'id': '1',
        'name': 'Test Board',
        'desc': 'A description of the test board',
        'idMemberCreator': '123',
        'idOrganization': '456'
      };

      final result = ShortBoardModel.fromJson(json);

      expect(result, isA<ShortBoardModel>());
      expect(result.id, '1');
      expect(result.name, 'Test Board');
      expect(result.desc, 'A description of the test board');
      expect(result.idMemberCreator, '123');
      expect(result.idOrganization, '456');
    });
  });
  group('NewBoardModel', () {
    test('toJson converts a full model to a JSON map including optional fields', () {
      final model = NewBoardModel(
        name: 'Test Board',
        idOrganization: 'org123',
        desc: 'A test board description',
        idBoardSource: 'source123',
      );

      final result = model.toJson();

      expect(result, isA<Map<String, dynamic>>());
      expect(result['name'], 'Test Board');
      expect(result['idOrganization'], 'org123');
      expect(result['desc'], 'A test board description');
      expect(result['idBoardSource'], 'source123');
    });

    test('toJson converts a model to a JSON map without optional fields when not provided', () {
      final model = NewBoardModel(
        name: 'Test Board Without Optional',
        idOrganization: 'org456',
      );

      final result = model.toJson();

      expect(result, isA<Map<String, dynamic>>());
      expect(result['name'], 'Test Board Without Optional');
      expect(result['idOrganization'], 'org456');
      expect(result['desc'], isNull);
      expect(result['idBoardSource'], isNull);
    });
  });
}
