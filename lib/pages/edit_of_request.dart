import 'package:flutter/material.dart';

class EditOfList extends StatefulWidget {
  final String title;
  final String description;
  final String requestDate;
  final String deadline;

  const EditOfList({
    Key? key,
    required this.title,
    required this.description,
    required this.requestDate,
    required this.deadline,
  }) : super(key: key);

  @override
  _EditOfListState createState() => _EditOfListState();
}

class _EditOfListState extends State<EditOfList> {
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _descriptionController = TextEditingController(text: widget.description);
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Konfirmasi'),
          content: const Text('Apakah proposal sudah benar?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
              },
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                // TODO: Implement logic to save changes to the proposal
                String updatedDescription = _descriptionController.text;
                // Simpan perubahan ke database atau state management
                Navigator.pop(context,
                    updatedDescription); // Kembali ke halaman sebelumnya
              },
              child: const Text('Kirim'),
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
        title: const Text('Edit Proposal'),
        backgroundColor: Colors.orange,
        automaticallyImplyLeading: true, // Tombol kembali akan muncul
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _showConfirmationDialog, // Panggil dialog konfirmasi
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Title',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            Text(
              widget.title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'Request Date',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            Text(
              widget.requestDate,
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            const Text(
              'Deadline',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            Text(
              widget.deadline,
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            const Text(
              'Description',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            TextField(
              controller: _descriptionController,
              maxLines: 5,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Edit your description here...',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
