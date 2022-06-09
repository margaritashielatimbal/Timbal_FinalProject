// ignore_for_file: prefer_const_constructors
import 'dart:math';
import 'package:flutter/services.dart';
import 'Widgets.dart';
import 'package:flutter/material.dart';
import 'game.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: mainMenu(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class mainMenu extends StatelessWidget {
  const mainMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/img/bg.png"), fit: BoxFit.cover),
      ),
      child: Column(
        children: [
          Container(
              height: 270,
              width: 2700,
              child: Image.asset("assets/img/logo.png", fit: BoxFit.contain)),
          TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FinalProject()));
              },
              child: Text(
                "Play",
                style: TextStyle(fontSize: 40),
              )),
          SizedBox(
            height: 30,
          ),
          TextButton(
              onPressed: () => SystemNavigator.pop(),
              child: Text(
                "Quit",
                style: TextStyle(fontSize: 40),
              )),
        ],
      ),
    );
  }
}

class FinalProject extends StatefulWidget {
  const FinalProject({Key? key}) : super(key: key);

  @override
  State<FinalProject> createState() => _FinalProjectState();
}

class _FinalProjectState extends State<FinalProject> {
  void GameLogic() {
    if (answer == ">=") {
      if (cardsEquivalent[guessCard]! >= cardsEquivalent[Deck[0]]!) {
        correctShow();
      } else {
        gameOverShow();
      }
    } else if (answer == "<") {
      if (cardsEquivalent[guessCard]! < cardsEquivalent[Deck[0]]!) {
        correctShow();
      } else {
        gameOverShow();
      }
    }
  }

  void guessIsCorrect() {
    score++;
    answer = "";
    Deck.insert(0, guessCard);
    guessNumberCard = Random().nextInt(52) + 1;
    guessCard = "assets/img/$guessNumberCard.png";
  }

  void gameReset() {
    score = 0;
    answer = "";
    firstCard = Random().nextInt(52) + 1;
    Deck = [
      "assets/img/$firstCard.png",
      backCard,
      backCard,
      backCard,
      backCard
    ];
  }

  void gameOverShow() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
              title: Image.asset(
                "assets/img/gameover.png",
                fit: BoxFit.cover,
                height: 100,
                width: 100,
              ),
              content: Text(
                textAlign: TextAlign.center,
                "Wrong!",
                style: TextStyle(fontSize: 25),
              ),
              actionsAlignment: MainAxisAlignment.center,
              actions: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      Navigator.of(context).pop(false);
                      gameReset();
                      isBack = true;
                    });
                  },
                  child: Text("Play Again", style: TextStyle(fontSize: 18)),
                ),
                SizedBox(width: 20),
                GestureDetector(
                  onTap: () {
                    SystemNavigator.pop();
                  },
                  child: Text(
                    "Quit",
                    style: TextStyle(fontSize: 18),
                  ),
                )
              ],
            ));
  }

  void correctShow() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
              title: Image.asset(
                "assets/img/check.png",
                height: 100,
                width: 100,
              ),
              content: Text(
                textAlign: TextAlign.center,
                "You guess it right! ",
                style: TextStyle(fontSize: 20),
              ),
              actionsAlignment: MainAxisAlignment.center,
              actions: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      guessIsCorrect();
                      Navigator.of(context).pop(false);
                      isBack = true;
                    });
                  },
                  child: Text(
                    "Proceed",
                    style: TextStyle(fontSize: 15),
                  ),
                )
              ],
            ));
  }

  void errorSubmitCheck() {
    if (answer == "") {
      isBack = true;
    } else {
      isBack = false;
      GameLogic();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: SafeArea(
          child: Drawer(
            child: Container(
              color: Color.fromARGB(255, 163, 206, 241),
              child: ListView(
                children: [
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          Navigator.of(context).pop(false);
                          gameReset();
                        });
                      },
                      child: drawerMenuItem("New Game", Icons.refresh)),
                  GestureDetector(
                      onTap: () {
                        SystemNavigator.pop();
                      },
                      child: drawerMenuItem("Quit", Icons.exit_to_app))
                ],
              ),
            ),
          ),
        ),
        backgroundColor: Colors.green[900],
        appBar: AppBar(
          title: Text('High Low Card Game'),
          backgroundColor: Colors.green[900],
        ),
        body: OrientationBuilder(
            builder: ((context, orientation) =>
                orientation == Orientation.portrait
                    ? buildPortrait(context)
                    : buildLandscape(context))));
  }

  Widget buildPortrait(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text('Score: ', style: scoreStyle),
            Text(
              '$score',
              style: scoreStyle,
            ),
          ]),
        ),
        Expanded(
          flex: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TopCards(size.height * .2, size.width * .2, Deck[1]),
              TopCards(size.height * .2, size.width * .2, Deck[2]),
              TopCards(size.height * .2, size.width * .2, Deck[3]),
              TopCards(size.height * .2, size.width * .2, Deck[4]),
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MiddleCard(size.height * .2, size.width * .2),
              SizedBox(width: 20),
              miniBox(),
              SizedBox(width: 20),
              TopCards(size.height * .2, size.width * .2, Deck[0]),
            ],
          ),
        ),
        Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                    onTap: () {
                      setState(() {
                        answer = ">=";
                      });
                    },
                    child: Buttons(size.height * .1, size.width * .3,
                        "Greater than or Equal")),
                GestureDetector(
                    onTap: () {
                      setState(() {
                        errorSubmitCheck();
                      });
                    },
                    child:
                        Buttons(size.height * .1, size.width * .3, "SUBMIT")),
                GestureDetector(
                    onTap: () {
                      setState(() {
                        answer = "<";
                      });
                    },
                    child: Buttons(
                        size.height * .1, size.width * .3, "Less than")),
              ],
            )),
      ],
    );
  }

  Widget buildLandscape(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Score: ",
                style: scoreStyle,
              ),
              Text(
                "0",
                style: scoreStyle,
              )
            ],
          ),
        ),
        Expanded(
          flex: 4,
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TopCards(size.height * .3, size.width * .1, Deck[1]),
                        TopCards(size.height * .3, size.width * .1, Deck[2]),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TopCards(size.height * .3, size.width * .1, Deck[3]),
                        TopCards(size.height * .3, size.width * .1, Deck[4]),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    MiddleCard(size.height * .3, size.width * .2),
                    SizedBox(width: 20),
                    miniBox(),
                    SizedBox(width: 20),
                    TopCards(size.height * .3, size.width * .2, Deck[0]),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            answer = ">=";
                          });
                        },
                        child: Buttons(size.height * .2, size.width * .1,
                            "Greater than or Equal"),
                      ),
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              errorSubmitCheck();
                            });
                          },
                          child: Buttons(
                              size.height * .2, size.width * .1, "SUBMIT")),
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              answer = "<";
                            });
                          },
                          child: Buttons(
                              size.height * .2, size.width * .1, "Less than")),
                    ]),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
