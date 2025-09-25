// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers,unused_element,unnecessary_string_interpolations,unused_element_parameter

class _ApiClient implements ApiClient {
  _ApiClient(this._dio, {this.baseUrl, this.errorLogger}) {
    baseUrl ??= 'https://flower.elevateegy.com/api';
  }

  final Dio _dio;

  String? baseUrl;

  final ParseErrorLogger? errorLogger;

  @override
  Future<ApplyResponse> apply(
    String email,
    String password,
    String rePassword,
    String firstName,
    String lastName,
    String phone,
    String gender,
    String NID,
    String vehicleType,
    String vehicleNumber,
    String country,
    File? vehicleLicense,
    File? NIDImg,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = FormData();
    _data.fields.add(MapEntry('email', email));
    _data.fields.add(MapEntry('password', password));
    _data.fields.add(MapEntry('rePassword', rePassword));
    _data.fields.add(MapEntry('firstName', firstName));
    _data.fields.add(MapEntry('lastName', lastName));
    _data.fields.add(MapEntry('phone', phone));
    _data.fields.add(MapEntry('gender', gender));
    _data.fields.add(MapEntry('NID', NID));
    _data.fields.add(MapEntry('vehicleType', vehicleType));
    _data.fields.add(MapEntry('vehicleNumber', vehicleNumber));
    _data.fields.add(MapEntry('country', country));
    if (vehicleLicense != null) {
      _data.files.add(
        MapEntry(
          'vehicleLicense',
          MultipartFile.fromFileSync(
            vehicleLicense.path,
            filename: vehicleLicense.path.split(Platform.pathSeparator).last,
          ),
        ),
      );
    }
    if (NIDImg != null) {
      _data.files.add(
        MapEntry(
          'NIDImg',
          MultipartFile.fromFileSync(
            NIDImg.path,
            filename: NIDImg.path.split(Platform.pathSeparator).last,
          ),
        ),
      );
    }
    final _options = _setStreamType<ApplyResponse>(
      Options(
            method: 'POST',
            headers: _headers,
            extra: _extra,
            contentType: 'multipart/form-data',
          )
          .compose(
            _dio.options,
            '/v1/drivers/apply',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApplyResponse _value;
    try {
      _value = ApplyResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(String dioBaseUrl, String? baseUrl) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}
