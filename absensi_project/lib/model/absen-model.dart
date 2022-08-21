class Absen {
  final int? idAbsensi;
  final String nik;
  final String fullname;
  final String? address;
  final String? dateIn;
  final String? dateOut;
  final String status;

  const Absen({
    required this.idAbsensi,
    required this.fullname,
    required this.address,
    required this.dateIn,
    required this.dateOut,
    required this.nik,
    required this.status
  });

  factory Absen.fromJson(Map<String, dynamic> json){
    return Absen(
        idAbsensi: json['idAbsensi'],
        fullname: json['fullname'],
        address: json['address'],
        dateIn: json['dateIn'] != null
            ? json['dateIn'].toString().replaceFirst('T', ' ')
            : "",
        dateOut: json['dateOut'] != null
            ? json['dateOut'].toString().replaceFirst('T', ' ')
            : "-",
        nik: json['nik'],
        status: json['status']);
  }
}