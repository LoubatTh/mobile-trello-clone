import 'package:flutter_test/flutter_test.dart';
import 'package:app/models/list_model.dart';

void main() {
  group('ListModel', () {
    test('fromJson creates a valid instance', () {
      // Define the JSON map representation of a ListModel
      final json = {
        'id': 'list1',
        'name': 'ToDo',
        'closed': false,
        'pos': 12345,
        'idBoard': 'board1',
      };

      // Convert the JSON map to a ListModel instance
      final list = ListModel.fromJson(json);

      // Verify that the ListModel instance matches the JSON map
      expect(list.id, json['id']);
      expect(list.name, json['name']);
      expect(list.closed, json['closed']);
      expect(list.pos, json['pos']);
      expect(list.idBoard, json['idBoard']);
    });

    test('toJson converts a ListModel instance to a JSON map', () {
      // Create a ListModel instance
      final list = ListModel(
        id: 'list1',
        name: 'ToDo',
        closed: false,
        pos: 12345,
        idBoard: 'board1',
      );

      // Convert the ListModel instance to a JSON map
      final json = list.toJson();

      // Verify that the JSON map matches the ListModel instance
      expect(json['name'], list.name);
      expect(json['pos'], list.pos);
      // Note: toJson only includes 'name' and 'pos' in this implementation
    });
  });
}
