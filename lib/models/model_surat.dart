class SuratModel {
   final String id;
   final String penerima; //untuk menentukan siapa yang menerima surat
   final String judul_proposal; //judul surat
   final String kategory_proposal; //kategori surat
   final String deskripsi_proposal; //deskripsi surat
   final String tanggal_pengajuan; //tanggal pengajuan surat
   final String status_surat; //status surat (contoh : sent, approved, rejected)
   final String kode_proposal; //kode proposal yang digenerate oleh program
   final String feedback_proposal; //feedback dari head atau faculty

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
}