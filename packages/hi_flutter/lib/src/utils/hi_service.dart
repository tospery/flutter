import 'package:hi_flutter/hi_flutter.dart';

class HiService extends GetConnect {
  @override
  void onInit() {
    super.onInit();
    httpClient.defaultDecoder = (data) {
      var json = data as Map<String, dynamic>? ??
          {
            HiParameter.code: HiError.okCode,
            HiParameter.data: data,
          };
      return HiResponse.fromJson(json);
    };

    httpClient.addRequestModifier<void>((request) {
      log('【${request.method}】${request.url}');
      return request;
    });
    httpClient.addResponseModifier((request, response) {
      log('${request.url.path}(${response.statusCode}, ${response.statusText})\n${response.body}');
      return response;
    });
  }

  Future<dynamic> result(
    Response<dynamic> response, {
    bool checkCode = true,
    bool returnData = true,
  }) {
    if (response.hasError) {
      return Future.error(
        HiServerError(
          response.statusCode ?? -1,
          response.statusText,
          data: response.body,
        ),
      );
    }
    var base = response.body as HiResponse;
    if (!checkCode) {
      return Future.value(returnData ? base.data : base.json);
    }
    if (base.code != HiError.okCode) {
      return Future.error(
        HiServerError(
          base.code ?? -1,
          base.message,
          data: base.json,
        ),
      );
    }
    return Future.value(base.data);
  }

  // Future<dynamic> getData(Response<dynamic> response) {
  //   if (response.hasError) {
  //     return Future.error(
  //       HiServerError(
  //         response.statusCode ?? -1,
  //         response.statusText,
  //         data: response.body,
  //       ),
  //     );
  //   }
  //   var base = response.body;
  //   if (base is! HiResponse) {
  //     throw HiError.unknown;
  //   }
  //   return Future.value(base.data);
  // }

  Future<T> convertTo<T>(Response<dynamic> response) {
    throw UnimplementedError();
  }
}
