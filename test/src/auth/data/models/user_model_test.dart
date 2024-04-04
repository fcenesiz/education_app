import 'dart:convert';

import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/auth/data/models/user_model.dart';
import 'package:education_app/src/auth/domain/entities/user.dart';
import 'package:test/test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  late LocalUserModel tLocalUserModel;
  late DataMap tMap;

  setUp(() {
    tLocalUserModel = const LocalUserModel.empty();
    tMap = jsonDecode(fixture('user.json')) as DataMap;
  });

  test(
    'should be subclass of [LocalUser] entity',
    () => expect(tLocalUserModel, isA<LocalUser>()),
  );

  group('fromMap', () {
    test(
      'should return a valid [LocalUserModel] from the map',
      () async {
        //act
        final result = LocalUserModel.fromMap(tMap);

        //assert
        expect(result, isA<LocalUserModel>());
        expect(result, equals(tLocalUserModel));
      },
    );

    test(
      'should throw an [Error] when the map is invalid',
      () {
        final map = tMap..remove('uid');
        const call = LocalUserModel.fromMap;

        //assert
        expect(() => call(map), throwsA(isA<Error>()));
      },
    );
  });

  group('toMap', () {
    test('should return a valid [DataMap] from the model', () {
      // act
      final result = tLocalUserModel.toMap();
      // assert
      expect(result, equals(tMap));
    });
  });

  group('copyWith', () {
    test(
      'should return a valid [LocalUserModel] with updated values',
      () {
        // act
        final result = tLocalUserModel.copyWith(uid: '2');
        // assert
        expect(result.uid, '2');
      },
    );
  });
}
