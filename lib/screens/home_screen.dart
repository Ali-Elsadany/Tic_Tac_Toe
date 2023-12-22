import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tic_tac_toe/screens/vs_ai.dart';
import 'package:tic_tac_toe/screens/vs_real_person.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              SizedBox(
                height: 100,
              ),
              Image.asset('assets/images/1267357-200.png'),
              SizedBox(
                height: 50,
              ),

                   Container(
                     height: 50,
                     width: 352,
                     child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                        onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>
                                TicTacToePersonScreen()
                            ),
                          );
                        },
                        child: const Text('Play with Friend',style: TextStyle(color: Colors.white,fontSize: 20),)
                  ),
                   ),
              SizedBox(
                height: 20,
              ),
              Container(
                     height: 50,
                     width: 352,
                     child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                        onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>
                                TicTacToeAiScreen()
                            ),
                          );
                        },
                        child: const Text('Play with Ai',style: TextStyle(color: Colors.white,fontSize: 20),)
                  ),
                   ),
              SizedBox(
                height: 20,
              ),
              Container(
                     height: 50,
                     width: 352,
                     child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                        onPressed: (){
                          exit(0);
                        },
                        child: const Text('Quit',style: TextStyle(color: Colors.white,fontSize: 20),)
                  ),
                   ),

            ],
          ),
        ),
      ),
    );
  }
}
