import 'package:flutter/material.dart';
import 'package:app/services/workspace_service.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

class WorkspaceOptionsPage extends StatefulWidget {
  final String workspaceId;
  final WorkspaceService workspaceService;

  const WorkspaceOptionsPage({
    super.key,
    required this.workspaceId,
    required this.workspaceService,
  });

  @override
  WorkspaceOptionsPageState createState() => WorkspaceOptionsPageState();
}

class WorkspaceOptionsPageState extends State<WorkspaceOptionsPage> {
  late Future<dynamic> membersFuture;

  @override
  void initState() {
    super.initState();
    membersFuture =
        widget.workspaceService.getOrganizationMembers(widget.workspaceId);
  }

  Future<bool> showConfirmationDialog(
      BuildContext context, String message) async {
    return (await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Confirmation"),
            content: Text(message),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text("Yes"),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text("No"),
              ),
            ],
          ),
        )) ??
        false;
  }

  void showAddMemberDialog(BuildContext context) {
    TextEditingController emailOrUsernameController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text("Invite New Member"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text("Invite a new guest with his Trello username or ID"),
              TextField(
                controller: emailOrUsernameController,
                decoration: const InputDecoration(
                  hintText: "Username or ID",
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("Cancel"),
              onPressed: () => Navigator.of(dialogContext).pop(),
            ),
            TextButton(
              child: const Text("Invite"),
              onPressed: () async {
                try {
                  await widget.workspaceService.addOrganizationMember(
                      widget.workspaceId,
                      emailOrUsernameController.text,
                      "normal");
                  Navigator.of(dialogContext).pop();
                  scaffoldMessengerKey.currentState?.showSnackBar(
                    const SnackBar(
                        content: Text('Member invited successfully!')),
                  );
                } catch (e) {
                  Navigator.of(dialogContext).pop();
                  scaffoldMessengerKey.currentState?.showSnackBar(
                    SnackBar(content: Text('Failed to invite member: $e')),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Utilize the ScaffoldMessengerKey in the ScaffoldMessenger
    return ScaffoldMessenger(
      key: scaffoldMessengerKey,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Workspace Options'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () async {
                final confirmation = await showConfirmationDialog(
                    context, "Are you sure you want to delete this workspace?");
                if (confirmation) {
                  try {
                    await widget.workspaceService
                        .deleteOrganization(widget.workspaceId);
                    if (!mounted) return;
                    Navigator.pop(context, true);
                  } catch (e) {
                    if (!mounted) return;
                    scaffoldMessengerKey.currentState?.showSnackBar(
                      SnackBar(content: Text('Error deleting workspace: $e')),
                    );
                  }
                }
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: FutureBuilder<dynamic>(
            future: membersFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError || snapshot.data == null) {
                return Text('Error: ${snapshot.error ?? "Unknown error"}');
              }

              var members = snapshot.data as List<dynamic>;
              if (members.isEmpty) {
                return const Text('No members found');
              }

              return Card(
                child: Column(
                  children: members.map<Widget>((member) {
                    var memberId = member['id'] as String?;
                    var memberName = member['username'] as String?;
                    return ListTile(
                      title: Text(memberName ?? 'Unknown Member'),
                      trailing: memberId != null &&
                              memberId != widget.workspaceId
                          ? IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () async {
                                final confirmation = await showConfirmationDialog(
                                    context,
                                    "Are you sure you want to delete this member?");
                                if (confirmation) {
                                  try {
                                    await widget.workspaceService
                                        .deleteOrganizationMember(
                                            widget.workspaceId, memberId);
                                    if (!mounted) return;
                                    setState(() {
                                      membersFuture = widget.workspaceService
                                          .getOrganizationMembers(
                                              widget.workspaceId);
                                    });
                                  } catch (e) {
                                    if (!mounted) return;
                                    scaffoldMessengerKey.currentState
                                        ?.showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              'Error deleting member: $e')),
                                    );
                                  }
                                }
                              },
                            )
                          : null,
                    );
                  }).toList(),
                ),
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showAddMemberDialog(context);
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
