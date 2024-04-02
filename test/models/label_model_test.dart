import 'package:flutter_test/flutter_test.dart';
import 'package:app/models/label_model.dart';

void main() {
  group('Label', () {
    // Test for fromJson
    test('fromJson creates a valid instance of Label', () {
      final json = {
        'id': 'label1',
        'name': 'High Priority',
        'color': 'red',
      };

      final label = Label.fromJson(json);

      expect(label, isA<Label>());
      expect(label.id, equals('label1'));
      expect(label.name, equals('High Priority'));
      expect(label.color, equals('red'));
    });

    // Test for toJson
    test('toJson converts a Label instance to a JSON map', () {
      final label = Label(
        id: 'label1',
        name: 'High Priority',
        color: 'red',
      );

      final json = label.toJson();

      expect(json['id'], equals('label1'));
      expect(json['name'], equals('High Priority'));
      expect(json['color'], equals('red'));
    });
  });
}
