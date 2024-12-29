import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/app_state.dart';
import 'package:flutter_application_1/models/user.dart';

class AdminPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    final codeController = TextEditingController();  
    String? selectedRole;  

    void _addUser() {
      final code = codeController.text;
      if (code.isEmpty || selectedRole == null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Isi ulang'),
        ));
        return;
      }
      final user = User(name: code, role: selectedRole!);  
      appState.addUser(user);
      codeController.clear();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('User Berhasil Ditambahkan'),
      ));
    }

    return Scaffold(
      appBar: AppBar(title: Text('Admin Dashboard')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: codeController,
              decoration: InputDecoration(labelText: 'NIM / NIP (contoh, 162022035)'),
              keyboardType: TextInputType.number,
              maxLength: 9,  
            ),
            SizedBox(height: 20),
            DropdownButton<String>(
              hint: Text('Pilih Peran'),
              value: selectedRole,
              onChanged: (newRole) {
                selectedRole = newRole;
              },
              items: ['Mahasiswa', 'Kaprodi', 'Fakultas']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addUser,
              child: Text('Tambahkan User'),
            ),
            SizedBox(height: 20),
            Text('Manage Users:'),
            Expanded(
              child: ListView.builder(
                itemCount: appState.getUsers().length,
                itemBuilder: (context, index) {
                  final user = appState.getUsers()[index];
                  return Card(
                    child: ListTile(
                      title: Text('${user.name} - ${user.role}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              // Update user logic here
                            },
                            icon: Icon(Icons.edit, color: Colors.blue),
                          ),
                          IconButton(
                            onPressed: () {
                              appState.deleteUser(index);
                            },
                            icon: Icon(Icons.delete, color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
