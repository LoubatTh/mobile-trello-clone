import 'package:flutter_test/flutter_test.dart';
import 'package:app/models/member_model.dart';

void main() {
  group('MemberModel', () {
    // Test for fromJson
    test('fromJson creates a valid instance of MemberModel', () {
      final json = {
        'id': 'member1',
        'avatarUrl': 'http://example.com/avatar.jpg',
        'fullName': 'John Doe',
        'username': 'john_doe',
        'idOrganizations': ['org1', 'org2'],
        'idBoards': ['board1', 'board2'],
      };

      final member = MemberModel.fromJson(json);

      expect(member, isA<MemberModel>());
      expect(member.id, equals('member1'));
      expect(member.avatarUrl, equals('http://example.com/avatar.jpg'));
      expect(member.fullName, equals('John Doe'));
      expect(member.username, equals('john_doe'));
      expect(member.idOrganizations, equals(['org1', 'org2']));
      expect(member.idBoards, equals(['board1', 'board2']));
    });

    // Test for toJson
    test('toJson converts a MemberModel instance to a JSON map', () {
      final member = MemberModel(
        id: 'member1',
        avatarUrl: 'http://example.com/avatar.jpg',
        fullName: 'John Doe',
        username: 'john_doe',
        idOrganizations: ['org1', 'org2'],
        idBoards: ['board1', 'board2'],
      );

      final json = member.toJson();

      expect(json, isA<Map<String, dynamic>>());
      expect(json['fullname'], equals('John Doe'));
      // If you update toJson to include more properties, assert them here
    });
  });
}
