import 'package:flutter/material.dart';

class EmailTemplateForm extends StatefulWidget {
  final Function(String, String) onSubmit;

  EmailTemplateForm({required this.onSubmit});

  @override
  _EmailTemplateFormState createState() => _EmailTemplateFormState();
}

class _EmailTemplateFormState extends State<EmailTemplateForm> {
  final _formKey = GlobalKey<FormState>();
  String selectedTemplate = 'Room Rental';
  String customContent = '';

  final Map<String, String> templates = {
    'Room Rental': 'Subject: Room Rental Request\nBody: Dear [Recipient], I would like to request...',
    'Proposal Submission': 'Subject: Proposal Submission\nBody: Dear [Recipient], I am submitting...',
  };

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DropdownButtonFormField<String>(
            value: selectedTemplate,
            items: templates.keys.map((template) {
              return DropdownMenuItem(value: template, child: Text(template));
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedTemplate = value!;
              });
            },
          ),
          TextFormField(
            maxLines: 5,
            decoration: InputDecoration(labelText: 'Custom Content'),
            onChanged: (value) {
              customContent = value;
            },
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                widget.onSubmit(
                  templates[selectedTemplate]!,
                  customContent,
                );
              }
            },
            child: Text('Send Email'),
          ),
        ],
      ),
    );
  }
}
