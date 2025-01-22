class Facture {
  final String pvcnum; // Facture number
  final String soldeEcheance; // Balance due

  Facture({required this.pvcnum, required this.soldeEcheance});

  factory Facture.fromJson(Map<String, dynamic> json) {
    return Facture(
      pvcnum: json['pcvnum'],
      soldeEcheance: json['soldE_ECHEANCE'].toString(),
    );
  }
}