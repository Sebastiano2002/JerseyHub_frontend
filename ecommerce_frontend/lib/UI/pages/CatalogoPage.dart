import 'package:ecommerce_frontend/UI/widget/MaglieContainer.dart';
import 'package:ecommerce_frontend/model/support/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Provider/MagliaProvider.dart';
import '../../model/Model.dart';

class CatalogoPage extends StatefulWidget {
  @override
  _CatalogoPageState createState() => _CatalogoPageState();
}

class _CatalogoPageState extends State<CatalogoPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      final provider = Provider.of<MagliaProvider>(context, listen: false);
      _search(provider);
    });
  }

  void _search(provider) {
    Model.sharedInstance.getAllProduct()!.then((product) {
      if (product != null) {
        setState(() {
          print(product);
          provider.updateMaglie(nuoveMaglie: product);
        });
      } else {
        print("Nessun prodotto trovato.");
        setState(() {
          provider.clear();
        });
      }
    }).catchError((error) {
      // Gestione dell'errore
      setState(() {
        provider.clear();
      });
      print("Errore durante la ricerca dei prodotti: $error");
    });

  }

  @override
  Widget build(BuildContext context) {
    final provider = MagliaProvider.of(context);
    var screenSize = MediaQuery.of(context).size;
    int num = (screenSize.width - Constants.wfmax) ~/ Constants.wmax;
    int numItemGrid = num < 1 ? 1 : num;
    print(provider.maglie);

    return Scaffold(
      backgroundColor: Colors.lightBlue[200],
      body: Padding(
        padding: const EdgeInsets.all(Constants.pmd),
        child: Row(
          children: [
            // Colonna principale con griglia
            Expanded(
              child: provider.maglie.isEmpty
                  ? Center(child: Text("Nessuna maglia trovata"))
                  : GridView.builder(
                shrinkWrap: true,
                itemCount: provider.maglie.length,
                itemBuilder: (context, index) {
                  final maglia = provider.maglie[index];
                  return Padding(
                    padding: const EdgeInsets.all(Constants.pmd),
                    child: MagliaContainer(maglia: maglia),
                  );
                },
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: numItemGrid,
                  childAspectRatio:
                  Constants.wmax / Constants.hmax,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
