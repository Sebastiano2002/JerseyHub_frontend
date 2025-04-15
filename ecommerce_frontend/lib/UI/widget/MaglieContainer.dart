import 'package:ecommerce_frontend/UI/aspetti/StileMaglia.dart';
import 'package:ecommerce_frontend/model/object/Maglia.dart';
import 'package:ecommerce_frontend/model/object/OrdineMaglia.dart';
import 'package:ecommerce_frontend/model/support/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Provider/CartProvider.dart';

class MagliaContainer extends StatelessWidget {
  const MagliaContainer({
    super.key,
    required this.maglia,
  });
  final Maglia maglia;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        boxShadow: [StileMaglia.productShodow],
        borderRadius: BorderRadius.circular(16.0),
        color: Colors.white,
      ),
      child: Column(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              final double width = constraints.maxWidth;
              final double height = width; // Altezza 3/4 della larghezza

              return Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.0),
                  border: Border.all(color: Colors.white),
                ),
                child: Image.asset(
                  maglia.img ?? 'assets/imgs/defaultImage.png',
                  fit: BoxFit.contain, // Adatta l'immagine al contenitore
                ),
              );
            },
          ),
          const SizedBox(height: Constants.pmd),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  maglia.toString(),
                  style: Theme.of(context).textTheme.headlineLarge,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  textAlign: TextAlign.left,
                ),
                Text(
                  maglia.squadName.toString(),
                  style: Theme.of(context).textTheme.bodySmall,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: Constants.pmd),
                Row(
                  children: [
                    Text(
                      '\€' + maglia.prezzo.toString(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        if (maglia.quantitaDisp != 0) {
                          context.read<CartProvider>().addItem(
                            newItem: OrdineMaglia(maglia: maglia, richiesta: 1),
                          );
                          FocusManager.instance.primaryFocus?.unfocus();
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor: Colors.lightBlue.shade200,
                                title: const Text(
                                  'Carrello aggiornato',
                                  style: TextStyle(color: Colors.white),
                                ),
                                content: const Text(
                                  'Inserimento effettuato con successo',
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
                        } else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor: Colors.lightBlue.shade200,
                                title: const Text(
                                  'Il prodotto è al momento fuori stock',
                                  style: TextStyle(color: Colors.white),
                                ),
                                content: const Text(
                                  'Riprova fra un pò',
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
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.lightBlue.shade200,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        side: BorderSide(color: Colors.blueGrey),
                      ),
                      child: const Text("Compra"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
