import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../model/object/OrdineMaglia.dart';

class CartProvider extends ChangeNotifier {
  List<OrdineMaglia> _orderItems = [];

  List<OrdineMaglia> get orderItems => _orderItems;

  void addItem({required OrdineMaglia newItem}) async {
    if (_orderItems.contains(newItem)) {

      var existingItem = _orderItems.firstWhere(
            (item) => item.maglia == newItem.maglia,
      );
      existingItem.increaseQty();
    } else {

      _orderItems.add(newItem);
    }
    notifyListeners();  // Notifica ai consumatori che lo stato è cambiato
  }

  void removeItem({required OrdineMaglia item}) async {
    if (_orderItems.contains(item)) {
      item.decreaseQty(); // Assicurati che `removeQuantity` sia definito in OrdineMaglia
      if (item.richiesta == 0) _orderItems.remove(item);
      notifyListeners();
    }
  }
  void clear() {
    _orderItems.clear();
    notifyListeners();
  }

  Future<double> getTotalPrice() async {
    double total = 0.0;
    for (var item in _orderItems) {
      total += item.maglia.prezzo * item.richiesta;
    }
    return total;
  }

  int getItemQty({ required OrdineMaglia item}) {
    return item.richiesta;
  }

  static CartProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<CartProvider>(
      context,
      listen: listen,
    );
  }
}
