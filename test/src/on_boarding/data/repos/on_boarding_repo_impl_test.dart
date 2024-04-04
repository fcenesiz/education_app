import 'package:dartz/dartz.dart';
import 'package:education_app/core/errors/exceptions.dart';
import 'package:education_app/core/errors/failures.dart';
import 'package:education_app/src/on_boarding/data/datasources/on_boarding_local_data_source.dart';
import 'package:education_app/src/on_boarding/data/repos/on_boarding_repo_impl.dart';
import 'package:education_app/src/on_boarding/domain/repos/on_boarding_repo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockOnBoardingLocalDataSrc extends Mock
    implements OnBoardingLocalDataSource {}

void main() {
  late OnBoardingLocalDataSource localDataSource;
  late OnBoardingRepoImpl repoImpl;

  setUp(() {
    localDataSource = MockOnBoardingLocalDataSrc();
    repoImpl = OnBoardingRepoImpl(localDataSource);
  });

  test('should be a subclass of [OnBoardingRepo]', () {
    expect(repoImpl, isA<OnBoardingRepo>());
  });

  group(
    'cacheFirstTimer',
    () {
      test(
        'should complete successfully when call to local source is successful',
        () async {
          // arrange
          when(() => localDataSource.cacheFirstTimer()).thenAnswer(
            (_) async => Future.value(),
          );

          // act
          final result = await repoImpl.cacheFirstTimer();

          // assert
          expect(result, equals(const Right<dynamic, void>(null)));
          verify(() => localDataSource.cacheFirstTimer()).called(1);
          verifyNoMoreInteractions(localDataSource);
        },
      );

      test(
        'should return [CacheFailure] when call to local source is '
        'unsuccessful',
        () async {
          // arrange
          when(() => localDataSource.cacheFirstTimer()).thenThrow(
            const CacheException(message: 'Insufficient storage'),
          );

          // act
          final result = await repoImpl.cacheFirstTimer();

          // assert
          expect(
            result,
            Left<CacheFailure, dynamic>(
              CacheFailure(message: 'Insufficient storage', statusCode: 500),
            ),
          );
          verify(() => localDataSource.cacheFirstTimer()).called(1);
          verifyNoMoreInteractions(localDataSource);
        },
      );
    },
  );

  group(
    'checkIfUserIsFirstTimer',
    () {
      test(
        'should return true when user is first timer',
        () async {
          // arrange
          when(() => localDataSource.checkIfUserIsFirstTimer())
              .thenAnswer((_) async => Future.value(true));
          // act
          final result = await repoImpl.checkIfUserFirstTimer();
          // assert
          expect(result, equals(const Right<dynamic, bool>(true)));
          verify(() => localDataSource.checkIfUserIsFirstTimer()).called(1);
          verifyNoMoreInteractions(localDataSource);
        },
      );

      test(
        'should return true when user is not first timer',
        () async {
          // arrange
          when(() => localDataSource.checkIfUserIsFirstTimer())
              .thenAnswer((_) async => Future.value(false));
          // act
          final result = await repoImpl.checkIfUserFirstTimer();
          // assert
          expect(result, equals(const Right<dynamic, bool>(false)));
          verify(() => localDataSource.checkIfUserIsFirstTimer()).called(1);
          verifyNoMoreInteractions(localDataSource);
        },
      );

      test(
        'should return a CacheFailure when call to local data source '
        'is successful',
        () async {
          // arrange
          when(() => localDataSource.checkIfUserIsFirstTimer()).thenThrow(
            const CacheException(
              message: 'Insufficient permissions',
              statusCode: 403,
            ),
          );
          // act
          final result = await repoImpl.checkIfUserFirstTimer();
          // assert
          expect(
            result,
            equals(
              Left<CacheFailure, bool>(
                CacheFailure(
                  message: 'Insufficient permissions',
                  statusCode: 403,
                ),
              ),
            ),
          );
          verify(() => localDataSource.checkIfUserIsFirstTimer()).called(1);
          verifyNoMoreInteractions(localDataSource);
        },
      );
    },
  );
}
