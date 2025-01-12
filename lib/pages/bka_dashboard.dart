import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'detail_mail.dart';
import 'profile_page.dart'; // Import your ProfilePage

class BkaDashboard extends StatefulWidget {
  @override
  _BkaDashboardState createState() => _BkaDashboardState();
}

class _BkaDashboardState extends State<BkaDashboard> {
  int _selectedIndex = 0;
  String _searchQuery = '';
  String _selectedCategory = 'All';

  final List<Map<String, String>> _cards = [
    {
      'title': 'Peminjaman Ruangan Rapat',
      'category': 'Peminjaman',
      'proposer': 'Himpunana Sistem Informasi'
    },
    {
      'title': 'Peminjaman Sound System (DJ)',
      'category': 'Himpunana Geodesi',
      'proposer': 'KONTOL'
    },
    {
      'title': 'Peminjaman Proyektor',
      'category': 'Peminjaman',
      'proposer': 'Himpunana Informatika'
    },
    {
      'title': 'Peminjaman Uang',
      'category': 'Peminjaman',
      'proposer': 'Himpunana Sistem Informasi'
    },
    {
      'title': 'Permohonan Sidang KP',
      'category': 'Permohonan',
      'proposer': 'Himpunana Sistem Informasi'
    },
    {
      'title': 'Permohonan Beasiswa',
      'category': 'Permohonan',
      'proposer': 'Himpunana Sistem Informasi'
    },
    {
      'title': 'Permohonan Dosa',
      'category': 'Permohonan',
      'proposer': 'Himpunana Sistem Informasi'
    },
    // Add more data as needed
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Navigate to ProfilePage when the second item is tapped
    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                ProfilePage(isStudent: true)), // Pass any required parameters
      );
    }
  }

  void _navigateToDetailMail(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailMail(),
      ),
    );
  }

  List<Map<String, String>> _getFilteredCards() {
    return _cards.where((card) {
      final matchesSearch =
          card['title']!.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesCategory =
          _selectedCategory == 'All' || card['category'] == _selectedCategory;
      return matchesSearch && matchesCategory;
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
            backgroundColor: Colors.orange,
            title: Text(
              'BKA Dashboard',
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
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('assets/fti_profile.jpg'),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Badan Kegiatan Akademik (BKA)',
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
                  child: ListView.builder(
                    padding: EdgeInsets.all(0),
                    itemCount: _getFilteredCards().length,
                    itemBuilder: (context, index) {
                      final card = _getFilteredCards()[index];
                      return GestureDetector(
                        onTap: () => _navigateToDetailMail(context),
                        child: Card(
                          elevation: 4,
                          margin:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  card['title']!,
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Proposer: ${card['proposer']}',
                                  style: GoogleFonts.poppins(
                                      color: Colors.grey[600], fontSize: 12),
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
              icon: Icon(Icons.home, color: Colors.orange),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person, color: Colors.orange),
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
