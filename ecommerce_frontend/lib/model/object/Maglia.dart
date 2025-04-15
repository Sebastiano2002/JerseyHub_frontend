class Maglia {
  int idMaglia;
  String nome;
  String img;
  int quantitaDisp;
  double prezzo;
  String squadName;

  Maglia({
    required this.idMaglia,
    required this.nome,
    required this.img,
    required this.quantitaDisp,
    required this.prezzo,
    required this.squadName,
  });

  factory Maglia.fromJson(Map<String, dynamic> json) {
    return Maglia(
      idMaglia: json['idMaglia'],
      nome: json['nomeMaglia'] ?? '',
      img: json['img'] ?? '',
      quantitaDisp: json['quantitaDisp'] ?? 0,
      prezzo: (json['prezzo'] as num?)?.toDouble() ?? 0.0,
      squadName: json['squadra'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idMaglia': idMaglia,
      'nome': nome,
      'img': img,
      'quantitaDisp': quantitaDisp,
      'prezzo': prezzo,
    };
  }

  @override
  String toString() {
    return nome;
  }
}
