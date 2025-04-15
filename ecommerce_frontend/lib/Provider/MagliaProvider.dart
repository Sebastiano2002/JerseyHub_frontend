import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../model/object/Maglia.dart';  // Assicurati che il path sia corretto

class MagliaProvider extends ChangeNotifier {
  List<Maglia> _maglie = [];
  bool _search = true;

  List<Maglia> get maglie => _maglie;
  bool get search=> _search;

  void updateMaglie({required List<Maglia> nuoveMaglie}) async{
    _maglie = nuoveMaglie;
    _search=false;
    notifyListeners();
  }

  void clear() {
    _maglie.clear();
    _search = true;
    notifyListeners();
  }

  void addMaglia(Maglia maglia) {
    _maglie.add(maglia);
    notifyListeners();
  }

  void removeMaglia(Maglia maglia) {
    _maglie.remove(maglia);
    notifyListeners();
  }

  static MagliaProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<MagliaProvider>(context, listen: listen);
  }
}
