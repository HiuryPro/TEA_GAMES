import 'package:flutter/material.dart';

class JogoPareamento extends StatefulWidget {
  const JogoPareamento({super.key, required this.title});
  final String title;

  @override
  State<JogoPareamento> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<JogoPareamento> {
  int _counter = 0;
  List cartas = [
    "assets/frutas/abacate.png",
    "assets/frutas/abacate.png",
    "assets/frutas/abacaxi.png",
    "assets/frutas/abacaxi.png",
    "assets/frutas/acerola.png",
    "assets/frutas/acerola.png",
    "assets/frutas/banana.png",
    "assets/frutas/banana.png",
    "assets/frutas/blueberry.png",
    "assets/frutas/blueberry.png",
    "assets/frutas/cereja.png",
    "assets/frutas/cereja.png",
    "assets/frutas/kiwi.png",
    "assets/frutas/kiwi.png",
    "assets/frutas/laranja.png",
    "assets/frutas/laranja.png",
    "assets/frutas/limao.png",
    "assets/frutas/limao.png",
    "assets/frutas/melancia.png",
    "assets/frutas/melancia.png",
    "assets/frutas/morango.png",
    "assets/frutas/morango.png",
    "assets/frutas/pera.png",
    "assets/frutas/pera.png",
    "assets/frutas/pessego.png",
    "assets/frutas/pessego.png",
    "assets/frutas/roma.png",
    "assets/frutas/roma.png",
    "assets/frutas/uva.png",
    "assets/frutas/uva.png",
  ];

  List<Color?> listaColor = [
    null,
    null,
    null,
    null,
    null,
    null,
    null,
    null,
    null,
    null,
    null,
    null,
  ];
  @override
  void initState() {
    super.initState();
    cartas.shuffle();
    listaColor = List.filled(cartas.length, null);
  }

  int primeiraCartaSelecionada = -1;
  int segundaCartaSelecionada = -1;

  void verificarPareamento(int index) async {
    if (primeiraCartaSelecionada == -1) {
      primeiraCartaSelecionada = index;
      setState(() {
        listaColor[primeiraCartaSelecionada] = Colors.green;
      });
    } else if (segundaCartaSelecionada == -1) {
      segundaCartaSelecionada = index;
      if (cartas[primeiraCartaSelecionada] == cartas[segundaCartaSelecionada]) {
        print('Pareou');
        setState(() {
          listaColor[segundaCartaSelecionada] = Colors.green;
        });
      } else {
        print('Burro');
        listaColor[segundaCartaSelecionada] = Colors.red;
        listaColor[primeiraCartaSelecionada] = Colors.red;
        await Future.delayed(Duration(seconds: 2));

        setState(() {
          listaColor[segundaCartaSelecionada] = null;
          listaColor[primeiraCartaSelecionada] = null;
        });
      }
      primeiraCartaSelecionada = -1;
      segundaCartaSelecionada = -1;
    }
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  Future<void> piscaImagens() async {
    setState(() {
      listaColor = List.filled(cartas.length, null);
    });
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      listaColor = List.filled(cartas.length, Colors.green);
    });
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      listaColor = List.filled(cartas.length, null);
    });
  }

  Widget body() {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    itemCount: cartas.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 10),
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () async {
                          if (primeiraCartaSelecionada == -1 ||
                              segundaCartaSelecionada == -1) {
                            if (listaColor[index] == null) {
                              verificarPareamento(index);
                              setState(() {});
                            }

                            if (!listaColor.contains(null)) {
                              for (var i = 0; i < 3; i++) {
                                await piscaImagens();
                              }

                              await Future.delayed(const Duration(seconds: 1));
                              setState(() {
                                listaColor = List.filled(cartas.length, null);
                                cartas.shuffle();
                              });
                            }
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: listaColor[index],
                          ),
                          child: Center(
                            child: IconButton(
                              iconSize: 70,
                              icon: Image.asset(cartas[index]),
                              onPressed: null,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: body(),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
