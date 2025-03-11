import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter_application_2/components/background.dart';
import 'package:flutter_application_2/components/bird.dart';
import 'package:flutter_application_2/components/ground.dart';
import 'package:flutter_application_2/components/pipe_group.dart';
import 'package:flutter_application_2/game/configuration.dart';

class FlappyBirdGame extends FlameGame with TapDetector, HasCollisionDetection {
  late Bird bird;
  Timer interval = Timer(Config.pipeInterval, repeat: true);
  bool isHit = false;
  late TextComponent score;

  @override
  Future<void> onLoad() async {
    addAll(
      [
        Background(),
        Ground(),
        bird = Bird(),
        PipeGroup(),
        score = buildScore(),
      ],
    );

    interval.onTick = () => add(PipeGroup());
  }

  TextComponent buildScore() {
    return TextComponent(
      text: 'Score : 0',
      position: Vector2(
        size.x / 2,
        size.y / 2 * 0.2,
      ),
      anchor: Anchor.center,
    );
  }

  @override
  void onTap() {
    super.onTap();
    bird.fly();
  }

  @override
  void update(double dt) {
    super.update(dt);
    interval.update(dt);
    score.text = 'Score : ${bird.score}';
  }
}
