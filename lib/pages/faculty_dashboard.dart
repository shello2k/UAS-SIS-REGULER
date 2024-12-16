import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/app_state.dart';

class FacultyDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Faculty Dashboard')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Proposals for Final Review:'),
            Expanded(
              child: ListView.builder(
                itemCount: appState.getProposals().length,
                itemBuilder: (context, index) {
                  final proposal = appState.getProposals()[index];
                  return Card(
                    child: ListTile(
                      title: Text(proposal.title),
                      subtitle: Text(proposal.details),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              appState.updateProposalStatus(index, 'Final Approved');
                            },
                            icon: Icon(Icons.check, color: Colors.green),
                          ),
                          IconButton(
                            onPressed: () {
                              appState.updateProposalStatus(index, 'Final Rejected');
                            },
                            icon: Icon(Icons.close, color: Colors.red),
                          ),
                        ],
                      ),
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
