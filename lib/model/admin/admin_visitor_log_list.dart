import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'admin_visitor_log.dart';

class AdminVisitorLogList {
  bool? success;
  String? message;
  List<AdminVisitorLog>? data;
  AdminVisitorLogList({
    this.success,
    this.message,
    this.data,
  });

  AdminVisitorLogList copyWith({
    bool? success,
    String? message,
    List<AdminVisitorLog>? data,
  }) {
    return AdminVisitorLogList(
      success: success ?? this.success,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (success != null) {
      result.addAll({'success': success});
    }
    if (message != null) {
      result.addAll({'message': message});
    }
    if (data != null) {
      result.addAll({'data': data!.map((x) => x?.toMap()).toList()});
    }

    return result;
  }

  factory AdminVisitorLogList.fromMap(Map<String, dynamic> map) {
    return AdminVisitorLogList(
      success: map['success'],
      message: map['message'],
      data: map['data'] != null
          ? List<AdminVisitorLog>.from(
              map['data']?.map((x) => AdminVisitorLog.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AdminVisitorLogList.fromJson(String source) =>
      AdminVisitorLogList.fromMap(json.decode(source));

  @override
  String toString() =>
      'AdminVisitorLogList(success: $success, message: $message, data: $data)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AdminVisitorLogList &&
        other.success == success &&
        other.message == message &&
        listEquals(other.data, data);
  }

  @override
  int get hashCode => success.hashCode ^ message.hashCode ^ data.hashCode;
}
