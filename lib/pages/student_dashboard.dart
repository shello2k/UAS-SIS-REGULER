import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/app_state.dart';
import 'package:flutter_application_1/models/proposal.dart';

class StudentDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    final titleController = TextEditingController();
    final detailsController = TextEditingController();

    void _submitProposal() {
      final proposal = Proposal(
        title: titleController.text,
        details: detailsController.text,
        status: 'Submitted', // Default status
      );
      appState.addProposal(proposal);
      titleController.clear();
      detailsController.clear();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Proposal Submitted')));
    }

    return Scaffold(
      appBar: AppBar(title: Text('Student Dashboard')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Proposal Title'),
            ),
            TextField(
              controller: detailsController,
              decoration: InputDecoration(labelText: 'Proposal Details'),
              maxLines: 4,
            ),
            ElevatedButton(
              onPressed: _submitProposal,
              child: Text('Submit Proposal'),
            ),
            SizedBox(height: 20),
            Text('Submitted Proposals:'),
            Expanded(
              child: ListView.builder(
                itemCount: appState.getProposals().length,
                itemBuilder: (context, index) {
                  final proposal = appState.getProposals()[index];
                  return Card(
                    child: ListTile(
                      title: Text(proposal.title),
                      subtitle: Text(proposal.details),
                      trailing: Text(proposal.status),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
