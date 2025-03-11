import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/components/pipe.dart';
import 'package:flutter_application_2/game/assets.dart';
import 'package:flutter_application_2/game/configuration.dart';
import 'package:flutter_application_2/game/flappy_bird_game.dart';
import 'package:flutter_application_2/game/pipe_position.dart';

class PipeGroup extends PositionComponent with HasGameRef<FlappyBirdGame> {
  PipeGroup();

  final _random = Random();

  @override
  Future<void> onLoad() async {
    position.x = gameRef.size.x;
    final heightMinusGround = gameRef.size.y - Config.groundHeight;
    final spacing = 100 + _random.nextDouble() * (heightMinusGround / 4);

    // Ensure centerY is within valid range
    final centerY =
        spacing + _random.nextDouble() * (heightMinusGround - spacing * 2);

    final topPipeHeight = centerY - spacing / 2;
    final bottomPipeHeight = heightMinusGround - (centerY + spacing / 2);

    addAll(
      [
        Pipe(pipePosition: PipePosition.top, height: topPipeHeight),
        Pipe(pipePosition: PipePosition.bottom, height: bottomPipeHeight)
      ],
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.x -= Config.gameSpeed * dt;

    if (position.x < 10) {
      removeFromParent();
      debugPrint('Removed');
      updateScore();
    }
    if (gameRef.isHit) {
      removeFromParent();
      game.isHit = false;
    }
  }

  void updateScore() {
    gameRef.bird.score += 1;
    FlameAudio.play(Assets.point);
  }
}
