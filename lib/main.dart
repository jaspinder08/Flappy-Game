import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/game/flappy_bird_game.dart';
import 'package:flutter_application_2/screens/game_over_screen.dart';
import 'package:flutter_application_2/screens/main_menu_screen.dart';

void main() {
  final game = FlappyBirdGame();
  runApp(
    GameWidget(
      game: game,
      initialActiveOverlays: const [
        MainMenuScreen.id,
      ],
      overlayBuilderMap: {
        'mainMenu': (context, _) => MainMenuScreen(
              game: game,
            ),
        'gameOver': (context, _) => GameOverScreen(
              game: game,
            )
      },
    ),
  );
}
