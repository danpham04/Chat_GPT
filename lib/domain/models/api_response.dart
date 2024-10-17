class ApiResponse {
  int statusCode;
  String errorCode;
  String errorField;
  String message;
  dynamic data;
  
  ApiResponse.fromJson(Map<String, dynamic> json)
      : statusCode = json['statusCode'] as int,
        errorCode = json['errorCode'] as String,
        errorField = json['errorField'] as String,
        message = json['message'] as String,
        data = json['data'];
}
