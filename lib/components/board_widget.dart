import 'package:minefield/components/field_widget.dart';
import 'package:flutter/material.dart';
import '../models/field.dart';
import '../models/board.dart';

class BoardWidget extends StatelessWidget {
  final Board board;
  final void Function(Field) onOpen;
  final void Function(Field) onChangeAppointment;

  BoardWidget({
    @required this.board,
    @required this.onOpen,
    @required this.onChangeAppointment,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.count(
        crossAxisCount: board.columns,
        children: board.fields.map((f) {
          return FieldWidget(
            field: f,
            onOpen: onOpen,
            onChangeAppointment: onChangeAppointment,
          );
        }).toList(),
      ),
    );
  }
}
