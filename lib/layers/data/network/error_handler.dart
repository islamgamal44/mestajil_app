import 'package:dio/dio.dart';

import 'failure.dart';

class ErrorHandler implements Exception {
  late Failure failure;

  ErrorHandler.handle(dynamic error) {
    if (error is DioError) {
      // dio error its from response of the API or from dio itself
      failure = _handleError(error);
    } else {
      // default error
      failure = DataSource.DEFAULT.getFailure();
    }
  }
}

Failure _handleError(DioError error) {
  switch (error.type) {
    case DioErrorType.connectTimeout:
      return DataSource.CONNECT_TIMEOUT.getFailure();

    case DioErrorType.sendTimeout:
      return DataSource.SEND_TIMEOUT.getFailure();

    case DioErrorType.receiveTimeout:
      return DataSource.RECIEVE_TIMEOUT.getFailure();

    case DioErrorType.response:
      if (error.response != null &&
          error.response?.statusCode != null &&
          error.response?.statusMessage != null) {
        return Failure(error.response?.statusCode ?? 0,
            error.response?.statusMessage ?? "");
      } else {
        return DataSource.DEFAULT.getFailure();
      }
      break;

    case DioErrorType.cancel:
      return DataSource.CANCEL.getFailure();

    case DioErrorType.other:
      return DataSource.DEFAULT.getFailure();
  }
}

enum DataSource {
  SUCCESS,
  NO_CONECT,
  BAD_REQUEST,
  FORBIDDEN,
  UNAUTRISED,
  NOT_FOUND,
  INTERNAL_SERVER_ERROR,
  CONNECT_TIMEOUT,
  CANCEL,
  RECIEVE_TIMEOUT,
  SEND_TIMEOUT,
  CACHE_ERROR,
  NO_INTERNET_CONNECTION,
  UNKOWN,
  DEFAULT,
}

extension DataSourceExtension on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.SUCCESS:
        return Failure(ResponseCode.SUCCESS, ResponseMessage.SUCCESS);

      case DataSource.NO_CONECT:
        return Failure(ResponseCode.NO_CONECT, ResponseMessage.NO_CONECT);

      case DataSource.BAD_REQUEST:
        return Failure(ResponseCode.BAD_REQUEST, ResponseMessage.BAD_REQUEST);

      case DataSource.FORBIDDEN:
        return Failure(ResponseCode.FORBIDDEN, ResponseMessage.FORBIDDEN);

      case DataSource.UNAUTRISED:
        return Failure(ResponseCode.UNAUTRISED, ResponseMessage.UNAUTRISED);

      case DataSource.NOT_FOUND:
        return Failure(ResponseCode.NOT_FOUND, ResponseMessage.NOT_FOUND);

      case DataSource.INTERNAL_SERVER_ERROR:
        return Failure(ResponseCode.INTERNAL_SERVER_ERROR,
            ResponseMessage.INTERNAL_SERVER_ERROR);

      case DataSource.CONNECT_TIMEOUT:
        return Failure(
            ResponseCode.CONNECT_TIMEOUT, ResponseMessage.CONNECT_TIMEOUT);

      case DataSource.CANCEL:
        return Failure(ResponseCode.CANCEL, ResponseMessage.CANCEL);

      case DataSource.RECIEVE_TIMEOUT:
        return Failure(
            ResponseCode.RECIEVE_TIMEOUT, ResponseMessage.RECIEVE_TIMEOUT);

      case DataSource.SEND_TIMEOUT:
        return Failure(ResponseCode.SEND_TIMEOUT, ResponseMessage.SEND_TIMEOUT);

      case DataSource.CACHE_ERROR:
        return Failure(ResponseCode.CACHE_ERROR, ResponseMessage.CACHE_ERROR);

      case DataSource.NO_INTERNET_CONNECTION:
        return Failure(ResponseCode.NO_INTERNET_CONNECTION,
            ResponseMessage.NO_INTERNET_CONNECTION);

      case DataSource.UNKOWN:
        return Failure(ResponseCode.UNKOWN, ResponseMessage.UNKOWN);

      case DataSource.DEFAULT:
        return Failure(ResponseCode.DEFAULT, ResponseMessage.DEFAULT);
    }
  }
}

class ResponseCode {
  static const int SUCCESS = 200; //success with data
  static const int NO_CONECT = 201; // success with no data (no content)
  static const int BAD_REQUEST = 400; // failure , Api rejected request
  static const int FORBIDDEN = 403; // failure , Api rejected request
  static const int UNAUTRISED = 401; // failure , user is not authorised
  static const int NOT_FOUND = 404; // failure , crash in server side
  static const int INTERNAL_SERVER_ERROR = 500;

  //local status code **
  static const int CONNECT_TIMEOUT = -1;
  static const int CANCEL = -2;
  static const int RECIEVE_TIMEOUT = -3;
  static const int SEND_TIMEOUT = -4;
  static const int CACHE_ERROR = -5;
  static const int NO_INTERNET_CONNECTION = -6;
  static const int UNKOWN = -7;
  static const int DEFAULT = -7;
}

class ResponseMessage {
  static const String SUCCESS = "success"; //success with data
  static const String NO_CONECT =
      "success"; // success with no data (no content)
  static const String BAD_REQUEST =
      "bad request try again later"; // failure , Api rejected request
  static const String FORBIDDEN =
      " forbidden bad request try again later"; // failure , Api rejected request
  static const String UNAUTRISED =
      "user is not authorised ,try again later"; // failure , user is not authorised
  static const String NOT_FOUND =
      " Failure ,not found"; // failure , crash in server side
  static const String INTERNAL_SERVER_ERROR =
      "something went wrong , try again later";

  //local status code **
  static const String CONNECT_TIMEOUT = "Time out error , try again  later ";
  static const String CANCEL = "request was canceled , try again later";
  static const String RECIEVE_TIMEOUT = "Time out error , try again  later";
  static const String SEND_TIMEOUT = "Time out error , try again  later";
  static const String CACHE_ERROR = "cache error , try again  later";
  static const String NO_INTERNET_CONNECTION =
      "please check your internet connection";
  static const String UNKOWN = "something went wrong , try again later";
  static const String DEFAULT = "something went wrong , try again later";
}

class ApiHandlerStatus {
  static const int SUCCESS = 0;
  static const int FAILURE = 0;
}

class ApiInternalStatus {
  static const int SUCCESS = 0;
  static const int FAILURE = 0;
}
