import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/detail_mail_faculty.dart';
import 'package:flutter_application_1/pages/profile_page_staff.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'detail_mail.dart';
import 'profile_page.dart';
import 'package:flutter_application_1/models/restapi.dart';
import 'package:flutter_application_1/models/model_surat.dart';
import 'dart:convert';

class FacultyDashboard extends StatefulWidget {
  @override
  _FacultyDashboardState createState() => _FacultyDashboardState();
}

class _FacultyDashboardState extends State<FacultyDashboard> {
  int _selectedIndex = 0;
  String _searchQuery = '';
  String _selectedCategory = 'All';
  List<SuratModel> _suratList = []; // List to hold surat data
  bool _isLoading = true; // Loading state

  final String token = '6717db9aec5074ec8261d698';
  final String project = 'uas-sis';
  final String collection = 'surat';
  final String appid = '677eb6dae9cc622b8bd171ea';

  @override
  void initState() {
    super.initState();
    _fetchSuratList();
  }

  Future<void> _fetchSuratList() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response =
          await DataService().selectAll(token, project, collection, appid);
      final List<dynamic> data = json.decode(response);
      setState(() {
        _suratList = data
            .map((item) => SuratModel.fromJson(item))
            .toList(); // Map the response to SuratModel
        _isLoading = false;
      });
    } catch (e) {
      print('Error fetching surat list: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Navigate to ProfilePage when the second item is tapped
    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProfilePageStaff(role: 'Faculty'),
        ),
      );
    }
  }

  void _navigateToDetailMail(BuildContext context, String kode_proposal) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailMailFaculty(
            kode_proposal: kode_proposal), // Pass suratId to DetailMail
      ),
    ).then((isUpdated) {
      if (isUpdated == true) {
        _fetchSuratList(); // Refresh list of proposals after successful edit
      }
    });
  }

  List<SuratModel> _getFilteredSurat() {
    return _suratList.where((surat) {
      final matchesSearch = surat.judul_proposal
          .toLowerCase()
          .contains(_searchQuery.toLowerCase());
      final matchesCategory = _selectedCategory == 'All' ||
          surat.kategory_proposal == _selectedCategory;
      final isNotRejectedOrApproved = surat.status_surat != 'Rejected' &&
          surat.status_surat != 'On Progress - BKU';
      final isProggres = surat.status_surat == 'On Progress - Fakultas';
      return matchesSearch &&
          matchesCategory &&
          isNotRejectedOrApproved &&
          isProggres; // Add the new condition
    }).toList();
  }

  void _selectCategory(String category) {
    setState(() {
      _selectedCategory = category;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: ClipRRect(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.orange,
            title: Text(
              'Faculty Dashboard',
              style: GoogleFonts.poppins(color: Colors.white),
            ),
            centerTitle: true,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(width: 10),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Fakultas Teknologi Industri (FTI)',
                        style: GoogleFonts.poppins(
                            fontSize: 16, color: Colors.black),
                      ),
                      IconButton(
                        icon:
                            FaIcon(FontAwesomeIcons.bell, color: Colors.orange),
                        onPressed: () {
                          // Action for notification
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[200],
                    ),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          _searchQuery = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Search by title',
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.search, color: Colors.orange),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                PopupMenuButton<String>(
                  icon: Icon(Icons.sort, color: Colors.orange),
                  onSelected: _selectCategory,
                  itemBuilder: (BuildContext context) {
                    return <String>['All', 'Peminjaman', 'Permohonan']
                        .map<PopupMenuItem<String>>((String value) {
                      return PopupMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList();
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'List of Proposal',
              style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            SizedBox(height: 10),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                  child: _isLoading
                      ? Center(
                          child:
                              CircularProgressIndicator()) // Show loading indicator
                      : _getFilteredSurat().isEmpty
                          ? Center(
                              child: Text(
                                'No proposals available.',
                                style: GoogleFonts.poppins(
                                    fontSize: 16, color: Colors.white),
                              ),
                            )
                          : ListView.builder(
                              padding: EdgeInsets.all(0),
                              itemCount: _getFilteredSurat().length,
                              itemBuilder: (context, index) {
                                final surat = _getFilteredSurat()[index];
                                return GestureDetector(
                                  onTap: () =>
                                      _navigateToDetailMail(context, surat.id),
                                  child: Card(
                                    elevation: 4,
                                    margin: EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 16),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    color: Colors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            surat.judul_proposal,
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            'Proposer: ${surat.penerima}', // Assuming 'penerima' holds the user ID
                                            style: GoogleFonts.poppins(
                                                color: Colors.grey[600],
                                                fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: FaIcon(Icons.home, color: Colors.orange),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: FaIcon(Icons.person, color: Colors.grey),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.orange,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
