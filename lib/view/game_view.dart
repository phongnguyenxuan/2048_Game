import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:number_game/logic/game_logic.dart';
import 'package:number_game/widget/swipe_widget.dart';

class GameView extends StatefulWidget {
  const GameView({super.key});

  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  final gameLogic = Get.put(GameLogic());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return SwipeWidget(
          onSwipeDown: gameLogic.swipeDown,
          onSwipeLeft: gameLogic.swipeLeft,
          onSwipeRight: gameLogic.swipeRight,
          onSwipeUp: gameLogic.swipeUp,
          child: Scaffold(
            appBar: AppBar(
              title: const Text('2048 Game'),
              actions: [
                IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: gameLogic.resetBoard,
                ),
              ],
            ),
            body: Container(
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: gameLogic.state.board.map((row) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: row.map((tile) {
                      return Container(
                        margin: const EdgeInsets.all(4),
                        width: 64,
                        height: 64,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: getTileColor(tile),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          tile == 0 ? '' : '$tile',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }).toList(),
                  );
                }).toList(),
              ),
            ),
          ),
        );
      },
    );
  }

  Color getTileColor(int value) {
    switch (value) {
      case 2:
        return Colors.yellow[200]!;
      case 4:
        return Colors.orange[200]!;
      case 8:
        return Colors.orange[400]!;
      case 16:
        return Colors.deepOrange[400]!;
      case 32:
        return Colors.red[400]!;
      case 64:
        return Colors.red[600]!;
      case 128:
        return Colors.lightGreen[400]!;
      case 256:
        return Colors.green[400]!;
      case 512:
        return Colors.green[600]!;
      case 1024:
        return Colors.blue[400]!;
      case 2048:
        return Colors.blue[800]!;
      default:
        return Colors.grey[300]!;
    }
  }
}
