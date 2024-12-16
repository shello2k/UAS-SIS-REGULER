import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/email.dart';
import 'package:flutter_application_1/models/proposal.dart';

class AppState with ChangeNotifier {
  final List<Email> _emails = [];
  List<Proposal> proposals = [];

  List<Email> get emails => _emails;

  // Email related methods
  void addEmail(Email email) {
    _emails.add(email);
    notifyListeners();
  }

  void updateEmailStatus(int index, String status) {
    _emails[index].status = status;
    notifyListeners();
  }

  void forwardEmail(int index, String forwardTo) {
    _emails[index].forwardTo = forwardTo;
    notifyListeners();
  }

  // Proposal related methods (Corrected placement)
  
  // CREATE: Add a new proposal
  void addProposal(Proposal proposal) {
    proposals.add(proposal);
    notifyListeners();
  }

  // READ: Get the list of proposals
  List<Proposal> getProposals() {
    return proposals;
  }

  // UPDATE: Change the status of a proposal
  void updateProposalStatus(int index, String newStatus) {
    proposals[index].status = newStatus;
    notifyListeners();
  }

  // DELETE: Remove a proposal
  void deleteProposal(int index) {
    proposals.removeAt(index);
    notifyListeners();
  }
}
