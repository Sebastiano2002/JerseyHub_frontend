import 'Maglia.dart';
import 'Ordine.dart';

class OrdineMaglia {
  int? idOrdineMaglia;
  int? ordine;
  Maglia maglia;  // Oggetto Maglia
  String? giocatore;
  int? numero;
  String? taglia;
  int richiesta;

  OrdineMaglia({
    this.idOrdineMaglia,
    this.ordine,
    required this.maglia,
    this.giocatore,
    this.numero,
    this.taglia,
    required this.richiesta,
  });

  factory OrdineMaglia.fromJson(Map<String, dynamic> json) {
    return OrdineMaglia(
      idOrdineMaglia: json['idOrdineMaglia'],
      ordine: json['ordine'],
      maglia: Maglia.fromJson(json['maglia']),
      giocatore: json['giocatore'],
      numero: json['numero'],
      taglia: json['taglia'],
      richiesta: json['richiesta'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idOrdineMaglia': idOrdineMaglia,
      'ordine': ordine,
      'maglia': maglia.toJson(),
      'giocatore': giocatore,
      'numero': numero,
      'taglia': "Unisize",
      'richiesta': richiesta,
    };
  }

  void increaseQty() {
    if (maglia.quantitaDisp > richiesta) {
      richiesta++;
    }
  }

  // Riduci la quantità
  void decreaseQty() {
    if (richiesta > 0) {
      richiesta--;
    }
  }
}
