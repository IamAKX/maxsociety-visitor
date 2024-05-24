import 'dart:convert';

class ErrorModel {
  String? message;
  ErrorModel({
    this.message,
  });

  ErrorModel copyWith({
    String? message,
  }) {
    return ErrorModel(
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (message != null) {
      result.addAll({'message': message});
    }

    return result;
  }

  factory ErrorModel.fromMap(Map<String, dynamic> map) {
    return ErrorModel(
      message: map['message'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ErrorModel.fromJson(String source) =>
      ErrorModel.fromMap(json.decode(source));

  @override
  String toString() => 'ErrorModel(message: $message)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ErrorModel && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
