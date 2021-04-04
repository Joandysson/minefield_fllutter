import 'package:flutter/foundation.dart';
import 'dart:math';
import 'field.dart';

class Board {
  final int lines;
  final int columns;
  final int qtyOfPumps;

  final List<Field> _fields = [];

  Board({
    @required this.lines,
    @required this.columns,
    @required this.qtyOfPumps,
  }) {
    _createFields();
    _relateneighbors();
    _drawMinas();
  }

  void restart() {
    _fields.forEach((f) => f.restart());
    _drawMinas();
  }

  void revealBombs() {
    _fields.forEach((f) => f.revealBomb());
  }

  void _createFields() {
    for (int l = 0; l < lines; l++) {
      for (int c = 0; c < columns; c++) {
        _fields.add(Field(line: l, column: c));
      }
    }
  }

  void _relateneighbors() {
    for (var field in _fields) {
      for (var neighbor in _fields) {
        field.addNeighbor(neighbor);
      }
    }
  }

  void _drawMinas() {
    int sorteadas = 0;

    if (qtyOfPumps > lines * columns) {
      return;
    }

    while (sorteadas < qtyOfPumps) {
      int i = Random().nextInt(_fields.length);

      if (!_fields[i].minado) {
        sorteadas++;
        _fields[i].minar();
      }
    }
  }

  List<Field> get fields {
    return _fields;
  }

  bool get resolved {
    return _fields.every((f) => f.resolved);
  }
}
