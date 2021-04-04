import 'package:minefield/models/field.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  group('Field', () {
    test('Open field WITH Explosion', () {
      Field f = Field(line: 0, column: 0);
      f.minar();

      expect(f.open, throwsException);
    });

    test('Open field WITHOUT Explosion', () {
      Field f = Field(line: 0, column: 0);
      f.open();
      expect(f.opened, isTrue);
    });

    test('Add NO Neighbor', () {
      Field f1 = Field(line: 0, column: 0);
      Field f2 = Field(line: 1, column: 3);
      f1.addNeighbor(f2);
      expect(f1.neighbors.isEmpty, isTrue);
    });

    test('Add Neighbor', () {
      Field f1 = Field(line: 3, column: 3);
      Field f2 = Field(line: 3, column: 4);
      Field f3 = Field(line: 2, column: 2);
      Field f4 = Field(line: 4, column: 4);

      f1.addNeighbor(f2);
      f1.addNeighbor(f3);
      f1.addNeighbor(f4);

      expect(f1.neighbors.length, 3);
    });

    test('Mines in the Neighborhood', () {
      Field f1 = Field(line: 3, column: 3);

      Field f2 = Field(line: 3, column: 4);
      f2.minar();

      Field f3 = Field(line: 2, column: 2);

      Field f4 = Field(line: 4, column: 4);
      f4.minar();

      f1.addNeighbor(f2);
      f1.addNeighbor(f3);
      f1.addNeighbor(f4);

      expect(f1.qtyOfMinesNeighborhood, 2);
    });
  });
}
