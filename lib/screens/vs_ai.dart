import 'dart:math';
import 'package:flutter/material.dart';

class TicTacToeAiScreen extends StatefulWidget {
  @override
  _TicTacToeScreenState createState() => _TicTacToeScreenState();
}

class _TicTacToeScreenState extends State<TicTacToeAiScreen> {
  List<String> board = List.filled(9, '');
  bool isPlayer1Turn = true; // Player 1 starts
  bool gameFinished = false;

  void makeMove(int index) {
    if (!gameFinished && board[index] == '') {
      setState(() {
        board[index] = isPlayer1Turn ? 'X' : 'O';
        isPlayer1Turn = !isPlayer1Turn;
      });
      checkWinner();
      if (!isPlayer1Turn && !gameFinished) {
        // AI's turn
        int aiMove = getBestMove();
        makeMove(aiMove);
      }
    }
  }

  int getBestMove() {
    int bestScore = -1000;
    int bestMove = -1;
    for (int i = 0; i < 9; i++) {
      if (board[i] == '') {
        board[i] = 'O';
        int score = minimax(board, 0, false);
        board[i] = '';
        if (score > bestScore) {
          bestScore = score;
          bestMove = i;
        }
      }
    }
    return bestMove;
  }

  int minimax(List<String> board, int depth, bool isMaximizing) {
    int score = evaluate(board);
    if (score == 10) return score;
    if (score == -10) return score;
    if (!board.contains('')) return 0;

    if (isMaximizing) {
      int bestScore = -1000;
      for (int i = 0; i < 9; i++) {
        if (board[i] == '') {
          board[i] = 'O';
          bestScore = max(bestScore, minimax(board, depth + 1, !isMaximizing));
          board[i] = '';
        }
      }
      return bestScore;
    } else {
      int bestScore = 1000;
      for (int i = 0; i < 9; i++) {
        if (board[i] == '') {
          board[i] = 'X';
          bestScore = min(bestScore, minimax(board, depth + 1, !isMaximizing));
          board[i] = '';
        }
      }
      return bestScore;
    }
  }

  int evaluate(List<String> board) {
    // Check rows, columns, and diagonals for a win
    for (int i = 0; i < 3; i++) {
      if (board[i * 3] == board[i * 3 + 1] &&
          board[i * 3] == board[i * 3 + 2]) {
        if (board[i * 3] == 'O') return 10;
        if (board[i * 3] == 'X') return -10;
      }
      if (board[i] == board[i + 3] && board[i] == board[i + 6]) {
        if (board[i] == 'O') return 10;
        if (board[i] == 'X') return -10;
      }
    }
    if (board[0] == board[4] && board[0] == board[8]) {
      if (board[0] == 'O') return 10;
      if (board[0] == 'X') return -10;
    }
    if (board[2] == board[4] && board[2] == board[6]) {
      if (board[2] == 'O') return 10;
      if (board[2] == 'X') return -10;
    }
    return 0; // No winner yet
  }

  void checkWinner() {
    for (int i = 0; i < 3; i++) {
      if (board[i * 3] == board[i * 3 + 1] &&
          board[i * 3] == board[i * 3 + 2] &&
          board[i * 3] != '') {
        showWinnerDialog(board[i * 3]);
        return;
      }
      if (board[i] == board[i + 3] &&
          board[i] == board[i + 6] &&
          board[i] != '') {
        showWinnerDialog(board[i]);
        return;
      }
    }
    if (board[0] == board[4] && board[0] == board[8] && board[0] != '') {
      showWinnerDialog(board[0]);
      return;
    }
    if (board[2] == board[4] && board[2] == board[6] && board[2] != '') {
      showWinnerDialog(board[2]);
      return;
    }
    if (!board.contains('')) {
      showDrawDialog();
    }
  }

  void showWinnerDialog(String winner) {
    setState(() {
      gameFinished = true;
    });
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Game Over'),
        content: Text('$winner wins!'),
        actions: [
          TextButton(
            onPressed: () {
              resetGame();
              Navigator.of(context).pop();
            },
            child: Text('Play Again'),
          ),
        ],
      ),
    );
  }

  void showDrawDialog() {
    setState(() {
      gameFinished = true;
    });
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Game Over'),
        content: Text('It\'s a draw!'),
        actions: [
          TextButton(
            onPressed: () {
              resetGame();
              Navigator.of(context).pop();
            },
            child: Text('Play Again'),
          ),
        ],
      ),
    );
  }

  void resetGame() {
    setState(() {
      board = List.filled(9, '');
      isPlayer1Turn = true;
      gameFinished = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Tic Tac Toe with ai'),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    makeMove(index);
                  },
                  child: Container(

                    decoration: BoxDecoration(
                      border: Border.all(),
                    ),
                    child: Center(
                      child: Text(
                        board[index],
                        style: TextStyle(fontSize: 40),
                      ),
                    ),
                  ),
                );
              },
              itemCount: 9,
              shrinkWrap: true,
            ),
            if (gameFinished)
              ElevatedButton(
                onPressed: resetGame,
                child: Text('Restart Game'),
              ),
          ],
        ),
      ),
    );
  }
}