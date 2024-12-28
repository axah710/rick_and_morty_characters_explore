import 'dart:math';
import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../exports.dart';
import '../../service_locator.dart';
import '../enums.dart';
import '../models/response_code.dart';
import '../models/response_messages.dart';
import '../network/abstract/failure.dart';
import '../network/app_service.dart';
import '../network/constants/constants.dart';
import '../network/error_handler/error_handler.dart';
import '../network/model/response_model.dart';
import '../network/network_enums.dart';

import 'package:connectivity_plus/connectivity_plus.dart';

import '../utils/debug_prints.dart';
import 'permission_handler.dart';

Map<String, dynamic>? getArguments(BuildContext context) =>
    (ModalRoute.of(context))!.settings.arguments as Map<String, dynamic>?;

double radians(double degrees) => degrees * _degrees2Radians;
const double _degrees2Radians = pi / 180.0;

Widget dialogAnimatedWrapperWidget({
  required Animation<double> animation,
  required Widget child,
  required DialogAnimation dialogAnimation,
  required Curve curve,
}) {
  switch (dialogAnimation) {
    case DialogAnimation.ROTATE:
      return Transform.rotate(
        angle: radians(animation.value * 360),
        child: Opacity(
          opacity: animation.value,
          child: FadeTransition(opacity: animation, child: child),
        ),
      );

    case DialogAnimation.SLIDE_TOP_BOTTOM:
      final curvedValue = curve.transform(animation.value) - 1.0;

      return Transform(
        transform: Matrix4.translationValues(0.0, curvedValue * 300, 0.0),
        child: Opacity(
          opacity: animation.value,
          child: FadeTransition(opacity: animation, child: child),
        ),
      );

    case DialogAnimation.SCALE:
      return Transform.scale(
        scale: animation.value,
        child: FadeTransition(opacity: animation, child: child),
      );

    case DialogAnimation.SLIDE_BOTTOM_TOP:
      return SlideTransition(
        position: Tween(begin: const Offset(0, 1), end: Offset.zero)
            .chain(CurveTween(curve: curve))
            .animate(animation),
        child: Opacity(
          opacity: animation.value,
          child: FadeTransition(opacity: animation, child: child),
        ),
      );

    case DialogAnimation.SLIDE_LEFT_RIGHT:
      return SlideTransition(
        position: Tween(begin: const Offset(1.0, 0.0), end: Offset.zero)
            .chain(CurveTween(curve: curve))
            .animate(animation),
        child: Opacity(
          opacity: animation.value,
          child: FadeTransition(opacity: animation, child: child),
        ),
      );

    case DialogAnimation.SLIDE_RIGHT_LEFT:
      return SlideTransition(
        position: Tween(begin: const Offset(-1, 0), end: Offset.zero)
            .chain(CurveTween(curve: curve))
            .animate(animation),
        child: Opacity(
          opacity: animation.value,
          child: FadeTransition(opacity: animation, child: child),
        ),
      );

    case DialogAnimation.DEFAULT:
      return FadeTransition(opacity: animation, child: child);
  }
}

/// returns true if network is available
PermissionManager permissionManager = ServiceLocator.getIt<PermissionManager>();
Future<bool> checkConnection() async {
  final List<ConnectivityResult> connectivityResult =
      await (Connectivity().checkConnectivity());
  if (connectivityResult.contains(ConnectivityResult.mobile) ||
      (connectivityResult.contains(ConnectivityResult.wifi) ||
          !(connectivityResult.contains(ConnectivityResult.none)))) {
    return true;
  }
  return false;
}

Future<Either<Failure, T>> executeList<T>(Future<T> Function() function) async {
  if (await checkConnection()) {
    try {
      T value = await function.call();
      return Right(value);
    } catch (error) {
      return Left(ErrorHandler().handle(error));
    }
  } else {
    return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
  }
}

Future<dynamic> handleResponse(Response response) async {
  switch (response.statusCode) {
    case ResponseCode.BAD_REQUEST:
    case ResponseCode.UNAUTHORISED:
    case ResponseCode.FORBIDDEN:
    case ResponseCode.NOT_FOUND:
      throw DioException.badResponse(
          statusCode: ResponseCode.BAD_REQUEST,
          requestOptions: response.requestOptions,
          response: response);
    case ResponseCode.CONNECT_TIMEOUT:
      throw DioException.connectionTimeout(
        timeout: ApiConstants.connectTimeOut,
        requestOptions: response.requestOptions,
      );
    case ResponseCode.SEND_TIMEOUT:
      throw DioException.sendTimeout(
        timeout: ApiConstants.sendTimeOut,
        requestOptions: response.requestOptions,
      );
    case ResponseCode.SUCCESS:
      return jsonDecode(response.data.toString());
    default:
      throw Exception(
          'Unexpected response status code: ${response.statusCode}');
  }
}

Future<T> remoteListExecute<T>({
  required Future<Response> request,
  required T Function(Map<String, dynamic> data) fromJsonFunction,
}) async {
  Response response = await request;
  String data = response.data.toString();
  if (response.statusCode == ResponseCode.SUCCESS) {
    Map<String, dynamic> map = jsonDecode(data);
    try {
      return fromJsonFunction(map);
    } catch (error) {
      return fromJsonFunction({
        'code': response.statusCode.toString(),
        'status': false,
        'message': "${error.runtimeType}\n$error",
      });
    }
  } else {
    try {
      return fromJsonFunction(jsonDecode(data));
    } on FormatException {
      return fromJsonFunction({
        'code': response.statusCode.toString(),
        'message': data,
        'status': false,
      });
    }
  }
}

Future<T?> executeWithDialog<T>({
  required Future<Either<Failure, T>> either,
  required String startingMessage,
  Function(String message)? onError,
  required Function(T? data) onSuccess,
  Function()? onStart,
  Future<void> Function(dynamic data)? beforeSuccess,
}) async {
  onStart?.call();
  T? data;
  AppService().showCustomDialog(isAlert: false, message: startingMessage);
  (await either).fold((Failure failure) async {
    var message = failure.message;
    Logger.printError("Failure: $message");
    await AppService().showCustomDialogWithTimer(
      message: message,
      dialogTimingType: DialogTimingTypes.long,
      dialogType: AlertTypes.error,
      onTimeOut: () => onError?.call(message),
    );
  }, (response) async {
    data = response;
    Logger.printInfo("Response: $data");
    if (beforeSuccess != null) {
      await beforeSuccess.call(data);
    }
    await AppService().showCustomDialogWithTimer(
      message: 'Success',
      dialogType: AlertTypes.success,
      onTimeOut: () {
        onSuccess.call(data);
      },
    );
  });
  return data;
}

Future<bool> cacheRemove<T>(
  SharedPreferences sharedPreferences,
  String key,
) async {
  bool isCleared = true;
  if (sharedPreferences.containsKey(key)) {
    isCleared = await sharedPreferences.remove(key);
  }
  return isCleared;
}

Future<T> remoteExecute<T>({
  required Future<Response> request,
  required T Function(Map<String, dynamic> data) fromJsonFunction,
}) async {
  Response response = await request;
  String data = response.data.toString();
  if (response.statusCode == ResponseCode.SUCCESS) {
    Map<String, dynamic> map = jsonDecode(data);
    try {
      return fromJsonFunction(map);
    } catch (error) {
      return fromJsonFunction({
        'code': response.statusCode.toString(),
        'status': false,
        'message': "${error.runtimeType}\n$error",
      });
    }
  } else {
    try {
      return fromJsonFunction(jsonDecode(data));
    } on FormatException {
      return fromJsonFunction({
        'code': response.statusCode.toString(),
        'message': data,
        'status': false,
      });
    }
  }
}

Future<BaseResponseModel> cacheWrite<T>(
  SharedPreferences sharedPreferences,
  String key,
  dynamic data, {
  Function(dynamic data)? afterCaching,
  Map<String, dynamic> Function(dynamic data)? toJson,
}) async {
  bool isCached = false;
  if (toJson != null) {
    List<Map<String, dynamic>> list =
        (data as List).map((e) => toJson(e)).toList();
    isCached = await sharedPreferences.setString(key, jsonEncode(list));
  } else if (data is Map<String, dynamic>) {
    isCached = await sharedPreferences.setString(key, jsonEncode(data));
  } else if (data is bool) {
    isCached = await sharedPreferences.setBool(key, data);
  } else if (data is double) {
    isCached = await sharedPreferences.setDouble(key, data);
  } else if (data is int) {
    isCached = await sharedPreferences.setInt(key, data);
  } else if (data is String) {
    isCached = await sharedPreferences.setString(key, data);
  }
  if (isCached) {
    afterCaching?.call(data);
    return BaseResponseModel(
      code: ResponseCode.CACHE_WRITE_SUCCESS.toString(),
      status: true,
      message: ResponseMessage().CACHE_WRITE_SUCCESS,
      data: isCached,
    );
  } else {
    return BaseResponseModel(
      code: ResponseCode.CACHE_WRITE_ERROR.toString(),
      message: ResponseMessage().CACHE_WRITE_ERROR,
      status: false,
      data: isCached,
    );
  }
}

Future<BaseResponseModel> cacheRead<T>(
  SharedPreferences sharedPreferences,
  String key, {
  T Function(Map<String, dynamic>)? fromJson,
  Function(T?)? afterCaching,
}) async {
  T? saveData;
  if (sharedPreferences.containsKey(key)) {
    if (fromJson != null) {
      String? str = sharedPreferences.getString(key);
      if (str != null) {
        saveData = fromJson(jsonDecode(str));
      }
    } else if (T.toString().contains("bool")) {
      saveData = sharedPreferences.getBool(key) as T;
    } else if (T.toString().contains("double")) {
      saveData = sharedPreferences.getDouble(key) as T;
    } else if (T.toString().contains("int")) {
      saveData = sharedPreferences.getInt(key) as T;
    } else if (T.toString().contains("String")) {
      saveData = sharedPreferences.getString(key) as T;
    }

    if (saveData != null) {
      afterCaching?.call(saveData);
      return BaseResponseModel(
        code: ResponseCode.CACHE_READ_SUCCESS.toString(),
        status: true,
        message: ResponseMessage().CACHE_READ_SUCCESS,
        data: saveData,
      );
    } else {
      return BaseResponseModel(
        code: ResponseCode.CACHE_READ_ERROR.toString(),
        status: false,
        message: ResponseMessage().CACHE_READ_ERROR,
      );
    }
  } else {
    return BaseResponseModel(
      code: ResponseCode.NOT_FOUND_IN_CACHE.toString(),
      status: true,
      message: ResponseMessage().NOT_FOUND_IN_CACHE,
    );
  }
}

// Future<Either<Failure, BaseResponseModel>> executeCache<T>(
//   Future<BaseResponseModel> Function() local,
// ) async {
//   BaseResponseModel response = await local.call();
//   if (response.status == true) {
//     return Right(response);
//   } else {
//     return Left(
//         Failure(int.parse(response.code ?? '0'), response.message ?? ''));
//   }
// }

Future<BaseResponseModel?> managerExecute<T>(
  Future<Either<Failure, BaseResponseModel>> either, {
  Function(BaseResponseModel? data)? onSuccess,
  Function()? onStart,
  Function(String message)? onFail,
}) async {
  BaseResponseModel? data;
  onStart?.call();
  (await either).fold((Failure failure) {
    Logger.printError(failure.message);

    onFail?.call(failure.message);
  }, (BaseResponseModel value) {
    Logger.printInfo(value.message ?? 'No message');
    Logger.printInfo(value.data);
    data = value;
    onSuccess?.call(data);
  });
  return data;
}

Future<Either<Failure, BaseResponseModel>> execute<T>(
  Future<BaseResponseModel> Function() remote, {
  Future<BaseResponseModel> Function(dynamic data)? local,
}) async {
  if (await checkConnection()) {
    try {
      BaseResponseModel value = await remote.call();
      if (value.isNotNull) {
        // if (local != null) {
        // BaseResponseModel localResponse = await local.call(value.data);
        // if (!localResponse.status) {
        //   return Left(
        //     Failure(ResponseCode.CACHE_WRITE_ERROR, ResponseMessage().CACHE_WRITE_ERROR),
        //   );
        // }
        // }
        return Right(value);
      } else {
        return Left(
          Failure(int.parse(value.code!), value.message ?? 'Unknown erro'),
        );
      }
    } catch (error) {
      return Left(ErrorHandler().handle(error));
    }
  } else {
    return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
  }
}

Future showProgressDialog(
  BuildContext context, {
  String? message,
  Widget? child,
  Color? barrierColor,
  Color progressColor = AppColors.white,
  bool dismissible = false,
}) =>
    showDialog(
      context: context,
      barrierColor: barrierColor,
      barrierDismissible: dismissible,
      builder: (context) {
        return AlertDialog(
          elevation: 0,
          backgroundColor: AppColors.transparent,
          alignment: Alignment.center,
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  height: 60,
                  width: 60,
                  child: CircularProgressIndicator(
                    color: progressColor,
                    strokeWidth: 7,
                  )),
            ],
          ),
        );
      },
    );

get hideKeyboard => FocusManager.instance.primaryFocus?.unfocus();

int getDistance(int distance) {
  if (distance > 1000) {
    final kilometerDistance = (distance / 1000.0).roundToDouble().toInt();
    return kilometerDistance;
  } else if (distance > 0) {
    return distance;
  } else {
    return 0;
  }
}

int convertToMinutes(int seconds) {
  int minutes = seconds ~/ 60;
  int secondsRemaining = seconds % 60;
  if (secondsRemaining > 0) {
    minutes++;
  }
  return minutes;
}
