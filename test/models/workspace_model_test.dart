import 'package:flutter_test/flutter_test.dart';
import 'package:app/models/workspace_model.dart';

void main() {
  group('WorkspaceModel', () {
    //////////////////////////////////////////////////////////////
    //      Test case for verifying the `fromJson` method       //
    //////////////////////////////////////////////////////////////
    test('fromJson returns a valid instance of WorkspaceModel', () {
      final json = {
        'id': '1',
        'displayName': 'Test Workspace',
        'desc': 'A description of the workspace',
        'name': 'TestName',
        'website': 'http://example.com',
      };

      final workspace = WorkspaceModel.fromJson(json);

      expect(workspace.id, '1');
      expect(workspace.displayName, 'Test Workspace');
      expect(workspace.desc, 'A description of the workspace');
      expect(workspace.name, 'TestName');
      expect(workspace.website, 'http://example.com');
    });

    //////////////////////////////////////////////////////////////
    ///     Test case for verifying the `toJson` method         //
    //////////////////////////////////////////////////////////////
    test('toJson returns a map that matches the WorkspaceModel properties', () {
      final workspace = WorkspaceModel(
        id: '1',
        displayName: 'Test Workspace',
        desc: 'A description of the workspace',
        name: 'TestName',
        website: 'http://example.com',
      );

      final json = workspace.toJson();

      expect(json['id'], '1');
      expect(json['displayName'], 'Test Workspace');
      expect(json['desc'], 'A description of the workspace');
      expect(json['name'], 'TestName');
      expect(json['website'], 'http://example.com');
    });
  });
}
