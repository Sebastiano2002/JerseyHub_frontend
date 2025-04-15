import 'Ordine.dart';

class User {
  int? idUser;
  String email;
  String nome;
  String cognome;
  String telefono;
  String? citta;
  String? indirizzo;
  String cap;
  int carrello;

  User({
    this.idUser,
    required this.email,
    required this.nome,
    required this.cognome,
    required this.telefono,
    this.citta,
    this.indirizzo,
    required this.cap,
    required this.carrello,
  });

  factory User.fromJson(Map<String, dynamic> json) {

    return User(
      idUser: json['idUser'],
      email: json['email'],
      nome: json['nome'],
      cognome: json['cognome'],
      telefono: json['telefono'],
      citta: json['citta'],
      indirizzo: json['indirizzo'],
      cap: json['cap'],
      carrello: json['carrello'],
    );
  }

  Map<String, dynamic> toJson() {
    // Non includo la lista degli ordini nella serializzazione
    return {
      'idUser': idUser,
      'email': email,
      'nome': nome,
      'cognome': cognome,
      'telefono': telefono,
      'citta': citta,
      'indirizzo': indirizzo,
      'cap': cap,
      'carrello': carrello,
    };
  }

  @override
  String toString() {
    return email;
  }
}
