import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:task_app/core/resources/resources.dart';

void main() {
  test('json_assets assets test', () {
    expect(File(JsonAssets.orders).existsSync(), isTrue);
  });
}
