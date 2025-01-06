import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:art_sweetalert/art_sweetalert.dart';

class NewRequest extends StatefulWidget {
  const NewRequest({Key? key}) : super(key: key);

  @override
  _NewRequestState createState() => _NewRequestState();
}

class _NewRequestState extends State<NewRequest> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _requestDateController = TextEditingController();
  String? _selectedCategory;
  String? _selectedPenerima;

  final List<String> _categories = ['Teknologi', 'Sosial', 'Budaya'];
  final List<String> _penerima = ['Kaprodi', 'Fakultas'];

  late String dateCreate;

  @override
  void initState() {
    super.initState();
    dateCreate = DateFormat('dd/MM/yyyy').format(DateTime.now());
    _requestDateController.text = dateCreate; // Set the current date
  }

  // Function to show alert dialog using ArtSweetAlert
  void _showAlertDialog(String message) {
    ArtSweetAlert.show(
      context: context,
      artDialogArgs: ArtDialogArgs(
        type: ArtSweetAlertType.danger,
        title: "Peringatan",
        text: message,
        confirmButtonText: "OK",
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'New Request',
          style: GoogleFonts.poppins(),
        ),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Masukan penerima',
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
                DropdownButtonFormField<String>(
                  value: _selectedPenerima,
                  hint: const Text('Pilih jenis penerima'),
                  items: _penerima.map((String type) {
                    return DropdownMenuItem<String>(
                      value: type,
                      child: Text(type, style: GoogleFonts.poppins()),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedPenerima = value;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Silakan pilih Penerima';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                Text(
                  'Judul Proposal',
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    hintText: 'Masukkan judul proposal',
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Silakan masukkan judul proposal';
                    }
                    return null;
                  },
                  style: GoogleFonts.poppins(),
                ),
                const SizedBox(height: 16),
                Text(
                  'Kategori Proposal',
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
                DropdownButtonFormField<String>(
                  value: _selectedCategory,
                  hint: const Text('Pilih kategori proposal'),
                  items: _categories.map((String category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child: Text(category, style: GoogleFonts.poppins()),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCategory = value;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Silakan pilih kategori proposal';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                Text(
                  'Deskripsi Proposal',
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
                TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    hintText: 'Masukkan deskripsi proposal',
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                  ),
                  maxLines: 4,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Silakan masukkan deskripsi proposal';
                    }
                    return null;
                  },
                  style: GoogleFonts.poppins(),
                ),
                const SizedBox(height: 24),
                Text(
                  'Tanggal Pengajuan',
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
                TextFormField(
                  controller: _requestDateController,
                  readOnly: true,
                  enabled: false,
                  decoration: InputDecoration(
                    hintText: 'Tanggal pengajuan',
                    suffixIcon: const Icon(FontAwesomeIcons.calendarAlt),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Silakan pilih tanggal pengajuan';
                    }
                    return null;
                  },
                  style: GoogleFonts.poppins(),
                ),
                const SizedBox(height: 24),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Handle form submission
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Proposal berhasil diajukan!')),
                        );
                      } else {
                        // Show alert dialog using ArtSweetAlert if validation fails
                        _showAlertDialog(
                            'Silakan isi semua field yang diperlukan.');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 5, // Efek bayangan
                      shadowColor: Colors.black.withOpacity(0.2),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(width: 8),
                        Text(
                          'Ajukan Proposal',
                          style: GoogleFonts.poppins(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
