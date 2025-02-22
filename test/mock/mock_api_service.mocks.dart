// Mocks generated by Mockito 5.4.4 from annotations
// in app/test/mock/mock_api_service.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:app/services/api_service.dart' as _i4;
import 'package:app/services/user_helper.dart' as _i3;
import 'package:dio/dio.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeDio_0 extends _i1.SmartFake implements _i2.Dio {
  _FakeDio_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeDatabaseHelper_1 extends _i1.SmartFake
    implements _i3.DatabaseHelper {
  _FakeDatabaseHelper_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeResponse_2<T> extends _i1.SmartFake implements _i2.Response<T> {
  _FakeResponse_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [ApiService].
///
/// See the documentation for Mockito's code generation for more information.
class MockApiService extends _i1.Mock implements _i4.ApiService {
  MockApiService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.Dio get dio => (super.noSuchMethod(
        Invocation.getter(#dio),
        returnValue: _FakeDio_0(
          this,
          Invocation.getter(#dio),
        ),
      ) as _i2.Dio);

  @override
  set dio(_i2.Dio? _dio) => super.noSuchMethod(
        Invocation.setter(
          #dio,
          _dio,
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i3.DatabaseHelper get dbHelper => (super.noSuchMethod(
        Invocation.getter(#dbHelper),
        returnValue: _FakeDatabaseHelper_1(
          this,
          Invocation.getter(#dbHelper),
        ),
      ) as _i3.DatabaseHelper);

  @override
  set apiUrl(String? _apiUrl) => super.noSuchMethod(
        Invocation.setter(
          #apiUrl,
          _apiUrl,
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i5.Future<_i2.Response<dynamic>> get(
    String? path, [
    Map<String, dynamic>? data,
  ]) =>
      (super.noSuchMethod(
        Invocation.method(
          #get,
          [
            path,
            data,
          ],
        ),
        returnValue:
            _i5.Future<_i2.Response<dynamic>>.value(_FakeResponse_2<dynamic>(
          this,
          Invocation.method(
            #get,
            [
              path,
              data,
            ],
          ),
        )),
      ) as _i5.Future<_i2.Response<dynamic>>);

  @override
  _i5.Future<_i2.Response<dynamic>> post(
    String? path, {
    Map<String, dynamic>? data,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #post,
          [path],
          {#data: data},
        ),
        returnValue:
            _i5.Future<_i2.Response<dynamic>>.value(_FakeResponse_2<dynamic>(
          this,
          Invocation.method(
            #post,
            [path],
            {#data: data},
          ),
        )),
      ) as _i5.Future<_i2.Response<dynamic>>);

  @override
  _i5.Future<_i2.Response<dynamic>> put(
    String? path, {
    Map<String, dynamic>? data,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #put,
          [path],
          {#data: data},
        ),
        returnValue:
            _i5.Future<_i2.Response<dynamic>>.value(_FakeResponse_2<dynamic>(
          this,
          Invocation.method(
            #put,
            [path],
            {#data: data},
          ),
        )),
      ) as _i5.Future<_i2.Response<dynamic>>);

  @override
  _i5.Future<_i2.Response<dynamic>> delete(String? path) => (super.noSuchMethod(
        Invocation.method(
          #delete,
          [path],
        ),
        returnValue:
            _i5.Future<_i2.Response<dynamic>>.value(_FakeResponse_2<dynamic>(
          this,
          Invocation.method(
            #delete,
            [path],
          ),
        )),
      ) as _i5.Future<_i2.Response<dynamic>>);
}
