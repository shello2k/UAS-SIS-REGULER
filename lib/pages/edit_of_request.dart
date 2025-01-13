import 'package:flutter/material.dart';      
import 'package:google_fonts/google_fonts.dart';      
import 'package:art_sweetalert/art_sweetalert.dart';      
import 'package:flutter_application_1/models/restapi.dart'; // Import your DataService      
import 'student_dashboard.dart';      
import 'package:flutter_application_1/models/model_surat.dart'; // Import your SuratModel      
  
class EditOfList extends StatefulWidget {      
  final SuratModel surat; // Use SuratModel directly      
  
  const EditOfList({Key? key, required this.surat}) : super(key: key);      
  
  @override      
  _EditOfListState createState() => _EditOfListState();      
}      
  
class _EditOfListState extends State<EditOfList> {      
  final _formKey = GlobalKey<FormState>();      
  late TextEditingController _descriptionController;      
  
  @override      
  void initState() {      
    super.initState();      
    _descriptionController = TextEditingController(text: widget.surat.deskripsi_proposal);      
  }      
  
  @override      
  void dispose() {      
    _descriptionController.dispose();      
    super.dispose();      
  }      
  
  void _showSuccessAlert() {      
    ArtSweetAlert.show(      
      context: context,      
      artDialogArgs: ArtDialogArgs(      
        type: ArtSweetAlertType.success,      
        title: "Proposal Updated!",      
        text: "Your proposal has been successfully updated.",      
        onConfirm: () {        
          // Return the updated proposal and navigate back to StudentDashboard  
          Navigator.pop(context, widget.surat.copyWith(deskripsi_proposal: _descriptionController.text));   
        },      
      ),      
    );      
  }      
  
  Future<void> _submitProposal() async {      
    if (_formKey.currentState!.validate()) {      
      String updatedDescription = _descriptionController.text;      
  
      // Call the API to update the proposal description      
      bool descriptionUpdated = await DataService().updateId(      
        'deskripsi_proposal', // Field to update      
        updatedDescription, // New description      
        '6717db9aec5074ec8261d698', // Token      
        'uas-sis', // Project      
        'surat', // Collection      
        '677eb6dae9cc622b8bd171ea', // App ID      
        widget.surat.id, // Use the generated ID from the model      
      );      
  
      // Call the API to update the status to submitted      
      bool statusUpdated = await DataService().updateId(      
        'status_surat', // Field to update      
        'Submitted', // New status      
        '6717db9aec5074ec8261d698', // Token      
        'uas-sis', // Project      
        'surat', // Collection      
        '677eb6dae9cc622b8bd171ea', // App ID      
        widget.surat.id, // Use the generated ID from the model      
      );      
  
      if (descriptionUpdated && statusUpdated) {      
        _showSuccessAlert(); // Show success alert if both updates were successful      
      } else {      
        // Handle the error case      
        ArtSweetAlert.show(      
          context: context,      
          artDialogArgs: ArtDialogArgs(      
            type: ArtSweetAlertType.danger,      
            title: "Submission Failed!",      
            text: "There was an error submitting your proposal. Please try again.",      
          ),      
        );      
      }      
    } else {      
      // Show alert dialog using ArtSweetAlert if validation fails      
      ArtSweetAlert.show(      
        context: context,      
        artDialogArgs: ArtDialogArgs(      
          type: ArtSweetAlertType.danger,      
          title: "Validation Error",      
          text: "Please fill in all required fields.",      
        ),      
      );      
    }      
  }      
  
  @override      
  Widget build(BuildContext context) {      
    return Scaffold(      
      appBar: AppBar(      
        title: Text(        
          'Edit Proposal',        
          style: GoogleFonts.poppins(fontSize: 20, color: Colors.white),        
        ),      
        backgroundColor: Colors.orange,      
      ),      
      body: Padding(      
        padding: const EdgeInsets.all(16.0),      
        child: Form(      
          key: _formKey,        
          child: Column(        
            crossAxisAlignment: CrossAxisAlignment.start,        
            children: [        
              Text(        
                'Title',        
                style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey),        
              ),        
              Text(        
                widget.surat.judul_proposal,        
                style: GoogleFonts.poppins(        
                    fontSize: 16, fontWeight: FontWeight.bold),        
              ),        
              const SizedBox(height: 16),        
              Text(        
                'Description',        
                style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey),        
              ),        
              TextFormField(        
                controller: _descriptionController,        
                maxLines: 5,        
                decoration: InputDecoration(        
                  border: OutlineInputBorder(),        
                  hintText: 'Edit your description here...',        
                ),        
                validator: (value) {        
                  if (value == null || value.isEmpty) {        
                    return 'Please enter a description.';        
                  }        
                  return null;        
                },        
                style: GoogleFonts.poppins(),        
              ),        
              const SizedBox(height: 16),        
              Center(        
                child: ElevatedButton(        
                  onPressed: _submitProposal, // Call the submit function        
                  style: ElevatedButton.styleFrom(        
                    backgroundColor: Colors.green,        
                    foregroundColor: Colors.white,        
                    padding: const EdgeInsets.symmetric(        
                        horizontal: 32, vertical: 12),        
                  ),        
                  child: Text(        
                    'Submit',        
                    style: GoogleFonts.poppins(fontSize: 16),        
                  ),        
                ),        
              ),        
            ],        
          ),        
        ),        
      ),        
    );        
  }        
}    
