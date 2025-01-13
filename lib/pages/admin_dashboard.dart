import 'package:flutter/material.dart';
import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
              'Welcome, Admin!',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.orange,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              // Show confirmation dialog
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("Alert!"),
                    content: Text("are you sure you want to log out?"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                        },
                        child: Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: () async {
                          await FirebaseAuth.instance.signOut();
                          Navigator.pushReplacementNamed(context, 'login');
                        },
                        child: Text("Yes, log out"),
                      ),
                    ],
                  );
                },
              );
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
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final FirebaseAuth _auth = FirebaseAuth.instance;

    String? _selectedDepartment = 'Students Association';
    String? _selectedFaculty = 'FTI';

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Create user account',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: 'Name',
              prefixIcon: Icon(FontAwesomeIcons.user),
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 16),
          DropdownButtonFormField(
            decoration: InputDecoration(
              labelText: 'Department',
              prefixIcon: Icon(FontAwesomeIcons.building),
              border: OutlineInputBorder(),
            ),
            items: [
              DropdownMenuItem(
                child: Text('Students Association'),
                value: 'Students Association',
              ),
              DropdownMenuItem(
                child: Text('Head of Study Program'),
                value: 'Head of Study Program',
              ),
              DropdownMenuItem(
                child: Text('Faculty'),
                value: 'Faculty',
              ),
            ],
            onChanged: (value) {
              setState(() {
                _selectedDepartment = value as String?;
              });
            },
          ),
          SizedBox(height: 16),
          DropdownButtonFormField(
            decoration: InputDecoration(
              labelText: 'Faculty',
              prefixIcon: Icon(FontAwesomeIcons.university),
              border: OutlineInputBorder(),
            ),
            items: [
              DropdownMenuItem(
                child: Text('FTI'),
                value: 'FTI',
              ),
              DropdownMenuItem(
                child: Text('FAD'),
                value: 'FAD',
              ),
              DropdownMenuItem(
                child: Text('FTSP'),
                value: 'FTSP',
              ),
            ],
            onChanged: (value) {
              setState(() {
                _selectedFaculty = value as String?;
              });
            },
          ),
          SizedBox(height: 16),
          TextField(
            controller: _programStudyController,
            decoration: InputDecoration(
              labelText: 'Study Program',
              prefixIcon: Icon(FontAwesomeIcons.book),
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 16),
          TextField(
            controller: _emailController,
            decoration: InputDecoration(
              labelText: 'Email',
              prefixIcon: Icon(FontAwesomeIcons.envelope),
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 16),
          TextField(
            controller: _passwordController,
            decoration: InputDecoration(
              labelText: 'Password',
              prefixIcon: Icon(FontAwesomeIcons.lock),
              border: OutlineInputBorder(),
            ),
            obscureText: true,
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () async {
              try {
                UserCredential userCredential =
                    await _auth.createUserWithEmailAndPassword(
                  email: _emailController.text,
                  password: _passwordController.text,
                );

                final userData = {
                  'uid': userCredential.user?.uid,
                  'name': _nameController.text,
                  'department': _selectedDepartment,
                  'faculty': _selectedFaculty,
                  'prodi': _programStudyController.text,
                  'email': _emailController.text,
                };

                // Simpan ke Firestore
                await _firestore.collection('users').add(userData);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Account Created Successfully!')),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Failed to Create Account: $e')),
                );
              }
            },
            style: ElevatedButton.styleFrom(iconColor: Colors.orange),
            child: Text('SAVE', style: GoogleFonts.poppins(fontSize: 16)),
          ),
        ],
      ),
    );
  }

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
                'List of mail categories',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  _showAddCategoryDialog();
                },
                child: Text('ADD'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
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
                      _deleteCategory(index);
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
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'List of Users',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('users').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Error: ${snapshot.error}',
                      style: GoogleFonts.poppins(),
                    ),
                  );
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Text(
                      'No users found',
                      style: GoogleFonts.poppins(),
                    ),
                  );
                }

                final users = snapshot.data!.docs;

                return ListView(
                  children: [
                    DataTable(
                      columns: [
                        DataColumn(
                          label: Text(
                            'Name',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Department',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                      rows: users.map((userDoc) {
                        final userData = userDoc.data() as Map<String, dynamic>;
                        return DataRow(
                          cells: [
                            DataCell(Text(
                              userData['name'] ?? 'N/A',
                              style: GoogleFonts.poppins(),
                            )),
                            DataCell(Text(
                              userData['department'] ?? 'N/A',
                              style: GoogleFonts.poppins(),
                            )),
                          ],
                        );
                      }).toList(),
                    ),
                  ],
                );
              },
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
          title: Text('Add mail category'),
          content: TextField(
            controller: _newCategoryController,
            decoration: InputDecoration(hintText: 'Enter a category name'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
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
                      content: Text('Category added successfully!'),
                    ),
                  );
                }
              },
              child: Text('Save'),
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
        content: Text('Category successfully deleted!'),
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
