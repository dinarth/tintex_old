import 'package:tintex/login_screen.dart';
import 'package:tintex/model/Usuario.dart';
import 'package:tintex/tiles/drawer_tile.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class CustomDrawer extends StatelessWidget {
  final PageController pageController;

  CustomDrawer(this.pageController);

  @override
  Widget build(BuildContext context) {
    Widget _buildDrawerBack() => Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.white, Color.fromARGB(255, 203, 236, 241)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
        );

    return Drawer(
      child: Stack(
        children: <Widget>[
          _buildDrawerBack(),
          ListView(
            padding: EdgeInsets.only(left: 30.0, top: 16.0),
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 8.0),
                padding: EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 8.0),
                height: 170.0,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 2.0,
                      left: 0.0,
                      child: Image.asset(
                        "assets/logo.PNG",
                        height: 40,
                        width: 120,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    Positioned(
                        left: 0.0,
                        bottom: 0.0,
                        child: ScopedModelDescendant<Usuario>(
                          builder: (context, child, model) {
                            //print(model.userData['nome']);
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Olá, ${!model.isLoggedIn() ? "" : model.userData["nome"]}",
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                GestureDetector(
                                  child: Text(
                                    !model.isLoggedIn()
                                        ? "Entre ou cadastre-se >"
                                        : "Sair",
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  onTap: () {
                                    if (!model.isLoggedIn()) {
                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginScreen()));
                                    } else {
                                      model.signOut();
                                      Navigator.of(context).pop();
                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginScreen()));
                                    }
                                  },
                                )
                              ],
                            );
                          },
                        ))
                  ],
                ),
              ),
              Divider(),
              DrawerTile(Icons.list, "Listar Pedidos", pageController, 0),
              DrawerTile(Icons.add, "Realizar Pedido", pageController, 1),
            ],
          )
        ],
      ),
    );
  }
}
