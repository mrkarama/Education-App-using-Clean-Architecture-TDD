import 'dart:convert';

import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/authentication/data/models/user_model.dart';
import 'package:education_app/src/authentication/domain/entities/user.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tLocalUser = LocalUserModel.empty();
  final tMap = jsonDecode(fixture('user.json')) as DataMap;
  test('should be a subclass of [LocalUser]', () {
    expect(tLocalUser, isA<LocaleUser>());
  });

  group('fromMap', () {
    test('should return [LocalUserModel] with the right data', () {
      final result = LocalUserModel.fromMap(tMap);
      expect(result, equals(tLocalUser));
    });
  });

  group('toMap', () {
    test('should return a [Map] with the right data', () {
      final result = tLocalUser.toMap();
      expect(result, tMap);
    });
  });

  group('copyWith', () {
    test('should return [LocalUserModel] with different data', () {
      final result = tLocalUser.copyWith(points: 13);
      expect(result, isA<LocalUserModel>());
      expect(result.points, 13);
    });
  });
}
