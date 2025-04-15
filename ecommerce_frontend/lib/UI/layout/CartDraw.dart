import 'package:ecommerce_frontend/UI/pages/PaymentPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Provider/CartProvider.dart';
import '../../Provider/LogProvider.dart';
import '../../model/Model.dart';
import '../pages/LoginPage.dart';

class CartDraw extends StatefulWidget {
  @override
  _CartDrawState createState() => _CartDrawState();
}

class _CartDrawState extends State<CartDraw> {
  @override
  Widget build(BuildContext context) {
    final provider = CartProvider.of(context, listen: false);
    final finalList = provider.orderItems;
    LogProvider logProvider = LogProvider.of(context);

    return Drawer(
      backgroundColor: Color(0xFAD3D3D7),
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.lightBlueAccent,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    ElevatedButton(
                        child: const Text(
                          "Pagamento",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.lightBlue),
                        ),
                        onPressed: () async {
                          if (!logProvider.log) {
                            await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  backgroundColor: Colors.lightBlue.shade200,
                                  title: const Text(
                                    'Impossibile effettuare il pagamento',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  content: const Text(
                                    'Devi effettuare il login per procedere con il pagamento.',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('OK', style: TextStyle(color: Colors.white)),
                                    ),
                                  ],
                                );
                              },
                            );
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Loginpage()));
                          } else {
                            if (!finalList.isEmpty) {
                              bool aq = true;
                              await showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    backgroundColor: Colors.lightBlue.shade200,
                                    title: const Text('Conferma l\'acquisto', style: TextStyle(color: Colors.white)),
                                    content: const Text('Sei sicuro di voler procedere?', style: TextStyle(color: Colors.white)),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Sì', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          aq = false;
                                        },
                                        child: Text('No', style: TextStyle(color: Colors.red[800], fontWeight: FontWeight.bold)),
                                      ),
                                    ],
                                  );
                                },
                              );

                              if (aq) {
                                bool? paymentSuccess = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PaymentPage()),
                                );
                                if (paymentSuccess != null && paymentSuccess) {
                                  bool purchase = await Model.sharedInstance
                                      .purchase(finalList);
                                  if (purchase) {
                                    setState(() => provider.clear());
                                    await showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          backgroundColor: Colors.lightBlue
                                              .shade200,
                                          title: const Text(
                                              'Ordine completato!',
                                              style: TextStyle(
                                                  color: Colors.white)),
                                          content: const Text(
                                              'Hai acquistato con successo.',
                                              style: TextStyle(
                                                  color: Colors.white)),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text('OK',
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }
                                }
                              }
                            }
                          }
                        }),
                    Spacer(),
                    FutureBuilder<double>(
                      future: provider.getTotalPrice(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Errore: ${snapshot.error}');
                        } else {
                          return Text(
                            '\$${snapshot.data?.toStringAsFixed(2) ?? '0.00'}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                color: Colors.white),
                          );
                        }
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: finalList.length,
            itemBuilder: (context, index) {
              final cartItems = finalList[index];
              return Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Container(
                              height: 150,
                              width: 90,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                              ),
                              child: FittedBox(
                                fit: BoxFit.contain,
                                child: Image.asset(
                                    cartItems.maglia.img ??
                                        'assets/imgs/defaultImage.png'),
                              )),
                          const SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                cartItems.maglia.nome,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "\$${cartItems.maglia.prezzo}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Bottone "+" quadrato con bordi smussati
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      context.read<CartProvider>().addItem(
                                          newItem: cartItems);
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: Colors.lightBlue.shade200,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0), // Bordi smussati
                                    ),
                                    side: BorderSide(color: Colors.blueGrey),
                                    minimumSize: Size(50, 50), // Larghezza e altezza uguali
                                  ),
                                  child: const Icon(Icons.add),
                                ),
                                const SizedBox(height: 10),
                                Consumer<CartProvider>(
                                  builder: (context, cartProvider, child) {
                                    return Text(
                                      "${cartProvider.getItemQty(item: cartItems)}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    );
                                  },
                                ),
                                const SizedBox(height: 10),
                                // Bottone "-" quadrato con bordi smussati
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      context.read<CartProvider>().removeItem(
                                          item: cartItems);
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: Colors.lightBlue.shade200,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0), // Bordi smussati
                                    ),
                                    side: BorderSide(color: Colors.blueGrey),
                                    minimumSize: Size(50, 50), // Larghezza e altezza uguali
                                  ),
                                  child: const Icon(Icons.remove),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
