import 'package:flutter/material.dart';
import 'package:hangmanapp/api_service.dart';
import 'package:hangmanapp/game_logic.dart';

class HomeScreen extends StatefulWidget {
   HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
    final gameLogic = GameLogic();
    final apiService = ApiService(); 
    bool isLoading = true;
      @override
  void initState() {
    super.initState();
    _startGame();
  }
  Future<void> _startGame() async {
    try {
      String word = await apiService.fetchRandomWords();
      print('fetched word : $word');
      setState(() {
        gameLogic.startGame(word);
        isLoading = false;
      });
    }catch (e) {
      print('error fetching word : $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('the hangman game baby'),
        backgroundColor: Colors.orange,
      ),
      body: Column(
        children: [
          Image.asset('assets/stages/stage${6 - gameLogic.attemptsLeft}.png',
          height: 200,
          width: 600,),
          SizedBox(height: 22,),
          Text(
            gameLogic.getDisplayedWord(),
            style: TextStyle(fontSize: 32 , letterSpacing: 4),

          ),
          SizedBox(height: 22,),
          Text('attempts left : ${gameLogic.attemptsLeft}',
          
          style: TextStyle(fontSize: 15),),
          SizedBox(height: 22,),
        
          Padding(
          padding:EdgeInsets.only(left: 22),

          child: 
          Wrap(
            spacing: 8,
            runSpacing: 8,
             alignment: WrapAlignment.center,
             crossAxisAlignment: WrapCrossAlignment.center,
             
             children: 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.split('').map((letter) {
              bool guessedLetters = gameLogic.guessedLetters.contains(letter.toLowerCase());
             return ElevatedButton(
              onPressed: guessedLetters ? null : () {
              setState(() {
                 gameLogic.guessLetter(letter);
                 });
                 },
               child: Text(letter),  
               );
           }).toList(),)
          )    
            ]
      
      )
    );
  
      



    
  }


}