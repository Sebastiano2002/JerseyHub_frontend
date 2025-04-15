import 'Squadra.dart';

class League {
  final int idLeague;
  final String leagueName;
  final String? img;  // Campo opzionale
  final List<Squadra> squadre;  // Lista di oggetti Squadra

  League({
    required this.idLeague,
    required this.leagueName,
    this.img,
    required this.squadre,
  });

  factory League.fromJson(Map<String, dynamic> json) {
    var list = json['squadre'] as List;
    List<Squadra> squadreList =
    list.map((item) => Squadra.fromJson(item)).toList();

    return League(
      idLeague: json['idLeague'],
      leagueName: json['leagueName'],
      img: json['img'],
      squadre: squadreList,
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'idLeague': idLeague,
      'leagueName': leagueName,
      'img': img,
      'squadre': squadre.map((elem) => elem.toJson()).toList(),
    };
  }

  @override
  String toString(){
    return leagueName;
  }
}
