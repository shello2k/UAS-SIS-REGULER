import 'package:flutter/material.dart';

class NewRequest extends StatefulWidget {
  const NewRequest({Key? key}) : super(key: key);

  @override
  _NewRequestState createState() => _NewRequestState();
}

class _NewRequestState extends State<NewRequest> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _recipientController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _requestDateController = TextEditingController();
  String? _selectedProposalType;
  String? _selectedCategory;
  String? _selectedPerenima;

//contoh nya
  final List<String> _proposalTypes = [
    'Kegiatan',
    'Penelitian',
    'Pengabdian Masyarakat'
  ];
  final List<String> _categories = ['Teknologi', 'Sosial', 'Budaya'];
  final List<String> _penerima = ['Kaprodi', 'Fakultas'];
  // Date Picker
  Future<void> _pickDate(
      BuildContext context, TextEditingController controller) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        controller.text =
            "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Request'),
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
                const Text(
                  'Masukan penerima',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                DropdownButtonFormField<String>(
                  value: _selectedPerenima,
                  hint: const Text('Pilih jenis penerima'),
                  items: _penerima.map((String type) {
                    return DropdownMenuItem<String>(
                      value: type,
                      child: Text(type),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedPerenima = value;
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
                const Text(
                  'Judul Proposal',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    hintText: 'Masukkan judul proposal',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Silakan masukkan judul proposal';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                const Text(
                  'Jenis Proposal',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                DropdownButtonFormField<String>(
                  value: _selectedProposalType,
                  hint: const Text('Pilih jenis proposal'),
                  items: _proposalTypes.map((String type) {
                    return DropdownMenuItem<String>(
                      value: type,
                      child: Text(type),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedProposalType = value;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Silakan pilih jenis proposal';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                const Text(
                  'Deskripsi Proposal',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    hintText: 'Masukkan deskripsi proposal',
                  ),
                  maxLines: 4,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Silakan masukkan deskripsi proposal';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                const Text(
                  'Tanggal Pengajuan',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  controller: _requestDateController,
                  readOnly: true,
                  decoration: const InputDecoration(
                    hintText: 'Pilih tanggal pengajuan',
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  onTap: () => _pickDate(context, _requestDateController),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Silakan pilih tanggal pengajuan';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                const Text(
                  'Kategori Proposal',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                DropdownButtonFormField<String>(
                  value: _selectedCategory,
                  hint: const Text('Pilih kategori proposal'),
                  items: _categories.map((String category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child: Text(category),
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
                      }
                    },
                    child: const Text('Ajukan Proposal'),
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
