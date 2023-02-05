import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isX = true;
  List<String> displaySign = ['', '', '', '', '', '', '', '', ''];
  int userXScore = 0;
  int userOScore = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF181D31),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  'Tic Tac Toe',
                  style: GoogleFonts.audiowide(
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 50,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color.fromARGB(255, 8, 11, 24),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Player X',
                              style: GoogleFonts.audiowide(
                                textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              '$userXScore',
                              style: GoogleFonts.audiowide(
                                textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color.fromARGB(255, 8, 11, 24),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Player O',
                                style: GoogleFonts.audiowide(
                                  textStyle: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                )),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              '$userOScore',
                              style: GoogleFonts.audiowide(
                                textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: GridView.builder(
                itemCount: 9,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  crossAxisCount: 3,
                ),
                itemBuilder: ((context, index) => GestureDetector(
                      onTap: () {
                        placeSign(index);
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                          border: Border.symmetric(
                            horizontal: BorderSide(
                              color: Colors.white,
                              width: 2,
                            ),
                            vertical: BorderSide(
                              color: Colors.white,
                              width: 2,
                            ),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            displaySign[index],
                            style: GoogleFonts.audiowide(
                              textStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 50,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }

// Place sign on the grid
  void placeSign(int index) {
    setState(() {
      if (isX && displaySign[index] == '') {
        displaySign[index] = 'X';
        isX = !isX;
      } else if (!isX && displaySign[index] == '') {
        displaySign[index] = 'O';
        isX = !isX;
      }
    });
    checkWinner();
  }

  // Check for winner
  void checkWinner() {
    // check rows
    if (displaySign[0] == displaySign[1] &&
        displaySign[0] == displaySign[2] &&
        displaySign[0] != '') {
      showWinner(displaySign[0]);
    }

    if (displaySign[3] == displaySign[4] &&
        displaySign[3] == displaySign[5] &&
        displaySign[3] != '') {
      showWinner(displaySign[3]);
    }

    if (displaySign[6] == displaySign[7] &&
        displaySign[6] == displaySign[8] &&
        displaySign[6] != '') {
      showWinner(displaySign[6]);
    }

    // check columns
    if (displaySign[0] == displaySign[3] &&
        displaySign[0] == displaySign[6] &&
        displaySign[0] != '') {
      showWinner(displaySign[0]);
    }

    if (displaySign[1] == displaySign[4] &&
        displaySign[1] == displaySign[7] &&
        displaySign[1] != '') {
      showWinner(displaySign[1]);
    }

    if (displaySign[2] == displaySign[5] &&
        displaySign[2] == displaySign[8] &&
        displaySign[2] != '') {
      showWinner(displaySign[2]);
    }

    // check diagonals
    if (displaySign[0] == displaySign[4] &&
        displaySign[0] == displaySign[8] &&
        displaySign[0] != '') {
      showWinner(displaySign[0]);
    }

    if (displaySign[2] == displaySign[4] &&
        displaySign[2] == displaySign[6] &&
        displaySign[2] != '') {
      showWinner(displaySign[2]);
    }

    // check draw
    if (!displaySign.contains('')) {
      showDraw();
    }
  }

// Reset game
  void resetGame() {
    setState(() {
      displaySign = ['', '', '', '', '', '', '', '', ''];
    });
  }

// Show winner Dialog
  void showWinner(String winner) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Winner'),
        content: Text('Player $winner won the game'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              resetGame();
            },
            child: const Text('Reset Game'),
          )
        ],
      ),
    );
    if (winner == 'X') {
      userXScore++;
    } else {
      userOScore++;
    }
  }

// Show draw Dialog
  void showDraw() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Draw'),
        content: const Text('Game is draw'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              resetGame();
            },
            child: const Text('Reset Game'),
          )
        ],
      ),
    );
  }
}
