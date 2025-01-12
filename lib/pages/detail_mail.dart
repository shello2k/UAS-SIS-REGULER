import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:art_sweetalert/art_sweetalert.dart';

class DetailMail extends StatelessWidget {
  // Data dummy
  final String title = "Permohonan Cuti";
  final String description =
      "Saya ingin mengajukan cuti selama 2 minggu karena alasan kesehatan. Mohon persetujuan dari pihak terkait.";
  final String category = "Cuti";
  final String requestDate = "01 Januari 2025";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: ClipRRect(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
          child: AppBar(
            backgroundColor: Colors.orange,
            title: Text(
              'Mail Details',
              style: GoogleFonts.poppins(color: Colors.white),
            ),
            centerTitle: true,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Category: $category',
              style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey[600]),
            ),
            SizedBox(height: 5),
            Text(
              'Request Date: $requestDate',
              style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey[600]),
            ),
            SizedBox(height: 20),
            Text(
              'Description:',
              style: GoogleFonts.poppins(
                  fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              description,
              style: GoogleFonts.poppins(fontSize: 16),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () async {
                    ArtDialogResponse response = await ArtSweetAlert.show(
                      barrierDismissible: false,
                      context: context,
                      artDialogArgs: ArtDialogArgs(
                        denyButtonText: "Cancel",
                        title: "Are you sure?",
                        text: "You won't be able to revert this!",
                        confirmButtonText: "Yes, reject it",
                        type: ArtSweetAlertType.warning,
                      ),
                    );

                    if (response == null) {
                      return;
                    }

                    if (response.isTapConfirmButton) {
                      ArtSweetAlert.show(
                        context: context,
                        artDialogArgs: ArtDialogArgs(
                          type: ArtSweetAlertType.success,
                          title: "Rejected!",
                        ),
                      );
                    }
                  },
                  icon:
                      FaIcon(FontAwesomeIcons.timesCircle, color: Colors.white),
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
                      ArtSweetAlert.show(
                        context: context,
                        artDialogArgs: ArtDialogArgs(
                          type: ArtSweetAlertType.success,
                          title: "Approved!",
                        ),
                      );
                    }
                  },
                  icon:
                      FaIcon(FontAwesomeIcons.checkCircle, color: Colors.white),
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
