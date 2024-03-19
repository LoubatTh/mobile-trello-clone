import 'package:flutter/material.dart';
import 'package:app/models/workspace_model.dart';
import 'package:app/pages/create_workspace_page.dart';
import 'package:app/pages/workspace_options_page.dart';
import 'package:app/services/workspace_service.dart';
import 'package:app/widgets/workspace_sidepanel_widget.dart';
import 'package:app/services/member_service.dart';
import 'package:app/services/user_helper.dart';

class WorkspacePage extends StatefulWidget {
  const WorkspacePage({Key? key}) : super(key: key);

  @override
  _WorkspacePageState createState() => _WorkspacePageState();
}

class _WorkspacePageState extends State<WorkspacePage> {
  late Future<List<WorkspaceModel>> organizationsFuture = Future.value([]);
  final WorkspaceService workspaceService = WorkspaceService();
  final MemberService memberService = MemberService();

  @override
  void initState() {
    super.initState();
    loadWorkspaces();
  }

  void loadWorkspaces() {
    getUserNameAsyncUser().then((userId) {
      setState(() {
        organizationsFuture = memberService.getMemberOrganizations(userId!);
      });
    });
  }

  Future<String?> getUserNameAsyncUser() async {
    return await DatabaseHelper.instance.getUsername();
  }

  void onSelectWorkspace(String workspaceId) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WorkspaceOptionsPage(
          workspaceId: workspaceId,
          workspaceService: workspaceService,
        ),
      ),
    );

    if (result == true) {
      loadWorkspaces();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Workspaces'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const CreateWorkspacePage()),
              );

              if (result == true) {
                loadWorkspaces();
              }
            },
          ),
        ],
      ),
      drawer: FutureBuilder<List<WorkspaceModel>>(
        future: organizationsFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Drawer();
          return WorkspaceSidePanel(
            workspaces: snapshot.data!,
            onSelectWorkspace: onSelectWorkspace,
          );
        },
      ),
      body: FutureBuilder<List<WorkspaceModel>>(
        future: organizationsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var workspace = snapshot.data![index];
                return Card(
                  child: ListTile(
                    title: Text(workspace.displayName),
                    subtitle:
                        Text('Boards: ${workspace.idBoards?.length ?? 0}'),
                  ),
                );
              },
            );
          } else {
            return const Text('No workspaces found');
          }
        },
      ),
    );
  }
}
