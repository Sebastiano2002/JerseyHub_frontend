import 'League.dart';
import 'Maglia.dart';

class Squadra {
  final int idSquadra;
  final String squadra;
  final String img;
  final League league;  // Oggetto League
  final List<Maglia> maglie;  // Lista di oggetti Maglia

  Squadra({
    required this.idSquadra,
    required this.squadra,
    required this.img,
    required this.league,
    required this.maglie,
  });

  factory Squadra.fromJson(Map<String, dynamic> json) {
    var list = json['maglie'] as List;
    List<Maglia> maglieList = list.map((i) => Maglia.fromJson(i)).toList();

    return Squadra(
      idSquadra: json['idSquadra'],
      squadra: json['squadra'],
      img: json['img'],
      league: League.fromJson(json['league']),
      maglie: maglieList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idSquadra': idSquadra,
      'squadra': squadra,
      'img': img,
      'league': league.toJson(),
      'maglie': maglie.map((e) => e.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return squadra;
  }

}
