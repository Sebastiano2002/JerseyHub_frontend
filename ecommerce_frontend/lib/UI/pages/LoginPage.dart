import 'package:flutter/material.dart';
import '../../Provider/LogProvider.dart';
import '../../model/Model.dart';
import 'RegistrationPage.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({Key? key}) : super(key: key);

  @override
  State<Loginpage> createState() => _LoginState();
}

class _LoginState extends State<Loginpage> {
  @override
  Widget build(BuildContext context) {
    final logprovider = LogProvider.of(context, listen: false);
    final mediaQuery = MediaQuery.of(context);
    bool isMobile = mediaQuery.size.width < 800;
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

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
              // Colonna con il container bianco sporco e bordi arrotondati
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFF5F5F5),
                      borderRadius:
                      BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        const Row(
                          children: [
                            Text(
                              "Welcome!!",
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
                              autocorrect: true,
                              style: const TextStyle(
                                  color: Color(0xFF03A9F4),
                                  fontFamily: "Ubuntu"),
                              cursorColor: Color(0xFF03A9F4),
                              autofocus: false,
                              minLines: 1,
                              maxLines: 1,
                              controller: emailController,
                              textAlignVertical: TextAlignVertical.center,
                              decoration: const InputDecoration(
                                labelText: "email",
                                labelStyle: TextStyle(
                                  color: Color(0xFF03A9F4),
                                ),
                                fillColor: Color(0xFF03A9F4),
                                prefixIcon: Icon(
                                  Icons.person,
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
                          padding: const EdgeInsets.only(top: 30, bottom: 30),
                          child: SizedBox(
                            width: 300,
                            child: TextField(
                              autocorrect: true,
                              style: const TextStyle(
                                  color: Color(0xFF03A9F4),
                                  fontFamily: "Ubuntu"),
                              cursorColor: Color(0xFF03A9F4),
                              controller: passwordController,
                              autofocus: false,
                              minLines: 1,
                              maxLines: 1,
                              textAlignVertical: TextAlignVertical.center,
                              obscureText: true,
                              decoration: const InputDecoration(
                                labelText: "password",
                                labelStyle: TextStyle(
                                  color: Color(0xFF03A9F4),
                                ),
                                fillColor: Color(0xFF03A9F4),
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
                                alignLabelWithHint: true,
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
                                  if (emailController.text.isEmpty ||
                                      passwordController.text.isEmpty) {
                                    WidgetsBinding.instance
                                        .addPostFrameCallback((_) {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text('Errore'),
                                            content: Text(
                                                'Compila tutti i campi per effettuare il login.'),
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
                                  } else {
                                    LogInResult result =
                                    await Model.sharedInstance.logIn(
                                        emailController.text,
                                        passwordController.text);
                                    print(result);
                                    if (result == LogInResult.logged) {
                                      logprovider.LogIn();
                                      Navigator.pop(context);
                                    } else if (result ==
                                        LogInResult.wrong_credentials_error) {
                                      WidgetsBinding.instance
                                          .addPostFrameCallback((_) {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text('Errore'),
                                              content: Text(
                                                  'Username o password non corretta'),
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
                                    } else if (result ==
                                        LogInResult.user_not_fully_setupped_error) {
                                    } else {
                                      WidgetsBinding.instance
                                          .addPostFrameCallback((_) {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text('Errore'),
                                              content: Text(
                                                  'Errore sconosciuto non è stato possibile fare il login'),
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
                                    }
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.lightBlue,
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  side: BorderSide(
                                      color: Colors.lightBlue, width: 2),
                                ),
                                child: const Text("Login"),
                              ),
                              SizedBox(width: 40),
                              ElevatedButton(
                                onPressed: () {  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => RegistrationPage()));},
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.lightBlue,
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  side: BorderSide(
                                      color: Colors.lightBlue, width: 2),
                                ),
                                child: const Text("Sign up"),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              // Immagine spostata accanto al container
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