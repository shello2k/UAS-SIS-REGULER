class SuratModel {
   final String id;
   final String penerima;
   final String judul_proposal;
   final String kategory_proposal;
   final String deskripsi_proposal;
   final String tanggal_pengajuan;
   final String status_surat;
   final String kode_proposal;
   final String feedback_proposal;

   SuratModel({
      required this.id,
      required this.penerima,
      required this.judul_proposal,
      required this.kategory_proposal,
      required this.deskripsi_proposal,
      required this.tanggal_pengajuan,
      required this.status_surat,
      required this.kode_proposal,
      required this.feedback_proposal
   });

   factory SuratModel.fromJson(Map data) {
      return SuratModel(
         id: data['_id'],
         penerima: data['penerima'],
         judul_proposal: data['judul_proposal'],
         kategory_proposal: data['kategory_proposal'],
         deskripsi_proposal: data['deskripsi_proposal'],
         tanggal_pengajuan: data['tanggal_pengajuan'],
         status_surat: data['status_surat'],
         kode_proposal: data['kode_proposal'],
         feedback_proposal: data['feedback_proposal']
      );
   }


  // Add the copyWith method
  SuratModel copyWith({
    String? id,
    String? penerima,
    String? judul_proposal,
    String? kategory_proposal,
    String? deskripsi_proposal,
    String? tanggal_pengajuan,
    String? status_surat,
    String? kode_proposal,
    String? feedback_proposal,
  }) {
    return SuratModel(
      id: id ?? this.id,
      penerima: penerima ?? this.penerima,
      judul_proposal: judul_proposal ?? this.judul_proposal,
      kategory_proposal: kategory_proposal ?? this.kategory_proposal,
      deskripsi_proposal: deskripsi_proposal ?? this.deskripsi_proposal,
      tanggal_pengajuan: tanggal_pengajuan ?? this.tanggal_pengajuan,
      status_surat: status_surat ?? this.status_surat,
      kode_proposal: kode_proposal ?? this.kode_proposal,
      feedback_proposal: feedback_proposal ?? this.feedback_proposal,
    );
  }
}
