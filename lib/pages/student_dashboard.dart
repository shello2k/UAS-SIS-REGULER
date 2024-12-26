import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/app_state.dart';
import 'package:flutter_application_1/models/proposal.dart';

class StudentDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    final detailsController = TextEditingController();
    final titleController = TextEditingController();
    String? selectedCategory; 

    void _submitProposal() {
  if (selectedCategory == null || titleController.text.isEmpty || detailsController.text.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Please complete all fields before submitting.')),
    );
    return;
  }

    final proposal = Proposal(
      category: selectedCategory!, 
      title: titleController.text,
      details: detailsController.text,
      status: 'Submitted', 
    );
    appState.addProposal(proposal);
    selectedCategory = null;
    titleController.clear();
    detailsController.clear();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Proposal Submitted')),
    );
  }


    return Scaffold(
      appBar: AppBar(title: Text('Student Dashboard')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: selectedCategory,
              items: [
                'Peminjaman Ruangan',
                'Peminjaman Asset',
                'Bimbingan'
              ].map((subject) {
                return DropdownMenuItem(
                  value: subject,
                  child: Text(subject),
                );
              }).toList(),
              decoration: InputDecoration(labelText: 'Proposal Category'),
              onChanged: (value) {
                selectedCategory = value;
              },
            ),
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Proposal Title'),
              maxLines: 4,
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
                      title: Text('${proposal.category} - ${proposal.title}'),
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
