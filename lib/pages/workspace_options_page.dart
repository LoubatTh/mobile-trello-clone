import 'package:app/services/workspace_service.dart';
import 'package:flutter/material.dart';

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
    return (await showDialog(
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Workspace Options'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder<dynamic>(
              future: membersFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox(
                    width: 60,
                    height: 60,
                    child: Center(child: CircularProgressIndicator()),
                  );
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
                      var memberName = member['name'] as String?;
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
                                    await widget.workspaceService
                                        .deleteOrganizationMember(
                                            widget.workspaceId, memberId);
                                    setState(() {
                                      membersFuture = widget.workspaceService
                                          .getOrganizationMembers(
                                              widget.workspaceId);
                                    });
                                  }
                                },
                              )
                            : null,
                      );
                    }).toList()
                      ..add(
                        Container(
                          margin: const EdgeInsets.all(
                              8.0), // Equivalent to Padding
                          child: ElevatedButton(
                            onPressed: () {
                              // Navigate to add member page
                            },
                            child: const Text('Add Member'),
                          ),
                        ),
                      ),
                  ),
                );
              },
            ),
            ElevatedButton(
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
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Error deleting workspace')),
                    );
                  }
                }
              },
              child: const Text('Delete Workspace'),
            ),
          ],
        ),
      ),
    );
  }
}
