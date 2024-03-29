import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:hi_core/hi_core.dart';
import 'response.dart';

class HiService extends GetConnect {
  @override
  void onInit() {
    super.onInit();
    httpClient.defaultContentType = 'application/json';
    httpClient.addRequestModifier((request) => requestModifier(request));
    httpClient.addResponseModifier((request, response) => responseModifier(request, response));
    httpClient.defaultDecoder = (data) {
      var json = <String, dynamic>{};
      if (data is Map<String, dynamic>) {
        json = data;
      } else {
        json = {
          HiParameter.code: HiError.okCode,
          HiParameter.data: data,
        };
      }
      return HiResponse.fromJson(json);
    };
  }

  Request requestModifier(Request request) {
    log('【${request.method}】${request.url}', tag: HiLogTag.network);
    return request;
  }

  Response responseModifier(Request request, Response response) {
    log('${request.url.path}(${response.statusCode}, ${response.statusText})', tag: HiLogTag.network);
    if (response.bodyString?.isNotEmpty ?? false) {
      log(response.bodyString);
    } else {
      if (response.body is HiResponse) {
        log(response.body.data);
      }
    }
    return response;
  }

  Future<T> object<T>(
      Response<dynamic> response, {
        bool checkCode = true,
        bool adoptData = true,
        T Function(dynamic)? fromJson,
      }) {
    if (response.hasError) {
      return Future.error(
        HiServerError(response.statusCode ?? -1, response.statusText, data: response.body),
      );
    }

    dynamic data = null;
    var base = response.body;
    if (base is HiResponse) {
      if (checkCode && base.code != HiError.okCode) {
        return Future.error(HiServerError(base.code ?? -1, base.message, data: base.json));
      }
      data = adoptData ? base.data : base.json;
    }
    var genericType = typeOf<T>();
    if (genericType == typeOf<void>()) {
      return Future.value();
    }
    if (genericType == typeOf<dynamic>()) {
      return Future.value(data);
    }
    if (data is T) {
      return Future.value(data as T);
    }
    if (T == bool && hiBool(data) != null) {
      return Future.value(hiBool(data) as T);
    }
    if (T == double && hiDouble(data) != null) {
      return Future.value(hiDouble(data) as T);
    }
    if (T == int && hiInt(data) != null) {
      return Future.value(hiInt(data) as T);
    }
    if (T == String && hiString(data) != null) {
      return Future.value(hiString(data) as T);
    }
    if (fromJson != null) {
      var model = fromJson(data);
      if (model is HiModel && !(model as HiModel).isValid) {
        return Future.error(HiError.dataInvalid);
      }
      return Future.value(model);
    }
    return Future.error(HiError.dataInvalid);
  }

  Future<List<T>> array<T>(
      Response<dynamic> response, {
        bool checkCode = true,
        bool adoptData = true,
        T Function(dynamic)? fromJson,
      }) {
    if (response.hasError) {
      return Future.error(
        HiServerError(response.statusCode ?? -1, response.statusText, data: response.body),
      );
    }

    dynamic data = null;
    var base = response.body;
    if (base is HiResponse) {
      if (checkCode && base.code != HiError.okCode) {
        return Future.error(HiServerError(base.code ?? -1, base.message, data: base.json));
      }
      data = adoptData ? base.data : base.json;
    }

    if (data is! List) {
      return Future.error(HiError.dataInvalid);
    }
    if (data.isEmpty) {
      return Future.error(HiError.dataIsEmpty);
    }
    if (fromJson == null) {
      return Future.error(HiError.unknown);
    }
    var array = data.where((e) => e is Map<String, dynamic>)
        .map((json) => fromJson(json))
        .toList();
    if (array.isEmpty) {
      return Future.error(HiError.dataIsEmpty);
    }
    return Future.value(array);
  }

}