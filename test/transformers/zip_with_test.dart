import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:test/test.dart';

void main() {
  test('Rx.zipWith', () async {
    Stream<int>.value(1)
        .zipWith(Stream<int>.value(2), (int one, int two) => one + two)
        .listen(expectAsync1((int result) {
          expect(result, 3);
        }, count: 1));
  });
  test('Rx.zipWith accidental broadcast', () async {
    final controller = StreamController<int>();

    final stream =
        controller.stream.zipWith(Stream<int>.empty(), (_, dynamic __) => true);

    stream.listen(null);
    expect(() => stream.listen(null), throwsStateError);

    controller.add(1);
  });
}
