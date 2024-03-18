import 'package:flutter/material.dart';
import 'package:app/models/board_model.dart';
import 'package:app/services/board_service.dart';
import 'package:app/models/workspace_model.dart';
import 'package:app/pages/create_workspace_page.dart';
import 'package:app/services/workspace_service.dart';
import 'package:app/pages/workspace_options_page.dart';

class WorkspacePage extends StatefulWidget {
  const WorkspacePage({Key? key}) : super(key: key);

  @override
  _WorkspacePageState createState() => _WorkspacePageState();
}

class WorkspacePageState extends State<WorkspacePage> {
  late Future<List<WorkspaceModel>> organizationsFuture;
  late Future<List<ShortBoard>> boardsFuture;
  final WorkspaceService workspaceService = WorkspaceService();
  final BoardService boardService = BoardService();

  @override
  void initState() {
    super.initState();
    loadWorkspacesAndBoards();
  }

  void loadWorkspacesAndBoards() {
    organizationsFuture = workspaceService.getMemberOrganizations();
    boardsFuture = boardService.getMemberBoards();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: FutureBuilder<List<WorkspaceModel>>(
        future: organizationsFuture,
        builder: (context, workspaceSnapshot) {
          if (workspaceSnapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (workspaceSnapshot.hasError) {
            return Text('Error: ${workspaceSnapshot.error}');
          } else if (workspaceSnapshot.hasData) {
            return FutureBuilder<List<ShortBoard>>(
              future: boardsFuture,
              builder: (context, boardsSnapshot) {
                if (!boardsSnapshot.hasData) return const CircularProgressIndicator();

                Set<String> displayedBoardIds = {};
                List<Widget> workspaceWidgets = workspaceSnapshot.data!.map((workspace) {
                  List<ShortBoard> workspaceBoards = boardsSnapshot.data!.where((board) {
                    return board.idOrganization == workspace.id && displayedBoardIds.add(board.id!);
                  }).toList();

                  return Column(
                    children: [
                      buildWorkspaceCard(workspace),
                      ...workspaceBoards.map((board) => ListTile(
                            leading: const Icon(Icons.dashboard),
                            title: Text(board.name),
                          )),
                    ],
                  );
                }).toList();

                List<ShortBoard> guestWorkspaceBoards = boardsSnapshot.data!.where((board) => !displayedBoardIds.contains(board.id)).toList();
                if (guestWorkspaceBoards.isNotEmpty) {
                  workspaceWidgets.add(Column(
                    children: [
                      const ListTile(title: Text('Guest Workspace')),
                      ...guestWorkspaceBoards.map((board) => ListTile(
                            leading: const Icon(Icons.dashboard),
                            title: Text(board.name),
                          )),
                    ],
                  ));
                }

                return ListView(
                  children: workspaceWidgets,
                );
              },
            );
          } else {
            return const Text('No workspaces found');
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreateWorkspacePage()),
          );
          if (result == true) {
            loadWorkspacesAndBoards();
          }
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget buildWorkspaceCard(WorkspaceModel workspace) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: ListTile(
        title: Text(workspace.displayName),
        trailing: IconButton(
          icon: const Icon(Icons.more_vert),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => WorkspaceOptionsPage(
                workspaceId: workspace.id!,
                workspaceService: workspaceService,
              ),
            ));
          },
        ),
      ),
    );
  }
}
