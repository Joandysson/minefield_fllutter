import 'package:flutter/material.dart';
import '../models/field.dart';

class FieldWidget extends StatelessWidget {
  final Field field;
  final void Function(Field) onOpen;
  final void Function(Field) onChangeAppointment;

  FieldWidget({
    @required this.field,
    @required this.onOpen,
    @required this.onChangeAppointment,
  });

  Widget _getImage() {
    int qtyOfMines = field.qtyOfMinesNeighborhood;
    if (field.opened && field.minado && field.explodido) {
      return Image.asset('assets/images/bomb_0.jpeg');
    } else if (field.opened && field.minado) {
      return Image.asset('assets/images/bomb_1.jpeg');
    } else if (field.opened) {
      return Image.asset('assets/images/opened_$qtyOfMines.jpeg');
    } else if (field.marked) {
      return Image.asset('assets/images/flag.jpeg');
    } else {
      return Image.asset('assets/images/closed.jpeg');
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onOpen(field),
      onLongPress: () => onChangeAppointment(field),
      child: _getImage(),
    );
  }
}
