import 'package:flutter/material.dart';
import 'package:app/pages/create_board_page.dart';
import 'package:app/models/board_model.dart';
import 'package:app/services/board_service.dart';
import 'package:app/models/workspace_model.dart';
import 'package:app/pages/create_workspace_page.dart';
import 'package:app/services/workspace_service.dart';
import 'package:app/pages/workspace_options_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  late Future<List<WorkspaceModel>> organizationsFuture;
  late Future<List<ShortBoardModel>> boardsFuture;
  final WorkspaceService workspaceService = WorkspaceService();
  final BoardService boardService = BoardService();
  bool isFABOpen = false;

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
      body: buildBody(),
      floatingActionButton: buildFloatingActionButton(),
    );
  }

  Widget buildBody() {
    return FutureBuilder<List<WorkspaceModel>>(
      future: organizationsFuture,
      builder: (context, workspaceSnapshot) {
        if (workspaceSnapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (workspaceSnapshot.hasError) {
          return Text('Error: ${workspaceSnapshot.error}');
        } else if (workspaceSnapshot.hasData) {
          return FutureBuilder<List<ShortBoardModel>>(
            future: boardsFuture,
            builder: (context, boardsSnapshot) {
              if (!boardsSnapshot.hasData) {
                return const CircularProgressIndicator();
              }

              Set<String> displayedBoardIds = {};
              List<Widget> workspaceWidgets =
                  workspaceSnapshot.data!.map((workspace) {
                List<ShortBoardModel> workspaceBoards =
                    boardsSnapshot.data!.where((board) {
                  return board.idOrganization == workspace.id &&
                      displayedBoardIds.add(board.id!);
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

              List<ShortBoardModel> guestWorkspaceBoards = boardsSnapshot.data!
                  .where((board) => !displayedBoardIds.contains(board.id))
                  .toList();
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
    );
  }

  Widget buildFloatingActionButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (isFABOpen)
          FloatingActionButton(
            heroTag: 'createBoard',
            mini: true,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const CreateBoardPage()),
              ).then((value) {
                if (value == true) {
                  loadWorkspacesAndBoards();
                }
              });
              setState(() {
                isFABOpen = !isFABOpen;
              });
            },
            backgroundColor: Theme.of(context).primaryColor,
            child: const Icon(Icons.dashboard),
          ),
        if (isFABOpen)
          FloatingActionButton(
            heroTag: 'createWorkspace',
            mini: true,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const CreateWorkspacePage()),
              ).then((value) {
                if (value == true) {
                  loadWorkspacesAndBoards();
                }
              });
              setState(() {
                isFABOpen = !isFABOpen;
              });
            },
            backgroundColor: Theme.of(context).primaryColor,
            child: const Icon(Icons.work),
          ),
        FloatingActionButton(
          heroTag: 'toggleFAB',
          onPressed: () {
            setState(() {
              isFABOpen = !isFABOpen;
            });
          },
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(isFABOpen ? Icons.close : Icons.add),
        ),
      ],
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
