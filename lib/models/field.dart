import 'package:flutter/foundation.dart';
import 'explosion_exception.dart';

class Field {
  final int line;
  final int column;
  final List<Field> neighbors = [];

  bool _opened = false;
  bool _marked = false;
  bool _undermined = false;
  bool _exploded = false;

  Field({
    @required this.line,
    @required this.column,
  });

  void addNeighbor(Field neighbor) {
    final deltaLine = (line - neighbor.line).abs();
    final deltaColumn = (column - neighbor.column).abs();

    if (deltaLine == 0 && deltaColumn == 0) {
      return;
    }

    if (deltaLine <= 1 && deltaColumn <= 1) {
      neighbors.add(neighbor);
    }
  }

  void open() {
    if (_opened) {
      return;
    }

    _opened = true;

    if (_undermined) {
      _exploded = true;
      throw ExplosionException();
    }

    if (safeNeighborhood) {
      neighbors.forEach((n) => n.open());
    }
  }

  void revealBomb() {
    if (_undermined) {
      _opened = true;
    }
  }

  void minar() {
    _undermined = true;
  }

  void changeAppointment() {
    _marked = !_marked;
  }

  void restart() {
    _opened = false;
    _marked = false;
    _undermined = false;
    _exploded = false;
  }

  bool get minado {
    return _undermined;
  }

  bool get explodido {
    return _exploded;
  }

  bool get opened {
    return _opened;
  }

  bool get marked {
    return _marked;
  }

  bool get resolved {
    bool minadoEMarcado = minado && marked;
    bool seguroEAberto = !minado && opened;
    return minadoEMarcado || seguroEAberto;
  }

  bool get safeNeighborhood {
    return neighbors.every((n) => !n.minado);
  }

  int get qtyOfMinesNeighborhood {
    return neighbors.where((n) => n.minado).length;
  }
}
