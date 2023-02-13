import 'package:get/get.dart';
import 'package:hi_core/hi_core.dart';
import 'response.dart';

class HiService extends GetConnect {
  @override
  void onInit() {
    super.onInit();
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

    httpClient.addRequestModifier<void>((request) {
      log('【${request.method}】${request.url}', tag: HiLogTag.network);
      return request;
    });
    httpClient.addResponseModifier((request, response) {
      log('${request.url.path}(${response.statusCode}, ${response.statusText})\n${response.body}', tag: HiLogTag.network);
      if (response.body is HiResponse) {
        var data = (response.body as HiResponse).data;
        if (data is List<dynamic>) {
          log('items count: ${data.length}', tag: HiLogTag.network);
        }
      }
      log('json: ${response.bodyString}', tag: HiLogTag.network);
      return response;
    });
  }

  // Future<dynamic> result(
  //     Response<dynamic> response, {
  //       bool checkCode = true,
  //       bool returnData = true,
  //     }) {
  //   if (response.hasError) {
  //     return Future.error(
  //       HiServerError(
  //         response.statusCode ?? -1,
  //         response.statusText,
  //         data: response.body,
  //       ),
  //     );
  //   }
  //   var base = response.body as HiResponse;
  //   if (!checkCode) {
  //     // return Future.value(returnData ? base.data : base.json);
  //     // var json = base.json;
  //     return Future.value(base.json);
  //   }
  //   if (base.code != HiError.okCode) {
  //     return Future.error(
  //       HiServerError(
  //         base.code ?? -1,
  //         base.message,
  //         data: base.json,
  //       ),
  //     );
  //   }
  //   return Future.value(base.data);
  // }

  Future<T> object<T>(
      Response<dynamic> response, {
        bool checkCode = true,
        bool returnData = true,
        T Function(Map<String, dynamic>)? fromJson,
      }) {
    if (response.hasError) {
      return Future.error(
        HiServerError(response.statusCode ?? -1, response.statusText, data: response.body),
      );
    }
    var base = response.body;
    if (base is! HiResponse) {
      return Future.error(HiError.unknown);
    }
    var data = base.data;
    if (!checkCode && !returnData) {
      data = base.json;
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
    // if (data is! List) {
    //   return Future.error(HiError.dataInvalid);
    // }
    // if (data.isEmpty) {
    //   return Future.error(HiError.dataIsEmpty);
    // }
    // if (fromJson == null) {
    //   return Future.error(HiError.unknown);
    // }
    // var array = data.where((e) => e is Map<String, dynamic>)
    //     .map((json) => fromJson(json))
    //     .toList();
    // if (array.isEmpty) {
    //   return Future.error(HiError.dataIsEmpty);
    // }
    return Future.error(HiError.dataInvalid);
  }

  Future<List<T>> array<T>(
      Response<dynamic> response, {
        bool checkCode = true,
        bool returnData = true,
        T Function(Map<String, dynamic>)? fromJson,
      }) {
    if (response.hasError) {
      return Future.error(
        HiServerError(response.statusCode ?? -1, response.statusText, data: response.body),
      );
    }
    var base = response.body;
    if (base is! HiResponse) {
      return Future.error(HiError.unknown);
    }
    var data = base.data;
    if (!checkCode) {
      data = base.json;
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

  Future<T> convertTo<T>(Response<dynamic> response) {
    throw UnimplementedError();
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
}