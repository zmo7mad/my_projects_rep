import 'dart:ffi';

import 'package:flutter/material.dart';

class GameLogic {
  String secretWord = '';
  Set <String> guessedLetters = {};
  int attemptsLeft = 6;

  void startGame(String word)
  {
    secretWord = word.toLowerCase();
    guessedLetters.clear();
    attemptsLeft=6;
  }
  bool guessLetter (String letter)
  {
    guessedLetters.add(letter.toLowerCase());

    if(!secretWord.contains(letter.toLowerCase()))
    {
      attemptsLeft--;
      return false;
    }
    return true;
  }
  String getDisplayedWord()
  {
    return secretWord.split('').map((letter){
      return guessedLetters.contains(letter) ? letter : '_';
    }
    ).join(' ');
  }
  bool isGameWon(){
    return secretWord.split('')
    .every((letter) => guessedLetters.contains(letter));
  }
  bool isGamelost() {
    return attemptsLeft <= 0;
  }
}