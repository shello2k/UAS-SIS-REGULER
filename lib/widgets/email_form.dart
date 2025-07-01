import 'package:flutter/material.dart';

class EmailForm extends StatefulWidget {
  final Function(String, String) onSubmit;

  EmailForm({required this.onSubmit});

  @override
  _EmailFormState createState() => _EmailFormState();
}

class _EmailFormState extends State<EmailForm> {
  final _formKey = GlobalKey<FormState>();
  String subject = '';
  String body = '';

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      widget.onSubmit(subject, body);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Subject'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a subject';
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  subject = value;
                });
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Body'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the body';
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  body = value;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitForm,
              child: Text('Submit Proposal'),
            ),
          ],
        ),
      ),
    );
  }
}
