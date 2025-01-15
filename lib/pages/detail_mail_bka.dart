import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter_application_1/models/restapi.dart'; 
import 'package:flutter_application_1/models/model_surat.dart'; 
import 'dart:convert'; 

class DetailMailBka extends StatefulWidget {
  final String kode_proposal; // Surat ID passed from the previous screen

  DetailMailBka({required this.kode_proposal}); // Constructor to accept suratId

  @override
  _DetailMailState createState() => _DetailMailState();
}

class _DetailMailState extends State<DetailMailBka> {
  late SuratModel surat; // To hold the surat details
  bool _isLoading = true; // Loading state

  @override
  void initState() {
    super.initState();
    _fetchSuratDetails(); // Fetch surat details when the widget is initialized
  }

  Future<void> _fetchSuratDetails() async {
    setState(() {
      _isLoading = true; // Set loading state
    });

    try {
      final response = await DataService().selectId(
        '6717db9aec5074ec8261d698', // Token
        'uas-sis', // Project
        'surat', // Collection
        '677eb6dae9cc622b8bd171ea', // App ID
        widget.kode_proposal, // Surat ID
      ); // Fetch surat by ID

      if (response.isNotEmpty) {
        final data = response; // Use the response directly
        setState(() {
          surat = SuratModel.fromJson(data);
          _isLoading = false;
        });
      } else {
        // Handle the case where no data is returned
        setState(() {
          _isLoading = false; // Set loading state to false
        });
      }
    } catch (e) {
      print('Error fetching surat details: $e');
      setState(() {
        _isLoading = false; // Set loading state to false
      });
    }
  }

  // Future<void> _updateSuratStatus(String status, {String? feedback}) async {
  //   try {
  //     final Map<String, dynamic> updates = {
  //       'status_surat': status,
  //     };
  //     if (feedback != null) {
  //       updates['feedback_surat'] =
  //           feedback; // Tambahkan kolom feedback jika ada
  //     }

  //     await DataService().updateId(
  //       'status_surat', // Field to update
  //       status,
  //       '6717db9aec5074ec8261d698', // Token
  //       'uas-sis', // Project
  //       'surat', // Collection
  //       '677eb6dae9cc622b8bd171ea', // App ID
  //       widget.kode_proposal, // Surat ID
  //     );
  //   } catch (e) {
  //     print('Error updating surat status: $e');
  //   }
  // }

  Future<void> _updateFeedback(String feedback) async {
    try {
      await DataService().updateId(
        'feedback_proposal', // Field to update
        feedback, // Feedback content
        '6717db9aec5074ec8261d698', // Token
        'uas-sis', // Project
        'surat', // Collection
        '677eb6dae9cc622b8bd171ea', // App ID
        widget.kode_proposal, // Surat ID
      ); // Update feedback
    } catch (e) {
      print('Error updating feedback: $e');
    }
  }

  Future<void> _updateSuratStatus(String status) async {
    try {
      await DataService().updateId(
        'status_surat', // Field to update
        status, // New status
        '6717db9aec5074ec8261d698', // Token
        'uas-sis', // Project
        'surat', // Collection
        '677eb6dae9cc622b8bd171ea', // App ID
        widget.kode_proposal, // Surat ID
      ); // Update surat status
    } catch (e) {
      print('Error updating surat status: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: ClipRRect(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
          child: AppBar(
            automaticallyImplyLeading: false,
            leading: IconButton(
              icon: Icon(Icons.close, color: Colors.white),
              onPressed: () {
                // Logika khusus saat tombol back ditekan
                Navigator.pop(context); // Kembali ke halaman sebelumnya
              },
            ),
            backgroundColor: Colors.orange,
            title: Text(
              'Mail Details',
              style: GoogleFonts.poppins(color: Colors.white),
            ),
            centerTitle: true,
          ),
        ),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator()) // Show loading indicator
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    surat.judul_proposal,
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Category: ${surat.kategory_proposal}',
                    style: GoogleFonts.poppins(
                        fontSize: 16, color: Colors.grey[600]),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Request Date: ${surat.tanggal_pengajuan}',
                    style: GoogleFonts.poppins(
                        fontSize: 16, color: Colors.grey[600]),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Description:',
                    style: GoogleFonts.poppins(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text(
                    surat.deskripsi_proposal,
                    style: GoogleFonts.poppins(fontSize: 16),
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () async {
                          final TextEditingController feedbackController =
                              TextEditingController();

                          // Tampilkan dialog untuk input feedback
                          await showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(
                                  'Provide Feedback',
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold),
                                ),
                                content: TextField(
                                  controller: feedbackController,
                                  maxLines: 4,
                                  decoration: InputDecoration(
                                    hintText: 'Enter your feedback here...',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    child: Text('Cancel',
                                        style: GoogleFonts.poppins(
                                            color: Colors.red)),
                                    onPressed: () {
                                      Navigator.pop(context); // Tutup dialog
                                    },
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green),
                                    child: Text('Submit',
                                        style: GoogleFonts.poppins(
                                            color: Colors.white)),
                                    onPressed: () async {
                                      final feedback =
                                          feedbackController.text.trim();
                                      if (feedback.isNotEmpty) {
                                        // Navigator.pop(context); // Tutup dialog

                                        // Update feedback terlebih dahulu
                                        await _updateFeedback(feedback);

                                        // Setelah feedback berhasil diupdate, update status surat
                                        await _updateSuratStatus("Rejected - bku");

                                        // Tampilkan notifikasi sukses
                                        await ArtSweetAlert.show(
                                          context: context,
                                          artDialogArgs: ArtDialogArgs(
                                            type: ArtSweetAlertType.success,
                                            title: "Rejected!",
                                            text:
                                                "Feedback and status updated successfully.",
                                          ),
                                        ).then((_) {
                                          Navigator.pop(context,
                                              true); // Kembali ke dashboard
                                        }).then((_) {
                                          Navigator.pop(context,
                                              true); // Kembali ke dashboard
                                        });
                                      } else {
                                        // Feedback tidak boleh kosong
                                        ArtSweetAlert.show(
                                          context: context,
                                          artDialogArgs: ArtDialogArgs(
                                            type: ArtSweetAlertType.danger,
                                            title: "Error",
                                            text: "Feedback cannot be empty!",
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        icon: FaIcon(FontAwesomeIcons.timesCircle,
                            color: Colors.white),
                        label: Text('Reject',
                            style: GoogleFonts.poppins(color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () async {
                          ArtDialogResponse response = await ArtSweetAlert.show(
                            barrierDismissible: false,
                            context: context,
                            artDialogArgs: ArtDialogArgs(
                              denyButtonText: "Cancel",
                              title: "Are you sure?",
                              text: "You won't be able to revert this!",
                              confirmButtonText: "Yes, approve it",
                              type: ArtSweetAlertType.warning,
                            ),
                          );

                          if (response == null) {
                            return;
                          }

                          if (response.isTapConfirmButton) {
                            await _updateSuratStatus(
                                "Approved"); // Update status to "On Progress - Faculty"
                            ArtSweetAlert.show(
                              context: context,
                              artDialogArgs: ArtDialogArgs(
                                type: ArtSweetAlertType.success,
                                title: "Approved!",
                              ),
                            ).then((_) {
                              Navigator.pop(context,
                                  true); // Kembali ke Student Dashboard
                            });
                          }
                        },
                        icon: FaIcon(FontAwesomeIcons.checkCircle,
                            color: Colors.white),
                        label: Text('Approve',
                            style: GoogleFonts.poppins(color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
