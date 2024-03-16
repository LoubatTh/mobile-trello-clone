import 'package:app/models/workspace_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('WorkspaceModel', () {
    // Test the fromJson and toJson methods
    test('fromJson creates correct instance from JSON', () {
      const id = '1';
      const displayName = 'Test Workspace';
      const desc = 'This is a test workspace';
      const idMemberCreator = 'creatorId';
      List<String> idBoards = ['board1', 'board2'];
      // Create a JSON object
      final json = {
        'id': id,
        'displayName': displayName,
        'desc': desc,
        'idBoards': idBoards,
        'idMemberCreator': idMemberCreator,
      };
      // Create a WorkspaceModel instance from the JSON object
      final workspace = WorkspaceModel.fromJson(json);
      // Check that the instance has the correct properties
      expect(workspace.id, id);
      expect(workspace.displayName, displayName);
      expect(workspace.desc, desc);
      expect(workspace.idBoards, idBoards);
      expect(workspace.idMemberCreator, idMemberCreator);
    });

    // Test the forCreation method
    test('toJson correctly converts instance to JSON', () {
      const displayName = 'New Workspace';
      const desc = 'Description of the new workspace';
      // Create a WorkspaceModel instance
      final workspace = WorkspaceModel.forCreation(
        displayName: displayName,
        desc: desc,
      );
      // Convert the instance to a JSON object
      final json = workspace.toJson();
      // Check that the JSON object has the correct properties
      expect(json['displayName'], displayName);
      expect(json['desc'], desc);
    });
  });
}
