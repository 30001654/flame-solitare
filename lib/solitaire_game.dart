import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';

import 'common/constants/global_constants.dart';
import 'components/foundation.dart';
import 'components/pile.dart';
import 'components/stock.dart';
import 'components/waste.dart';

class SolitaireGame extends FlameGame {
  @override
  Future<void> onLoad() async {
    await Flame.images.load('klondike-sprites.png');

    final Stock stock = Stock()
      ..size = cardSize
      ..position = Vector2(cardGap, cardGap);
    final Waste waste = Waste()
      ..size = cardSize
      ..position = Vector2(cardWidth + (2 * cardGap), cardGap);
    final List<Foundation> foundations = _generateFoundations(4);
    final List<Pile> piles = _generatePiles(7);

    world.addAll([stock, waste, ...foundations, ...piles]);
    camera.viewfinder.visibleGameSize = Vector2(
      (cardWidth * 7) + (cardGap * 8),
      (4 * cardHeight) + (3 * cardGap),
    );
    camera.viewfinder.position = Vector2(
      (cardWidth * 3.5) + (cardGap * 4),
      0,
    );
    camera.viewfinder.anchor = Anchor.topCenter;
  }
}

List<Foundation> _generateFoundations(int count) {
  return List.generate(
    count,
    (i) {
      return Foundation()
        ..size = cardSize
        ..position = Vector2(
          (i + 3) * (cardWidth + cardGap) + cardGap,
          cardGap,
        );
    },
  );
}

List<Pile> _generatePiles(int count) {
  return List.generate(
    count,
    (i) {
      return Pile()
        ..size = cardSize
        ..position = Vector2(
          cardGap + i * (cardWidth + cardGap),
          cardHeight + 2 * cardGap,
        );
    },
  );
}

Sprite solitaireSprite(double x, double y, double width, double height) {
  return Sprite(
    Flame.images.fromCache('klondike_sprites.png'),
    srcPosition: Vector2(x, y),
    srcSize: Vector2(width, height),
  );
}
