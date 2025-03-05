class CustomResponse<T> {
  final T? data;
  final int? statusCode;
  final String? message;
  final bool? success;
  final int? total;

  CustomResponse({
    this.data,
    this.statusCode,
    this.message,
    this.success,
    this.total,
  });

  factory CustomResponse.fromJson(Map<String, dynamic> json) {
    return CustomResponse(
      data: json["result"]['items'],
      statusCode: json['statusCode'],
      message: json['error'],
      success: json['success'],
      total: json['totalCount'],
    );
  }

  CustomResponse copyWith(
      {T? data, int? statusCode, String? message, bool? success, int? total}) {
    return CustomResponse(
      data: data ?? this.data,
      statusCode: statusCode ?? this.statusCode,
      message: message ?? this.message,
      success: success ?? this.success,
      total: total ?? this.total,
    );
  }
}

enum CurrentState { initial, loading, success, error }
