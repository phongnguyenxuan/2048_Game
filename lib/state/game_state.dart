import 'package:get/get.dart';

class GameState {
  //create grid 4 x 4
  RxList<List<int>> board =
      List.generate(4, (i) => List.generate(4, (j) => 0)).obs;

  RxBool isGameOver = false.obs;
}
