import 'Ordine.dart';

class Pagamento {
  final int idPagamento;
  final String metodoPag;
  final String numCarta;
  final DateTime data;
  final String stato;  // Stato del pagamento
  final Ordine ordine;  // Oggetto Ordine

  Pagamento({
    required this.idPagamento,
    required this.metodoPag,
    required this.numCarta,
    required this.data,
    required this.stato,
    required this.ordine,
  });

  factory Pagamento.fromJson(Map<String, dynamic> json) {
    return Pagamento(
      idPagamento: json['idPagamento'],
      metodoPag: json['metodoPag'],
      numCarta: json['numCarta'],
      data: DateTime.parse(json['data']),
      stato: json['stato'],
      ordine: Ordine.fromJson(json['ordine']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idPagamento': idPagamento,
      'metodoPag': metodoPag,
      'numCarta': numCarta,
      'data': data.toIso8601String(),
      'stato': stato,
      'ordine': ordine.toJson(),
    };
  }
}
