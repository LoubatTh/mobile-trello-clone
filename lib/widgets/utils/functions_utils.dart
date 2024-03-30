 import 'package:flutter/material.dart';

void _showLabelsPopup(BuildContext context) {
    // Afficher la pop-up des labels ici
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Labels...'),
          content: const SingleChildScrollView(
            child: Column(
              children: <Widget>[
                // Ajouter ici la liste des labels
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _showChecklistsPopup(BuildContext context) {
    // Afficher la pop-up des checklists ici
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Checklists...'),
          content: const SingleChildScrollView(
            child: Column(
              children: <Widget>[
                // Ajouter ici la liste des checklists
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _showMembersPopup(BuildContext context) {
    // Afficher la pop-up des membres ici
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Members...'),
          content: const SingleChildScrollView(
            child: Column(
              children: <Widget>[
                // Ajouter ici la liste des membres
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }