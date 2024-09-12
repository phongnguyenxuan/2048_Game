import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:number_game/state/game_state.dart';

class GameLogic extends GetxController {
  final GameState state = GameState();
  Random rng = Random();

  @override
  void onInit() {
    super.onInit();
    resetBoard();
  }

  void resetBoard() {
    state.board.value = List.generate(4, (i) => List.generate(4, (j) => 0));
    addNewTile();
    addNewTile();
  }

  void addNewTile() {
    List<Point<int>> empty = [];
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        if (state.board[i][j] == 0) {
          empty.add(Point(i, j));
        }
      }
    }
    if (empty.isNotEmpty) {
      Point<int> selected = empty[rng.nextInt(empty.length)];
      state.board[selected.x][selected.y] = rng.nextInt(100) < 90 ? 2 : 4;
    }
    canMove();
  }

  void swipeLeft() {
    for (int i = 0; i < 4; i++) {
      List<int> newRow = mergeRow(state.board[i]);
      state.board[i] = newRow;
    }
    addNewTile();
    state.board.refresh();
  }

  void swipeRight() {
    for (int i = 0; i < 4; i++) {
      List<int> reversedRow = state.board[i].reversed.toList();
      List<int> newRow = mergeRow(reversedRow).reversed.toList();
      state.board[i] = newRow;
    }
    addNewTile();
    state.board.refresh();
  }

  void swipeUp() {
    for (int j = 0; j < 4; j++) {
      List<int> column = [];
      for (int i = 0; i < 4; i++) {
        column.add(state.board[i][j]);
      }
      List<int> newColumn = mergeRow(column);
      for (int i = 0; i < 4; i++) {
        state.board[i][j] = newColumn[i];
      }
    }
    addNewTile();
    state.board.refresh();
  }

  void swipeDown() {
    for (int j = 0; j < 4; j++) {
      List<int> column = [];
      for (int i = 0; i < 4; i++) {
        column.add(state.board[i][j]);
      }
      List<int> newColumn =
          mergeRow(column.reversed.toList()).reversed.toList();
      for (int i = 0; i < 4; i++) {
        state.board[i][j] = newColumn[i];
      }
    }
    addNewTile();
    state.board.refresh();
  }

  List<int> mergeRow(List<int> row) {
    List<int> newRow = row.where((val) => val != 0).toList();
    for (int i = 0; i < newRow.length - 1; i++) {
      if (newRow[i] == newRow[i + 1]) {
        newRow[i] *= 2;
        newRow[i + 1] = 0;
      }
    }
    newRow = newRow.where((val) => val != 0).toList();
    while (newRow.length < 4) {
      newRow.add(0);
    }
    return newRow;
  }

  bool canMove() {
    // Kiểm tra còn ô trống
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        if (state.board[i][j] == 0) {
          state.isGameOver.value = false;
          return true;
        }
      }
    }

    // Kiểm tra có thể kết hợp các ô
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 3; j++) {
        if (state.board[i][j] == state.board[i][j + 1]) {
          state.isGameOver.value = false;
          return true;
        }
      }
    }

    for (int j = 0; j < 4; j++) {
      for (int i = 0; i < 3; i++) {
        if (state.board[i][j] == state.board[i + 1][j]) {
          state.isGameOver.value = false;
          return true;
        }
      }
    }
    state.isGameOver.value = true;
    Get.dialog(Material(
      type: MaterialType.transparency,
      child: Container(
        width: 200,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('GAME OVER'),
            ElevatedButton(
                onPressed: () {
                  resetBoard();
                  Get.back();
                },
                child: const Text('Restart'))
          ],
        ),
      ),
    ));
    return false;
  }
}
