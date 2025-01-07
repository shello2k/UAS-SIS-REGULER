import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/app_state.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HeadDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    void _showProposalDetails(BuildContext context, proposal, int index) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(proposal.title),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Category: ${proposal.category}',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Text('Details: ${proposal.details}'),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  appState.updateProposalStatus(index, 'Approved');
                  Navigator.of(context).pop();
                },
                child: Text('Approve', style: TextStyle(color: Colors.green)),
              ),
              TextButton(
                onPressed: () {
                  appState.updateProposalStatus(index, 'Rejected');
                  Navigator.of(context).pop();
                },
                child: Text('Reject', style: TextStyle(color: Colors.red)),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Close'),
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Head of Study Program Dashboard',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.orange,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacementNamed(context, 'login');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Incoming Proposals:'),
            Expanded(
              child: ListView.builder(
                itemCount: appState.getProposals().length,
                itemBuilder: (context, index) {
                  final proposal = appState.getProposals()[index];
                  return Card(
                    child: ListTile(
                      onTap: () =>
                          _showProposalDetails(context, proposal, index),
                      title: Text('${proposal.category} - ${proposal.title}'),
                      subtitle: Text(proposal.details),
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
