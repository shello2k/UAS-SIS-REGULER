import 'package:flutter/material.dart';  
import 'package:firebase_auth/firebase_auth.dart';  
import 'package:flutter_application_1/pages/edit_of_request.dart';  
import 'package:flutter_application_1/pages/new_request.dart';  
import 'package:flutter_application_1/models/restapi.dart'; // Import your DataService  
import 'package:flutter_application_1/models/model_surat.dart'; // Import your DataService  
import 'dart:convert'; // For JSON encoding/decoding  
import 'package:intl/intl.dart';
  
class StudentDashboard extends StatefulWidget {  
  @override  
  _StudentDashboardState createState() => _StudentDashboardState();  
}  
  
class _StudentDashboardState extends State<StudentDashboard> {  
  int _selectedIndex = 0;  
  List<SuratModel> proposals = [];  
  final String token = '6717db9aec5074ec8261d698'; // Your API token  
  final String project = 'uas-sis'; // Your project name  
  final String collection = 'surat'; // Your collection name  
  final String appid = '677eb6dae9cc622b8bd171ea'; // Your app ID  
  
  @override  
  void initState() {  
    super.initState();  
    _fetchProposals(); // Fetch proposals when the dashboard is initialized  
  }  

  // Function to sort proposals by date  
void _sortProposalsByDate() {  
  setState(() {  
    proposals.sort((a, b) {  
      // Convert the date strings to DateTime objects for comparison  
      DateTime dateA = DateFormat('dd/MM/yyyy').parse(a.tanggal_pengajuan);  
      DateTime dateB = DateFormat('dd/MM/yyyy').parse(b.tanggal_pengajuan);  
      return dateA.compareTo(dateB); // Ascending order  
    });  
  });  
}  

  
  // Fetch proposals from the API  
  Future<void> _fetchProposals() async {  
    try {  
      final response = await DataService().selectAll(token, project, collection, appid);  
      final List<dynamic> data = json.decode(response); // Decode the JSON response  
      setState(() {  
        proposals = data.map((item) => SuratModel.fromJson(item)).toList(); // Convert to SuratModel list  
      });  
    } catch (e) {  
      print('Error fetching proposals: $e');  
    }  
  }  
  
  // Create a new proposal  
  // Create a new proposal    
  // Create a new proposal    
  Future<void> _createProposal(SuratModel proposal) async {    
    try {    
      await DataService().insertSurat(    
        appid, // Pass the app ID    
        proposal.penerima,    
        proposal.judul_proposal,    
        proposal.kategory_proposal,    
        proposal.deskripsi_proposal,    
        proposal.tanggal_pengajuan,    
        proposal.status_surat,    
        proposal.kode_proposal, // Pass the kode_proposal    
        proposal.feedback_proposal ?? '', // Pass feedback_proposal, default to empty string if null    
      );      
    
      // Refresh the list after creating    
      await _fetchProposals(); // Fetch proposals again to refresh the list    
    } catch (e) {    
      print('Error creating proposal: $e');    
    }    
  }  


  
  // Update an existing proposal  
  Future<void> _updateProposal(String id, SuratModel proposal) async {  
    try {  
      await DataService().updateId(  
        'judul_proposal', proposal.judul_proposal,  
        token, project, collection, appid, id  
      );  
      await DataService().updateId(  
        'desc_proposal', proposal.deskripsi_proposal,  
        token, project, collection, appid, id  
      );  
      // Add other fields as necessary  
      _fetchProposals(); // Refresh the list after updating  
    } catch (e) {  
      print('Error updating proposal: $e');  
    }  
  }  
  
  // Delete a proposal  
  Future<void> _deleteProposal(String id) async {  
    try {  
      await DataService().removeId(token, project, collection, appid, id);  
      _fetchProposals(); // Refresh the list after deletion  
    } catch (e) {  
      print('Error deleting proposal: $e');  
    }  
  }  
  
  void _onItemTapped(int index) {  
    setState(() {  
      _selectedIndex = index;  
    });  
  
    // Navigate to the profile page  
    if (index == 1) {  
      Navigator.pushNamed(context, '/profile');  
    }  
  }  
  
  void _showDeleteConfirmationDialog(BuildContext context, String id) {  
    showDialog(  
      context: context,  
      builder: (BuildContext context) {  
        return AlertDialog(  
          title: const Text('Konfirmasi Hapus'),  
          content: const Text('Apakah Anda yakin ingin menghapus proposal ini?'),  
          actions: [  
            TextButton(  
              onPressed: () {  
                Navigator.of(context).pop(); // Close dialog  
              },  
              child: const Text('Batal'),  
            ),  
            TextButton(  
              onPressed: () {  
                _deleteProposal(id); // Call delete function  
                Navigator.of(context).pop(); // Close dialog  
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
                        // Logic for search icon  
                      },  
                      icon: const Icon(Icons.search),  
                    ),  
                    IconButton(    
                      onPressed: () {    
                        _sortProposalsByDate(); // Call the sorting function    
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
                    proposals.add(newProposal); // Add the new proposal to the list    
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
      case 'Cancel':  
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
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),  
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
                  'Deadline',  
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
                  '05/01/2024 - 10:00 AM', // Replace with actual deadline if available  
                  style: const TextStyle(fontSize: 14),  
                ),  
              ],  
            ),  
            if (proposal.status_surat == 'Cancel') ...[  
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
                          builder: (context) => EditOfList(  
                            title: proposal.judul_proposal,  
                            description: proposal.deskripsi_proposal,  
                            requestDate: proposal.tanggal_pengajuan,  
                            deadline: '05/01/2024 - 10:00 AM', // Replace with actual deadline if available  
                          ),  
                        ),  
                      ).then((updatedProposal) {  
                        if (updatedProposal != null) {  
                          _updateProposal(proposal.id, updatedProposal); // Update proposal  
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
                      _showDeleteConfirmationDialog(context, proposal.id); // Show confirmation dialog  
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
