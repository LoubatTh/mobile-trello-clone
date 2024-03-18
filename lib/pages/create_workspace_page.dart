import 'package:flutter/material.dart';
import 'package:app/models/workspace_model.dart';
import 'package:app/services/workspace_service.dart';

class CreateWorkspacePage extends StatefulWidget {
  const CreateWorkspacePage({super.key});

  @override
  CreateWorkspacePageState createState() => CreateWorkspacePageState();
}

class CreateWorkspacePageState extends State<CreateWorkspacePage> {
  final WorkspaceService workspaceService = WorkspaceService();
  final formKey = GlobalKey<FormState>();
  late String name = '';
  late String _desc = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Workspace'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the name';
                  }
                  if (value.length < 3) {
                    return 'Name must be at least 3 letters long';
                  }
                  if (!RegExp(r'^[a-zA-Z0-9\s]+$').hasMatch(value)) {
                    return 'Name can only contain letters, numbers, and spaces';
                  }
                  return null;
                },
                onSaved: (value) => name = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Description'),
                onSaved: (value) => _desc = value ?? '',
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      createWorkspace();
                    }
                  },
                  child: const Text('Create Workspace'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> createWorkspace() async {
    WorkspaceModel newWorkspace = WorkspaceModel.forCreation(
      displayName: name,
      desc: _desc,
    );

    try {
      await workspaceService.createOrganization(newWorkspace);
      if (!mounted) return;
      Navigator.pop(context, true);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error creating workspace: $e'),
        ),
      );
    }
  }
}
