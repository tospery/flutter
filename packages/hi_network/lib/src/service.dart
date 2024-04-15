import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:hi_core/hi_core.dart';
import 'response.dart';

class HiService extends GetConnect {
  @override
  void onInit() {
    super.onInit();
    httpClient.defaultContentType = 'application/json';
    httpClient.addAuthenticator<dynamic>((request) => authenticator(request));
    httpClient.addRequestModifier<dynamic>((request) => requestModifier(request));
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

  Request authenticator(Request request) {
    return request;
  }

  Request requestModifier(Request request) {
    log('RESTful Request ->【${request.method}】${request.url}', tag: HiLogTag.network);
    return request;
  }

  Response responseModifier(Request request, Response response) {
    log('RESTful Response ->【${request.url.path}】(${response.statusCode}, ${response.statusText})', tag: HiLogTag.network);
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
    dynamic data = null;
    var base = response.body;
    var code = response.statusCode;
    var message = response.statusText;
    if (base is HiResponse) {
      if (base.code != null) {
        code = base.code;
      }
      if (base.message != null) {
        message = base.message;
      }
    }

    if (response.hasError) {
      return Future.error(
        HiServerError(code ?? -1, message, data: response.body),
      );
    }

    if (base is HiResponse) {
      if (checkCode && code != HiError.okCode) {
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
    if (T == bool && tryBool(data) != null) {
      return Future.value(tryBool(data) as T);
    }
    if (T == double && tryDouble(data) != null) {
      return Future.value(tryDouble(data) as T);
    }
    if (T == int && tryInt(data) != null) {
      return Future.value(tryInt(data) as T);
    }
    if (T == String && tryString(data) != null) {
      return Future.value(tryString(data) as T);
    }
    if (fromJson != null) {
      var model = fromJson(data);
      if (model is HiModel && !(model as HiModel).isValid) {
        return Future.error(HiServerError.dataInvalid);
      }
      return Future.value(model);
    }
    return Future.error(HiServerError.dataInvalid);
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
      return Future.error(HiServerError.dataInvalid);
    }
    // if (data.isEmpty) {
    //   // return Future.error(HiServerError.listIsEmpty);
    //   return Future.value([]);
    // }
    if (fromJson == null) {
      return Future.error(HiError.unknown);
    }
    var array = data.where((e) => e is Map<String, dynamic>)
        .map((json) => fromJson(json))
        .toList();
    // if (array.isEmpty) {
    //   return Future.error(HiServerError.listIsEmpty);
    // }
    return Future.value(array);
  }

}