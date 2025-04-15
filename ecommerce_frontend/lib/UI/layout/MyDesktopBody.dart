import 'package:ecommerce_frontend/UI/layout/CartDraw.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Provider/LogProvider.dart';
import '../../model/Model.dart';
import '../pages/CatalogoPage.dart';
import '../pages/LoginPage.dart';

class MyDesktopBody extends StatefulWidget {
  const MyDesktopBody({Key? key}) : super(key: key);

  @override
  _MyDesktopBodyState createState() => _MyDesktopBodyState();
}

class _MyDesktopBodyState extends State<MyDesktopBody> {
  @override
  Widget build(BuildContext context) {
    var dim = MediaQuery.of(context).size.width * 0.35;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        endDrawer: SizedBox(width: dim > 450 ? dim : 450, child: CartDraw()),
        body: Column(
          children: [
            AppBar(
              backgroundColor: Colors.white,
              title: const Text('J E R S E Y_H U B', style: TextStyle(color: Colors.blue),),
              actions: [
                Consumer<LogProvider>(
                  builder: (context, log, child) {
                    return IconButton(
                      icon: log.log
                          ? const Icon(Icons.lock, color: Colors.blue)
                          : const Icon(Icons.person, color: Colors.blue),
                      onPressed: () async {
                        if (log.log) {
                          if (await Model.sharedInstance.logOut()) {
                            log.LogOut();
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    backgroundColor: Colors.lightBlue.shade200,
                                    title: const Text(
                                      'LogOut',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    content: const Text(
                                      'LogOut effettuato. A presto!',
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
                            });
                          }
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Loginpage()),
                          );
                        }
                      },
                    );
                  },
                ),
                Builder(
                  builder: (context) => IconButton(
                    icon: Icon(Icons.shopping_cart, color: Colors.blue),
                    onPressed: () {
                      Scaffold.of(context).openEndDrawer();
                    },
                  ),
                ),
              ],
            ),

            Expanded(
              child: CatalogoPage(),
            ),
          ],
        ),
      ),
    );
  }
}
