// Mocks generated by Mockito 5.4.5 from annotations
// in movie/test/helpers/test_helper.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i7;
import 'dart:convert' as _i18;
import 'dart:typed_data' as _i19;

import 'package:core/common/db/database_helper.dart' as _i16;
import 'package:core/common/failure.dart' as _i8;
import 'package:dartz/dartz.dart' as _i2;
import 'package:http/http.dart' as _i5;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i15;
import 'package:movie/data/datasources/movie_local_data_source.dart' as _i13;
import 'package:movie/data/datasources/movie_remote_data_source.dart' as _i11;
import 'package:movie/data/models/movie_detail_model.dart' as _i3;
import 'package:movie/data/models/movie_model.dart' as _i12;
import 'package:movie/data/models/movie_table.dart' as _i14;
import 'package:movie/domain/entities/movie.dart' as _i9;
import 'package:movie/domain/entities/movie_detail.dart' as _i10;
import 'package:movie/domain/repositories/movie_repository.dart' as _i6;
import 'package:series/data/models/series_table.dart' as _i17;
import 'package:sqflite/sqflite.dart' as _i4;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: must_be_immutable
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class _FakeMovieDetailResponse_1 extends _i1.SmartFake
    implements _i3.MovieDetailResponse {
  _FakeMovieDetailResponse_1(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class _FakeDatabase_2 extends _i1.SmartFake implements _i4.Database {
  _FakeDatabase_2(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class _FakeResponse_3 extends _i1.SmartFake implements _i5.Response {
  _FakeResponse_3(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class _FakeStreamedResponse_4 extends _i1.SmartFake
    implements _i5.StreamedResponse {
  _FakeStreamedResponse_4(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

/// A class which mocks [MovieRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieRepository extends _i1.Mock implements _i6.MovieRepository {
  MockMovieRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i9.Movie>>> getNowPlayingMovies() =>
      (super.noSuchMethod(
            Invocation.method(#getNowPlayingMovies, []),
            returnValue:
                _i7.Future<_i2.Either<_i8.Failure, List<_i9.Movie>>>.value(
                  _FakeEither_0<_i8.Failure, List<_i9.Movie>>(
                    this,
                    Invocation.method(#getNowPlayingMovies, []),
                  ),
                ),
          )
          as _i7.Future<_i2.Either<_i8.Failure, List<_i9.Movie>>>);

  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i9.Movie>>> getPopularMovies() =>
      (super.noSuchMethod(
            Invocation.method(#getPopularMovies, []),
            returnValue:
                _i7.Future<_i2.Either<_i8.Failure, List<_i9.Movie>>>.value(
                  _FakeEither_0<_i8.Failure, List<_i9.Movie>>(
                    this,
                    Invocation.method(#getPopularMovies, []),
                  ),
                ),
          )
          as _i7.Future<_i2.Either<_i8.Failure, List<_i9.Movie>>>);

  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i9.Movie>>> getTopRatedMovies() =>
      (super.noSuchMethod(
            Invocation.method(#getTopRatedMovies, []),
            returnValue:
                _i7.Future<_i2.Either<_i8.Failure, List<_i9.Movie>>>.value(
                  _FakeEither_0<_i8.Failure, List<_i9.Movie>>(
                    this,
                    Invocation.method(#getTopRatedMovies, []),
                  ),
                ),
          )
          as _i7.Future<_i2.Either<_i8.Failure, List<_i9.Movie>>>);

  @override
  _i7.Future<_i2.Either<_i8.Failure, _i10.MovieDetail>> getMovieDetail(
    int? id,
  ) =>
      (super.noSuchMethod(
            Invocation.method(#getMovieDetail, [id]),
            returnValue:
                _i7.Future<_i2.Either<_i8.Failure, _i10.MovieDetail>>.value(
                  _FakeEither_0<_i8.Failure, _i10.MovieDetail>(
                    this,
                    Invocation.method(#getMovieDetail, [id]),
                  ),
                ),
          )
          as _i7.Future<_i2.Either<_i8.Failure, _i10.MovieDetail>>);

  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i9.Movie>>> getMovieRecommendations(
    int? id,
  ) =>
      (super.noSuchMethod(
            Invocation.method(#getMovieRecommendations, [id]),
            returnValue:
                _i7.Future<_i2.Either<_i8.Failure, List<_i9.Movie>>>.value(
                  _FakeEither_0<_i8.Failure, List<_i9.Movie>>(
                    this,
                    Invocation.method(#getMovieRecommendations, [id]),
                  ),
                ),
          )
          as _i7.Future<_i2.Either<_i8.Failure, List<_i9.Movie>>>);

  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i9.Movie>>> searchMovies(
    String? query,
  ) =>
      (super.noSuchMethod(
            Invocation.method(#searchMovies, [query]),
            returnValue:
                _i7.Future<_i2.Either<_i8.Failure, List<_i9.Movie>>>.value(
                  _FakeEither_0<_i8.Failure, List<_i9.Movie>>(
                    this,
                    Invocation.method(#searchMovies, [query]),
                  ),
                ),
          )
          as _i7.Future<_i2.Either<_i8.Failure, List<_i9.Movie>>>);

  @override
  _i7.Future<_i2.Either<_i8.Failure, String>> saveWatchlist(
    _i10.MovieDetail? movie,
  ) =>
      (super.noSuchMethod(
            Invocation.method(#saveWatchlist, [movie]),
            returnValue: _i7.Future<_i2.Either<_i8.Failure, String>>.value(
              _FakeEither_0<_i8.Failure, String>(
                this,
                Invocation.method(#saveWatchlist, [movie]),
              ),
            ),
          )
          as _i7.Future<_i2.Either<_i8.Failure, String>>);

  @override
  _i7.Future<_i2.Either<_i8.Failure, String>> removeWatchlist(
    _i10.MovieDetail? movie,
  ) =>
      (super.noSuchMethod(
            Invocation.method(#removeWatchlist, [movie]),
            returnValue: _i7.Future<_i2.Either<_i8.Failure, String>>.value(
              _FakeEither_0<_i8.Failure, String>(
                this,
                Invocation.method(#removeWatchlist, [movie]),
              ),
            ),
          )
          as _i7.Future<_i2.Either<_i8.Failure, String>>);

  @override
  _i7.Future<bool> isAddedToWatchlist(int? id) =>
      (super.noSuchMethod(
            Invocation.method(#isAddedToWatchlist, [id]),
            returnValue: _i7.Future<bool>.value(false),
          )
          as _i7.Future<bool>);

  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i9.Movie>>> getWatchlistMovies() =>
      (super.noSuchMethod(
            Invocation.method(#getWatchlistMovies, []),
            returnValue:
                _i7.Future<_i2.Either<_i8.Failure, List<_i9.Movie>>>.value(
                  _FakeEither_0<_i8.Failure, List<_i9.Movie>>(
                    this,
                    Invocation.method(#getWatchlistMovies, []),
                  ),
                ),
          )
          as _i7.Future<_i2.Either<_i8.Failure, List<_i9.Movie>>>);
}

/// A class which mocks [MovieRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieRemoteDataSource extends _i1.Mock
    implements _i11.MovieRemoteDataSource {
  MockMovieRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<List<_i12.MovieModel>> getNowPlayingMovies() =>
      (super.noSuchMethod(
            Invocation.method(#getNowPlayingMovies, []),
            returnValue: _i7.Future<List<_i12.MovieModel>>.value(
              <_i12.MovieModel>[],
            ),
          )
          as _i7.Future<List<_i12.MovieModel>>);

  @override
  _i7.Future<List<_i12.MovieModel>> getPopularMovies() =>
      (super.noSuchMethod(
            Invocation.method(#getPopularMovies, []),
            returnValue: _i7.Future<List<_i12.MovieModel>>.value(
              <_i12.MovieModel>[],
            ),
          )
          as _i7.Future<List<_i12.MovieModel>>);

  @override
  _i7.Future<List<_i12.MovieModel>> getTopRatedMovies() =>
      (super.noSuchMethod(
            Invocation.method(#getTopRatedMovies, []),
            returnValue: _i7.Future<List<_i12.MovieModel>>.value(
              <_i12.MovieModel>[],
            ),
          )
          as _i7.Future<List<_i12.MovieModel>>);

  @override
  _i7.Future<_i3.MovieDetailResponse> getMovieDetail(int? id) =>
      (super.noSuchMethod(
            Invocation.method(#getMovieDetail, [id]),
            returnValue: _i7.Future<_i3.MovieDetailResponse>.value(
              _FakeMovieDetailResponse_1(
                this,
                Invocation.method(#getMovieDetail, [id]),
              ),
            ),
          )
          as _i7.Future<_i3.MovieDetailResponse>);

  @override
  _i7.Future<List<_i12.MovieModel>> getMovieRecommendations(int? id) =>
      (super.noSuchMethod(
            Invocation.method(#getMovieRecommendations, [id]),
            returnValue: _i7.Future<List<_i12.MovieModel>>.value(
              <_i12.MovieModel>[],
            ),
          )
          as _i7.Future<List<_i12.MovieModel>>);

  @override
  _i7.Future<List<_i12.MovieModel>> searchMovies(String? query) =>
      (super.noSuchMethod(
            Invocation.method(#searchMovies, [query]),
            returnValue: _i7.Future<List<_i12.MovieModel>>.value(
              <_i12.MovieModel>[],
            ),
          )
          as _i7.Future<List<_i12.MovieModel>>);
}

/// A class which mocks [MovieLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieLocalDataSource extends _i1.Mock
    implements _i13.MovieLocalDataSource {
  MockMovieLocalDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<String> insertWatchlist(_i14.MovieTable? movie) =>
      (super.noSuchMethod(
            Invocation.method(#insertWatchlist, [movie]),
            returnValue: _i7.Future<String>.value(
              _i15.dummyValue<String>(
                this,
                Invocation.method(#insertWatchlist, [movie]),
              ),
            ),
          )
          as _i7.Future<String>);

  @override
  _i7.Future<String> removeWatchlist(_i14.MovieTable? movie) =>
      (super.noSuchMethod(
            Invocation.method(#removeWatchlist, [movie]),
            returnValue: _i7.Future<String>.value(
              _i15.dummyValue<String>(
                this,
                Invocation.method(#removeWatchlist, [movie]),
              ),
            ),
          )
          as _i7.Future<String>);

  @override
  _i7.Future<_i14.MovieTable?> getMovieById(int? id) =>
      (super.noSuchMethod(
            Invocation.method(#getMovieById, [id]),
            returnValue: _i7.Future<_i14.MovieTable?>.value(),
          )
          as _i7.Future<_i14.MovieTable?>);

  @override
  _i7.Future<List<_i14.MovieTable>> getWatchlistMovies() =>
      (super.noSuchMethod(
            Invocation.method(#getWatchlistMovies, []),
            returnValue: _i7.Future<List<_i14.MovieTable>>.value(
              <_i14.MovieTable>[],
            ),
          )
          as _i7.Future<List<_i14.MovieTable>>);
}

/// A class which mocks [DatabaseHelper].
///
/// See the documentation for Mockito's code generation for more information.
class MockDatabaseHelper extends _i1.Mock implements _i16.DatabaseHelper {
  MockDatabaseHelper() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Database get database =>
      (super.noSuchMethod(
            Invocation.getter(#database),
            returnValue: _FakeDatabase_2(this, Invocation.getter(#database)),
          )
          as _i4.Database);

  @override
  _i7.Future<int> insertWatchlist(_i14.MovieTable? movie) =>
      (super.noSuchMethod(
            Invocation.method(#insertWatchlist, [movie]),
            returnValue: _i7.Future<int>.value(0),
          )
          as _i7.Future<int>);

  @override
  _i7.Future<int> removeWatchlist(_i14.MovieTable? movie) =>
      (super.noSuchMethod(
            Invocation.method(#removeWatchlist, [movie]),
            returnValue: _i7.Future<int>.value(0),
          )
          as _i7.Future<int>);

  @override
  _i7.Future<Map<String, dynamic>?> getMovieById(int? id) =>
      (super.noSuchMethod(
            Invocation.method(#getMovieById, [id]),
            returnValue: _i7.Future<Map<String, dynamic>?>.value(),
          )
          as _i7.Future<Map<String, dynamic>?>);

  @override
  _i7.Future<List<Map<String, dynamic>>> getWatchlistMovies() =>
      (super.noSuchMethod(
            Invocation.method(#getWatchlistMovies, []),
            returnValue: _i7.Future<List<Map<String, dynamic>>>.value(
              <Map<String, dynamic>>[],
            ),
          )
          as _i7.Future<List<Map<String, dynamic>>>);

  @override
  _i7.Future<int> insertSeriesWatchlist(_i17.SeriesTable? series) =>
      (super.noSuchMethod(
            Invocation.method(#insertSeriesWatchlist, [series]),
            returnValue: _i7.Future<int>.value(0),
          )
          as _i7.Future<int>);

  @override
  _i7.Future<int> removeSeriesWatchlist(_i17.SeriesTable? series) =>
      (super.noSuchMethod(
            Invocation.method(#removeSeriesWatchlist, [series]),
            returnValue: _i7.Future<int>.value(0),
          )
          as _i7.Future<int>);

  @override
  _i7.Future<Map<String, dynamic>?> getSeriesById(int? id) =>
      (super.noSuchMethod(
            Invocation.method(#getSeriesById, [id]),
            returnValue: _i7.Future<Map<String, dynamic>?>.value(),
          )
          as _i7.Future<Map<String, dynamic>?>);

  @override
  _i7.Future<List<Map<String, dynamic>>> getWatchlistSeries() =>
      (super.noSuchMethod(
            Invocation.method(#getWatchlistSeries, []),
            returnValue: _i7.Future<List<Map<String, dynamic>>>.value(
              <Map<String, dynamic>>[],
            ),
          )
          as _i7.Future<List<Map<String, dynamic>>>);
}

/// A class which mocks [Client].
///
/// See the documentation for Mockito's code generation for more information.
class MockHttpClient extends _i1.Mock implements _i5.Client {
  MockHttpClient() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<_i5.Response> head(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(
            Invocation.method(#head, [url], {#headers: headers}),
            returnValue: _i7.Future<_i5.Response>.value(
              _FakeResponse_3(
                this,
                Invocation.method(#head, [url], {#headers: headers}),
              ),
            ),
          )
          as _i7.Future<_i5.Response>);

  @override
  _i7.Future<_i5.Response> get(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(
            Invocation.method(#get, [url], {#headers: headers}),
            returnValue: _i7.Future<_i5.Response>.value(
              _FakeResponse_3(
                this,
                Invocation.method(#get, [url], {#headers: headers}),
              ),
            ),
          )
          as _i7.Future<_i5.Response>);

  @override
  _i7.Future<_i5.Response> post(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i18.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
            Invocation.method(
              #post,
              [url],
              {#headers: headers, #body: body, #encoding: encoding},
            ),
            returnValue: _i7.Future<_i5.Response>.value(
              _FakeResponse_3(
                this,
                Invocation.method(
                  #post,
                  [url],
                  {#headers: headers, #body: body, #encoding: encoding},
                ),
              ),
            ),
          )
          as _i7.Future<_i5.Response>);

  @override
  _i7.Future<_i5.Response> put(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i18.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
            Invocation.method(
              #put,
              [url],
              {#headers: headers, #body: body, #encoding: encoding},
            ),
            returnValue: _i7.Future<_i5.Response>.value(
              _FakeResponse_3(
                this,
                Invocation.method(
                  #put,
                  [url],
                  {#headers: headers, #body: body, #encoding: encoding},
                ),
              ),
            ),
          )
          as _i7.Future<_i5.Response>);

  @override
  _i7.Future<_i5.Response> patch(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i18.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
            Invocation.method(
              #patch,
              [url],
              {#headers: headers, #body: body, #encoding: encoding},
            ),
            returnValue: _i7.Future<_i5.Response>.value(
              _FakeResponse_3(
                this,
                Invocation.method(
                  #patch,
                  [url],
                  {#headers: headers, #body: body, #encoding: encoding},
                ),
              ),
            ),
          )
          as _i7.Future<_i5.Response>);

  @override
  _i7.Future<_i5.Response> delete(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i18.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
            Invocation.method(
              #delete,
              [url],
              {#headers: headers, #body: body, #encoding: encoding},
            ),
            returnValue: _i7.Future<_i5.Response>.value(
              _FakeResponse_3(
                this,
                Invocation.method(
                  #delete,
                  [url],
                  {#headers: headers, #body: body, #encoding: encoding},
                ),
              ),
            ),
          )
          as _i7.Future<_i5.Response>);

  @override
  _i7.Future<String> read(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(
            Invocation.method(#read, [url], {#headers: headers}),
            returnValue: _i7.Future<String>.value(
              _i15.dummyValue<String>(
                this,
                Invocation.method(#read, [url], {#headers: headers}),
              ),
            ),
          )
          as _i7.Future<String>);

  @override
  _i7.Future<_i19.Uint8List> readBytes(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
            Invocation.method(#readBytes, [url], {#headers: headers}),
            returnValue: _i7.Future<_i19.Uint8List>.value(_i19.Uint8List(0)),
          )
          as _i7.Future<_i19.Uint8List>);

  @override
  _i7.Future<_i5.StreamedResponse> send(_i5.BaseRequest? request) =>
      (super.noSuchMethod(
            Invocation.method(#send, [request]),
            returnValue: _i7.Future<_i5.StreamedResponse>.value(
              _FakeStreamedResponse_4(
                this,
                Invocation.method(#send, [request]),
              ),
            ),
          )
          as _i7.Future<_i5.StreamedResponse>);

  @override
  void close() => super.noSuchMethod(
    Invocation.method(#close, []),
    returnValueForMissingStub: null,
  );
}
