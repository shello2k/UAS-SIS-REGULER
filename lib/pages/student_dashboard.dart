import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/pages/edit_of_request.dart';
import 'package:flutter_application_1/pages/new_request.dart';
import 'package:flutter_application_1/models/restapi.dart';
import 'package:flutter_application_1/models/model_surat.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class StudentDashboard extends StatefulWidget {
  @override
  _StudentDashboardState createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {
  int _selectedIndex = 0;
  List<SuratModel> proposals = [];
  final String token = '6717db9aec5074ec8261d698';
  final String project = 'uas-sis';
  final String collection = 'surat';
  final String appid = '677eb6dae9cc622b8bd171ea';

  @override
  void initState() {
    super.initState();
    _fetchProposals(); // Fetch proposals on initialization
  }

  // Sort proposals by date
  void _sortProposalsByDate() {
    setState(() {
      proposals.sort((a, b) {
        DateTime dateA = DateFormat('dd/MM/yyyy').parse(a.tanggal_pengajuan);
        DateTime dateB = DateFormat('dd/MM/yyyy').parse(b.tanggal_pengajuan);
        return dateA.compareTo(dateB);
      });
    });
  }

  // Fetch proposals
  Future<void> _fetchProposals() async {
    try {
      final response =
          await DataService().selectAll(token, project, collection, appid);
      final List<dynamic> data = json.decode(response);
      setState(() {
        proposals = data.map((item) => SuratModel.fromJson(item)).toList();
      });
    } catch (e) {
      print('Error fetching proposals: $e');
    }
  }

  Future<void> _createProposal(SuratModel proposal) async {
    try {
      await DataService().insertSurat(
        appid,
        proposal.penerima,
        proposal.judul_proposal,
        proposal.kategory_proposal,
        proposal.deskripsi_proposal,
        proposal.tanggal_pengajuan,
        proposal.status_surat,
        proposal.kode_proposal,
        proposal.feedback_proposal ?? '',
      );

      // Refresh list of proposals
      await _fetchProposals();
    } catch (e) {
      print('Error creating proposal: $e');
    }
  }

  Future<void> _updateProposal(String id, SuratModel proposal) async {
    try {
      await DataService().updateId('judul_proposal', proposal.judul_proposal,
          token, project, collection, appid, id);
      await DataService().updateId('deskripsi_proposal',
          proposal.deskripsi_proposal, token, project, collection, appid, id);
      await _fetchProposals();
      Navigator.pop(context); // Refresh list after editing proposal
    } catch (e) {
      print('Error updating proposal: $e');
    }
  }

  Future<void> _deleteProposal(String id) async {
    try {
      await DataService().removeId(token, project, collection, appid, id);
      _fetchProposals(); // Refresh list after deletion
    } catch (e) {
      print('Error deleting proposal: $e');
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 1) {
      Navigator.pushNamed(context, 'profile_page');
    }
  }

  void _showDeleteConfirmationDialog(BuildContext context, String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Konfirmasi Hapus'),
          content:
              const Text('Apakah Anda yakin ingin menghapus proposal ini?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                _deleteProposal(id);
                Navigator.of(context).pop();
              },
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Dashboard Mahasiswa',
          style: TextStyle(fontWeight: FontWeight.bold),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Daftar Proposal Anda',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        // Search functionality can be implemented here
                      },
                      icon: const Icon(Icons.search),
                    ),
                    IconButton(
                      onPressed: () {
                        _sortProposalsByDate(); // Sort proposals by date
                      },
                      icon: const Icon(Icons.sort),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: proposals.length,
                itemBuilder: (context, index) {
                  return _buildProposalCard(context, proposals[index]);
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.orange,
        onTap: _onItemTapped,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NewRequest()),
          ).then((newProposal) {
            if (newProposal != null) {
              setState(() {
                proposals.add(newProposal);
              });
            }
          });
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.orange,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildProposalCard(BuildContext context, SuratModel proposal) {
    Color statusColor;
    switch (proposal.status_surat) {
      case 'Submitted':
        statusColor = Colors.blue;
        break;
      case 'On Progress - Faculty':
        statusColor = Colors.orange;
        break;
      case 'On Progress - BKU':
        statusColor = Colors.yellow;
        break;
      case 'On Progress - BKA':
        statusColor = Colors.purple;
        break;
      case 'Rejected':
        statusColor = Colors.red;
        break;
      case 'Rejected - Faculty':
        statusColor = Colors.red;
        break;
      case 'Rejected - bku':
        statusColor = Colors.red;
        break;
      case 'Rejected - bka':
        statusColor = Colors.red;
        break;
      case 'Approved':
        statusColor = Colors.green;
        break;
      default:
        statusColor = Colors.grey;
    }

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  proposal.kode_proposal,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    proposal.status_surat,
                    style: TextStyle(
                      color: statusColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              'Judul Proposal',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            Text(
              proposal.judul_proposal,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Tanggal Pengajuan',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                Text(
                  'Proggress',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  proposal.tanggal_pengajuan,
                  style: const TextStyle(fontSize: 14),
                ),
                // Assuming you have a deadline property in your model
                Text(
                  '15/01/24 07:09 rejected', // Replace with actual deadline if available
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
            if (proposal.status_surat == 'Rejected') ...[
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditOfList(surat: proposal),
                        ),
                      ).then((isUpdated) {
                        if (isUpdated == true) {
                          _fetchProposals(); // Refresh list of proposals after successful edit
                        }
                      });
                    },
                    child: const Text(
                      'Edit and Resend',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      _showDeleteConfirmationDialog(
                          context, proposal.id); // Show confirmation dialog
                    },
                    child: const Text(
                      'Delete',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
