import 'package:flutter/material.dart';


class TicTacToePersonScreen extends StatefulWidget {
  @override
  _TicTacToeScreenState createState() => _TicTacToeScreenState();
}

class _TicTacToeScreenState extends State<TicTacToePersonScreen> {
  late List<List<String>> _board;
  late String _currentPlayer;
  late bool _gameOver;

  @override
  void initState() {
    super.initState();
    _initializeBoard();
  }

  void _initializeBoard() {
    _board = List.generate(3, (i) => List.generate(3, (j) => ''));
    _currentPlayer = 'X';
    _gameOver = false;
  }

  void _resetGame() {
    setState(() {
      _initializeBoard();
    });
  }

  void _makeMove(int row, int col) {
    if (!_gameOver && _board[row][col].isEmpty) {
      setState(() {
        _board[row][col] = _currentPlayer;
        _checkWinner(row, col);
        _togglePlayer();
      });
    }
  }

  void _checkWinner(int row, int col) {
    // Check row
    if (_board[row][0] == _currentPlayer &&
        _board[row][1] == _currentPlayer &&
        _board[row][2] == _currentPlayer) {
      _gameOver = true;
      _showWinnerDialog();
    }
    // Check column
    else if (_board[0][col] == _currentPlayer &&
        _board[1][col] == _currentPlayer &&
        _board[2][col] == _currentPlayer) {
      _gameOver = true;
      _showWinnerDialog();
    }
    // Check diagonals
    else if ((row == col ||
        (row + col == 2)) &&
        ((_board[0][0] == _currentPlayer &&
            _board[1][1] == _currentPlayer &&
            _board[2][2] == _currentPlayer) ||
            (_board[0][2] == _currentPlayer &&
                _board[1][1] == _currentPlayer &&
                _board[2][0] == _currentPlayer))) {
      _gameOver = true;
      _showWinnerDialog();
    }
    // Check for a draw
    else if (!_board.any((row) => row.any((cell) => cell.isEmpty))) {
      _gameOver = true;
      _showDrawDialog();
    }
  }

  void _togglePlayer() {
    _currentPlayer = (_currentPlayer == 'X') ? 'O' : 'X';
  }

  void _showWinnerDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Winner!'),
          content: Text('Player $_currentPlayer wins!'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _resetGame();
              },
              child: Text('Play Again'),
            ),
          ],
        );
      },
    );
  }

  void _showDrawDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Draw!'),
          content: Text('The game ends in a draw.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _resetGame();
              },
              child: Text('Play Again'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: const Text('Tic Tac Toe with Friend'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < 3; i++)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  for (int j = 0; j < 3; j++)
                    GestureDetector(
                      onTap: () => _makeMove(i, j),
                      child: Container(
                        width: 110,
                        height: 110,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                        ),
                        child: Center(
                          child: Text(
                            _board[i][j],
                            style: TextStyle(fontSize: 40),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
