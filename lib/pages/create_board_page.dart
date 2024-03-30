import 'package:app/models/board_model.dart';
import 'package:flutter/material.dart';
import 'package:app/models/workspace_model.dart';
import 'package:app/services/workspace_service.dart';
import 'package:app/services/board_service.dart';
import 'package:app/services/api_service.dart';

class CreateBoardPage extends StatefulWidget {
  const CreateBoardPage({super.key});

  @override
  CreateBoardPageState createState() => CreateBoardPageState();
}

class CreateBoardPageState extends State<CreateBoardPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late final BoardService boardService;
  late final WorkspaceService workspaceService;
  String boardName = '';
  String? selectedWorkspaceId;
  String? selectedTemplateId;
  String? boardDescription;
  List<WorkspaceModel> workspaces = [];
  bool isLoading = true;
  final projectManagement = '5c4efa1d25a9692173830e7f';
  final weeklyPlanning = '5ec98d97f98409568dd89dff';
  final employeeHandbook = '5994bf29195fa87fb9f27709';
  final kanban = '5e6005043fbdb55d9781821e';
  final weeklyMeeting = '5b78b8c106c63923ffe26520';
  final goToMarket = '5aaafd432693e874ec11495c';
  final agileBoard = '591ca6422428d5f5b2794aee';
  final companyVision = '5994be8ce20c9b37589141c2';

  @override
  void initState() {
    super.initState();
    boardService = BoardService(apiService: ApiService());
    workspaceService = WorkspaceService(apiService: ApiService());
    fetchWorkspaces();
  }

  Future<void> fetchWorkspaces() async {
    try {
      var fetchedWorkspaces = await workspaceService.getMemberOrganizations();
      setState(() {
        workspaces = fetchedWorkspaces;
        isLoading = false;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch workspaces: $e')),
      );
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> createBoard() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      
      NewBoardModel newBoard = NewBoardModel(
        name: boardName,
        idOrganization: selectedWorkspaceId!,
      );

      String? idBoardSource;
      switch (selectedTemplateId) {
        case 'projectManagement':
          idBoardSource = projectManagement;
          break;
        case 'weeklyMeeting':
          idBoardSource = weeklyMeeting;
          break;
        case 'agileBoard':
          idBoardSource = agileBoard;
          break;
        case 'companyVision':
          idBoardSource = companyVision;
          break;
        case 'kanban':
          idBoardSource = kanban;
          break;
        case 'weeklyPlanning':
          idBoardSource = weeklyPlanning;
          break;
        case 'employeeHandbook':
          idBoardSource = employeeHandbook;
          break;
        case 'goToMarket':
          idBoardSource = goToMarket;
          break;
        default:
          idBoardSource = null;
      }

      if (idBoardSource != null) {
        newBoard.idBoardSource = idBoardSource;
      }

      if (boardDescription != null && boardDescription!.trim().isNotEmpty) {
        newBoard.desc = boardDescription;
      }

      try {
        await boardService.createBoard(newBoard.name, idOrganization: newBoard.idOrganization);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Board created successfully')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to create board: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Board')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                  labelText: 'Board Name'),
                              validator: (value) =>
                                  value == null || value.isEmpty
                                      ? 'Please enter board name'
                                      : null,
                              onSaved: (value) => boardName = value!,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                  labelText: 'Description (Optional)'),
                              onSaved: (value) => boardDescription = value,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: DropdownButtonFormField<String?>(
                              value: selectedWorkspaceId,
                              hint: const Text('Select Workspace'),
                              onChanged: (newValue) {
                                setState(() => selectedWorkspaceId = newValue);
                              },
                              validator: (value) => value == null
                                  ? 'Workspace is required'
                                  : null,
                              items: workspaces
                                  .map((workspace) => DropdownMenuItem<String?>(
                                        value: workspace.id,
                                        child: Text(workspace.displayName),
                                      ))
                                  .toList(),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: DropdownButtonFormField<String?>(
                              value: selectedTemplateId,
                              hint: const Text('Select Template (Optional)'),
                              onChanged: (newValue) {
                                setState(() => selectedTemplateId = newValue);
                              },
                              items: const [
                                DropdownMenuItem<String?>(
                                    value: null, child: Text('No Template')),
                                DropdownMenuItem<String?>(
                                    value: 'projectManagement',
                                    child: Text('Project Management')),
                                DropdownMenuItem<String?>(
                                    value: 'weeklyMeeting',
                                    child: Text('Weekly Meeting')),
                                DropdownMenuItem<String?>(
                                    value: 'agileBoard',
                                    child: Text('Agile Board')),
                                DropdownMenuItem<String?>(
                                    value: 'companyVision',
                                    child: Text('Company Vision')),
                                DropdownMenuItem<String?>(
                                    value: 'kanban', child: Text('Kanban')),
                                DropdownMenuItem<String?>(
                                    value: 'weeklyPlanning',
                                    child: Text('Weekly Planning')),
                                DropdownMenuItem<String?>(
                                    value: 'employeeHandbook',
                                    child: Text('Employee Handbook')),
                                DropdownMenuItem<String?>(
                                    value: 'goToMarket',
                                    child: Text('Go To Market')),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 52.0, horizontal: 16.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50.0,
                    child: ElevatedButton(
                      onPressed: createBoard,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: const Text('Create Board'),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
