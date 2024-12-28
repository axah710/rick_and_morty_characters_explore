class BaseResponseModel {
  final String? code;
  final bool? status;
  final String? message;
  final dynamic data;

  BaseResponseModel({
    this.code,
    this.status,
    this.message,
    this.data,
  });

  factory BaseResponseModel.fromJson(Map<String, dynamic> json) {
    return BaseResponseModel(
      code: json['code'] as String?,
      status: json['status'] as bool?,
      message: json['message'] as String?,
      data: json['data'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code ?? '',
      'status': status ?? false,
      'message': message ?? '',
      'data': data,
    };
  }
}
