import 'OrdineMaglia.dart';
import 'User.dart';

class Ordine {
  int idOrdine;
  double? prezzoTot;
  String utente;
  List<OrdineMaglia> ordineMaglie;  // Lista di OrdineMaglia
  int pagamento;  // Stato del pagamento

  Ordine({
    required this.idOrdine,
    this.prezzoTot,
    required this.utente,
    required this.ordineMaglie,
    required this.pagamento,
  });

  factory Ordine.fromJson(Map<String, dynamic> json) {
    var list = json['items'] as List;
    List<OrdineMaglia> ordineMaglieList =
    list.map((i) => OrdineMaglia.fromJson(i as Map<String, dynamic>)).toList();

    return Ordine(
      idOrdine: json['idOrdine'],
      prezzoTot: json['prezzoTot'],
      utente: json['utente'],
      ordineMaglie: ordineMaglieList,
      pagamento: json['pagamento'],
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'idOrdine': idOrdine,
      'prezzoTot': prezzoTot,
      'utente': utente,
      'ordineMaglie': ordineMaglie.map((e) => e.toJson()).toList(),
      'pagamento': pagamento,
    };
  }
}
