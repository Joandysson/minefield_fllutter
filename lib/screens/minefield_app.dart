import 'package:minefield/components/board_widget.dart';
import 'package:minefield/models/board.dart';
import 'package:flutter/material.dart';
import '../components/result_widget.dart';
import '../models/field.dart';
import '../models/explosion_exception.dart';

class MinefieldApp extends StatefulWidget {
  @override
  _MinefieldAppState createState() => _MinefieldAppState();
}

class _MinefieldAppState extends State<MinefieldApp> {
  bool _won;
  Board board;

  void _restart() {
    setState(() {
      _won = null;
      board.restart();
    });
  }

  void _open(Field field) {
    if (_won != null) {
      return;
    }

    setState(() {
      try {
        field.open();
        if (board.resolved) {
          _won = true;
        }
      } on ExplosionException {
        _won = false;
        board.revealBombs();
      }
    });
  }

  void _changeAppointment(Field field) {
    if (_won != null) {
      return;
    }

    setState(() {
      field.changeAppointment();
      if (board.resolved) {
        _won = true;
      }
    });
  }

  Board _getBoard(double width, double height) {
    if (board == null) {
      int qtyOfColumns = 15;
      double sizeField = width / qtyOfColumns;
      int qtyOfLines = (height / sizeField).floor();

      board = Board(
        lines: qtyOfLines,
        columns: qtyOfColumns,
        qtyOfPumps: 50,
      );
    }
    return board;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: ResultadoWidget(
          won: _won,
          onRestart: _restart,
        ),
        body: Container(
          color: Colors.grey,
          child: LayoutBuilder(
            builder: (ctx, constraints) {
              return BoardWidget(
                board: _getBoard(
                  constraints.maxWidth,
                  constraints.maxHeight,
                ),
                onOpen: _open,
                onChangeAppointment: _changeAppointment,
              );
            },
          ),
        ),
      ),
    );
  }
}
