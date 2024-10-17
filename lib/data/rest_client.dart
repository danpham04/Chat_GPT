import 'package:chat_gpt/app/config/key_constants.dart';
import 'package:chat_gpt/app/helpers/api_error_handler.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class RestClient {
  // base dio 
  late Dio _dio;
  static const optionHeader = {
    'Authorization': 'Bearer $KEY_CHAT',
    'Content-Type': 'application/json',
  };
  
  RestClient ({required String baseUrl}){
    final BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
      headers: optionHeader,
    );
    _dio = Dio(options);

    // dùng thư package dùng để theo dõi trên console xem đã có dữ liệu truyền ra chưa
    _dio.interceptors.add(PrettyDioLogger(
       requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 180
    ),);
  }

  Future<dynamic> post(String path, {Object? data, /// truyền dữ liệu từ ngoài vào vd như ở đây sẽ truyền là                                                  /// data: {'model': 'gpt-3.5-turbo', 'messages': message, },
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onReceiveProgress,}) async{
    try {
      final Response<dynamic> response = await _dio.post(path,data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,);
        return response.data;
    } catch (e) {
      throw mapError(e);
    }
  }
}