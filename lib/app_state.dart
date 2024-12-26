import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/email.dart';
import 'package:flutter_application_1/models/proposal.dart';
import 'package:flutter_application_1/models/user.dart';  // Import User model

class AppState with ChangeNotifier {
  final List<User> _users = [];
  final List<Email> _emails = []; 
  List<Proposal> proposals = [];
  
  List<User> getUsers() {
    return _users;
  }

  void addUser(User user) {
    _users.add(user);
    notifyListeners();
  }

  void updateUser(int index, User updatedUser) {
    _users[index] = updatedUser;
    notifyListeners();
  }

  void deleteUser(int index) {
    _users.removeAt(index);
    notifyListeners();
  }

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
  
  void addProposal(Proposal proposal) {
    proposals.add(proposal);
    notifyListeners();
  }

  List<Proposal> getProposals() {
    return proposals;
  }

  void updateProposalStatus(int index, String newStatus) {
    proposals[index].status = newStatus;
    notifyListeners();
  }

  void deleteProposal(int index) {
    proposals.removeAt(index);
    notifyListeners();
  }
}
