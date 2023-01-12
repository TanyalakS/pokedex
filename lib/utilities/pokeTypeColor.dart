import 'package:flutter/material.dart';

typeColor({required String type}) {
    switch (type) {
      case 'fire':
        return Colors.red;
      case 'flying':
        return Colors.blue.shade200;
      case 'grass':
        return Colors.green.shade600;
      case 'normal':
        return Colors.grey.shade500;
      case 'ground':
        return const Color.fromRGBO(187, 173, 98, 1);
      case 'rock':
        return Colors.brown;
      case 'ice':
        return Colors.blueAccent.shade100;
      case 'ghost':
        return Colors.purple.shade800;
      case 'water':
        return Colors.blue.shade500;
      case 'fighting':
        return Colors.deepOrange.shade900;
      case 'psychic':
        return Colors.pinkAccent;
      case 'dragon':
        return Colors.indigo.shade400;
      case 'electric':
        return Colors.yellow.shade700;
      case 'poison':
        return Colors.purpleAccent.shade700;
      case 'bug':
        return Colors.lightGreen.shade500;
      case 'dark':
        return Colors.brown.shade900;
      case 'steel':
        return Colors.blueGrey.shade500;
      case 'fairy':
        return Colors.pink.shade200;
    }
  }