import 'package:flutter/material.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController expirationDateController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    bool isMobile = mediaQuery.size.width < 800;

    return Scaffold(
      backgroundColor: Colors.lightBlue.shade200,
      body: Column(
        children: [
          if (isMobile) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.asset(
                    "assets/imgs/JerseyHub.png",
                    width: 70,
                    height: 70,
                  ),
                ),
                const SizedBox(
                  width: 40,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 40,
                      )),
                )
              ],
            ),
          ] else ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.close,
                        color: Colors.lightBlue,
                        size: 40,
                      )),
                )
              ],
            ),
          ],
          SizedBox(
            height: MediaQuery.of(context).size.height / 6,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        const Row(
                          children: [
                            Text(
                              "Payment Details",
                              style: TextStyle(
                                color: Color(0xFF03A9F4),
                                fontFamily: "Ubuntu",
                                fontSize: 50,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 40),
                          child: SizedBox(
                            width: 300,
                            child: TextField(
                              controller: cardNumberController,
                              style: const TextStyle(
                                  color: Color(0xFF03A9F4),
                                  fontFamily: "Ubuntu"),
                              cursorColor: Color(0xFF03A9F4),
                              autofocus: false,
                              minLines: 1,
                              maxLines: 1,
                              decoration: const InputDecoration(
                                labelText: "Card Number",
                                labelStyle: TextStyle(
                                  color: Color(0xFF03A9F4),
                                ),
                                prefixIcon: Icon(
                                  Icons.credit_card,
                                  color: Color(0xFF03A9F4),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(
                                      color: Color(0xFF03A9F4), width: 10.0),
                                ),
                                contentPadding: EdgeInsets.all(0),
                                floatingLabelBehavior:
                                FloatingLabelBehavior.never,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: SizedBox(
                            width: 300,
                            child: TextField(
                              controller: expirationDateController,
                              style: const TextStyle(
                                  color: Color(0xFF03A9F4),
                                  fontFamily: "Ubuntu"),
                              cursorColor: Color(0xFF03A9F4),
                              autofocus: false,
                              minLines: 1,
                              maxLines: 1,
                              decoration: const InputDecoration(
                                labelText: "Expiration Date (MM/YY)",
                                labelStyle: TextStyle(
                                  color: Color(0xFF03A9F4),
                                ),
                                prefixIcon: Icon(
                                  Icons.calendar_today,
                                  color: Color(0xFF03A9F4),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(
                                      color: Color(0xFF03A9F4), width: 10.0),
                                ),
                                contentPadding: EdgeInsets.all(0),
                                floatingLabelBehavior:
                                FloatingLabelBehavior.never,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: SizedBox(
                            width: 300,
                            child: TextField(
                              controller: cvvController,
                              style: const TextStyle(
                                  color: Color(0xFF03A9F4),
                                  fontFamily: "Ubuntu"),
                              cursorColor: Color(0xFF03A9F4),
                              autofocus: false,
                              minLines: 1,
                              maxLines: 1,
                              obscureText: true,
                              decoration: const InputDecoration(
                                labelText: "CVV",
                                labelStyle: TextStyle(
                                  color: Color(0xFF03A9F4),
                                ),
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: Color(0xFF03A9F4),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(
                                      color: Color(0xFF03A9F4), width: 10.0),
                                ),
                                contentPadding: EdgeInsets.all(0),
                                floatingLabelBehavior:
                                FloatingLabelBehavior.never,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              ElevatedButton(
                                onPressed: () async {
                                  // Logica per effettuare il pagamento
                                  if (cardNumberController.text.isEmpty ||
                                      expirationDateController.text.isEmpty ||
                                      cvvController.text.isEmpty) {
                                    WidgetsBinding.instance.addPostFrameCallback((_) {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text('Errore'),
                                            content: Text(
                                                'Compila tutti i campi per effettuare il pagamento.'),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text('OK'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    });
                                    // Restituisci false se i campi sono vuoti (pagamento non riuscito)
                                    Navigator.pop(context, false);
                                  } else {
                                    await showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          backgroundColor: Colors.lightBlue.shade200,
                                          title: const Text('Pagamento in corso', style: TextStyle(color: Colors.white)),
                                          content: const Text('Dati recuperati correttamente', style: TextStyle(color: Colors.white)),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text('OK', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                    // Pagamento riuscito, restituisci true
                                    Navigator.pop(context, true);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.lightBlue,
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  side: BorderSide(color: Colors.lightBlue, width: 2),
                                ),
                                child: const Text("Pay Now"),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              if (!isMobile) ...[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.asset(
                        "assets/imgs/JerseyHub.png",
                        width: MediaQuery.of(context).size.height / 2,
                      ),
                    ),
                  ],
                ),
              ]
            ],
          ),
        ],
      ),
    );
  }
}
