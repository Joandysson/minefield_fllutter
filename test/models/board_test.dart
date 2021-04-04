import 'package:minefield/models/board.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  test('Win Game', () {
    Board board = Board(
      lines: 2,
      columns: 2,
      qtyOfPumps: 0,
    );

    board.fields[0].minar();
    board.fields[3].minar();

    // Jogando...
    board.fields[0].changeAppointment();
    board.fields[1].open();
    board.fields[2].open();
    board.fields[3].changeAppointment();

    expect(board.resolved, isTrue);
  });
}
