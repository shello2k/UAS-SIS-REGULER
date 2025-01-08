import 'package:flutter/material.dart';
import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AdminDashboard extends StatefulWidget {
  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  int _currentIndex = 0;

  List<String> _categories = ['Kategori 1', 'Kategori 2'];

  // Controllers for text fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _nimController = TextEditingController();
  final TextEditingController _programStudyController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _proposalTypeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Selamat Datang, Admin!',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            IconButton(
              icon: Icon(FontAwesomeIcons.signOutAlt, color: Colors.white),
              onPressed: () {
                // Logout action logic here
              },
            )
          ],
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
      body: _buildPage(),
      bottomNavigationBar: CrystalNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          /// User
          CrystalNavigationBarItem(
            icon: FontAwesomeIcons.users,
            unselectedIcon: FontAwesomeIcons.users,
            selectedColor: Colors.orange,
          ),

          /// Category
          CrystalNavigationBarItem(
            icon: FontAwesomeIcons.layerGroup,
            unselectedIcon: FontAwesomeIcons.layerGroup,
            selectedColor: Colors.orange,
          ),

          /// Document
          CrystalNavigationBarItem(
            icon: FontAwesomeIcons.list,
            unselectedIcon: FontAwesomeIcons.list,
            selectedColor: Colors.orange,
          ),
        ],
        backgroundColor: Colors.orange.shade100,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.white,
      ),
    );
  }

  Widget _buildPage() {
    switch (_currentIndex) {
      case 0:
        return _buildUserForm();
      case 1:
        return _buildCategoryForm();
      case 2:
        return _buildUserList();
      default:
        return Container();
    }
  }

  Widget _buildUserForm() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Buat Akun Pengguna',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          TextField(
            controller: _nameController, // Use the controller here
            decoration: InputDecoration(
              labelText: 'Nama',
              prefixIcon:
                  Icon(FontAwesomeIcons.user), // Font Awesome icon for name
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 16),
          TextField(
            controller: _nimController, // NIM field
            decoration: InputDecoration(
              labelText: 'NIM',
              prefixIcon: Icon(FontAwesomeIcons.idCard),
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 16),
          DropdownButtonFormField(
            decoration: InputDecoration(
              labelText: 'Departemen',
              prefixIcon: Icon(FontAwesomeIcons
                  .building), // Font Awesome icon for department
              border: OutlineInputBorder(),
            ),
            items: [
              DropdownMenuItem(
                child: Text('Himpunan'),
                value: 'Himpunan',
              ),
              DropdownMenuItem(
                child: Text('Kepala Program Studi'),
                value: 'Kepala Program Studi',
              ),
              DropdownMenuItem(
                child: Text('Fakultas'),
                value: 'Fakultas',
              ),
            ],
            onChanged: (value) {},
          ),
          SizedBox(height: 16),
          DropdownButtonFormField(
            decoration: InputDecoration(
              labelText: 'Fakultas',
              prefixIcon: Icon(FontAwesomeIcons.university),
              border: OutlineInputBorder(),
            ),
            items: [
              DropdownMenuItem(
                child: Text('Fakultas A'),
                value: 'Fakultas A',
              ),
              DropdownMenuItem(
                child: Text('Fakultas B'),
                value: 'Fakultas B',
              ),
            ],
            onChanged: (value) {},
          ),
          SizedBox(height: 16),
          TextField(
            controller: _programStudyController, // Use the controller here
            decoration: InputDecoration(
              labelText: 'Program Studi',
              prefixIcon: Icon(FontAwesomeIcons.book),
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 16),
          TextField(
            controller: _emailController, // Use the controller here
            decoration: InputDecoration(
              labelText: 'Email',
              prefixIcon: Icon(FontAwesomeIcons.envelope),
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 16),
          TextField(
            controller: _passwordController, // Use the controller here
            decoration: InputDecoration(
              labelText: 'Password',
              prefixIcon:
                  Icon(FontAwesomeIcons.lock), // Font Awesome icon for password
              border: OutlineInputBorder(),
            ),
            obscureText: true,
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              // Submit logic
              // You can access the values using the controllers
              String name = _nameController.text;
              String nim = _nimController.text;
              String programStudy = _programStudyController.text;
              String email = _emailController.text;
              String password = _passwordController.text;

              // Implement your submission logic here
            },
            style: ElevatedButton.styleFrom(iconColor: Colors.orange),
            child: Text('Simpan', style: GoogleFonts.poppins(fontSize: 16)),
          )
        ],
      ),
    );
  }

//ini page kedua yang bagian kategori itu lhoooo
  Widget _buildCategoryForm() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Daftar Kategori Surat',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  _showAddCategoryDialog(); // Show dialog to add category
                },
                child: Text('Tambah'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange, // Button color
                  foregroundColor: Colors.white, // Text color
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    _categories[index],
                    style: GoogleFonts.poppins(),
                  ),
                  trailing: IconButton(
                    icon: Icon(FontAwesomeIcons.trash),
                    onPressed: () {
                      _deleteCategory(index); // Call delete function
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserList() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Daftar Pengguna',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          Expanded(
            child: ListView(
              children: [
                DataTable(
                  columns: [
                    DataColumn(
                      label: Text(
                        'Nama',
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Departemen',
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                  rows: [
                    DataRow(cells: [
                      DataCell(Text('John Doe', style: GoogleFonts.poppins())),
                      DataCell(Text('Teknik', style: GoogleFonts.poppins())),
                    ]),
                    DataRow(cells: [
                      DataCell(
                          Text('Jane Smith', style: GoogleFonts.poppins())),
                      DataCell(Text('Manajemen', style: GoogleFonts.poppins())),
                    ]),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showAddCategoryDialog() {
    final TextEditingController _newCategoryController =
        TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Tambah Kategori Surat'),
          content: TextField(
            controller: _newCategoryController,
            decoration: InputDecoration(hintText: 'Masukkan nama kategori'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                String newCategory = _newCategoryController.text.trim();
                if (newCategory.isNotEmpty) {
                  setState(() {
                    _categories
                        .add(newCategory); // Add new category to the list
                  });
                  Navigator.of(context).pop(); // Close the dialog
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Kategori berhasil ditambahkan!'),
                    ),
                  );
                }
              },
              child: Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  void _deleteCategory(int index) {
    setState(() {
      _categories.removeAt(index); // Remove the category from the list
    });
    // Optionally, show a snackbar or dialog to confirm deletion
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Kategori berhasil dihapus!'),
      ),
    );
  }

  @override
  void dispose() {
    // Dispose the controllers when the widget is removed from the widget tree
    _nameController.dispose();
    _nimController.dispose();
    _programStudyController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _proposalTypeController.dispose();
    super.dispose();
  }
}
