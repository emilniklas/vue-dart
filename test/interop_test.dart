@TestOn('browser')

import 'dart:async';
import 'dart:html';
import 'package:vue/src/interop.dart';
import 'package:test/test.dart';

main() {
  test('simple Vue instance', () async {
    final completer = new Completer();
    final scope = querySelector('#scope');

    new Vue(new VueSingletonDeclaration(
      el: '#scope',
      data: jsify({
        'variable': 'x'
      }),
      ready: () {
        completer.complete(scope.text.trim());
      }
    ));

    expect(await completer.future, 'x');
  });
}