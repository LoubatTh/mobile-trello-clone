import 'package:flutter/material.dart';
import 'package:app/models/workspace_model.dart';

class WorkspaceSidePanel extends StatelessWidget {
  final List<WorkspaceModel> workspaces;
  final Function(String workspaceId) onSelectWorkspace;

  const WorkspaceSidePanel({
    super.key,
    required this.workspaces,
    required this.onSelectWorkspace,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView.builder(
        itemCount: workspaces.length,
        itemBuilder: (context, index) {
          var workspace = workspaces[index];
          return ListTile(
            title: Text(workspace.displayName),
            trailing: IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () => onSelectWorkspace(workspace.id!),
            ),
          );
        },
      ),
    );
  }
}
