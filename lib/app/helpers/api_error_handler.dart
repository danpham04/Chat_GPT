import 'package:chat_gpt/data/repositories/api_error.dart';
import 'package:dio/dio.dart';

ApiError mapError(dynamic e) {
  // custom mã lỗi
  if (e is DioException) {
    switch (e.type) {
      // lỗi kết nối đến sever
      case DioExceptionType.connectionTimeout:
        return ApiError(
            errorCode: "CONNECT_TIMEOUT", message: 'Có lỗi kết nối đến server');
      // lỗi quá thời gian gửi đến sever
      case DioExceptionType.sendTimeout:
        return ApiError(
            errorCode: "SEND_TIMEOUT", message: 'Có lỗi gửi dữ liệu đến server');
      // lỗi nhận dữ liệu từ sever
      case DioExceptionType.receiveTimeout:
        return ApiError(
            errorCode: "RECEIVE_TIMEOUT", message: 'Có lỗi nhận dữ liệu từ server');

      // các mã lỗi khác
      case DioExceptionType.badResponse:
      // data khác null và trả về một cục data là một map
        if (e.response?.data != null && e.response?.data is Map) {
          String code = '';
          try {
            dynamic errorData = e.response!.data;
            code = errorData["code"];
            // kiểm tra mã của data trả về là gì
            if (code == '404') {
              return ApiError(
                errorCode: code,
                message: 'Không có dữ liệu',
                extraData: e.response?.data,
              );
            }
            //.......
          } catch (error) {
            return ApiError(
              // in ra mã lỗi 
              errorCode: code,
              message: 'Có lỗi đã xảy ra',
              extraData: e.response?.data,
            );
          }
        } else {
          return ApiError(
            errorCode: 'Không xác định',
            message: 'Có lỗi đã xảy ra',
            extraData: e.response?.data,
          );
        }
      default:
    }
  }

  return ApiError(extraData: e);
}