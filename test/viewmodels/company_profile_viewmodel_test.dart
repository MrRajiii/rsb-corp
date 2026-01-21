import 'package:flutter_test/flutter_test.dart';
import 'package:rsbweb_v1/app/app.locator.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('CompanyProfileViewModel Tests -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}
