import 'dart:convert';

import 'package:ms_register/model/visitor_log_model.dart';
import 'package:ms_register/model/visitor_model.dart';

class SessionData {
  VisitorModel? visitor;
  VisitorLogModel? log;
  bool? isNewUser;
  SessionData({
    this.visitor,
    this.log,
    this.isNewUser,
  });

  SessionData copyWith({
    VisitorModel? visitor,
    VisitorLogModel? log,
    bool? isNewUser,
  }) {
    return SessionData(
      visitor: visitor ?? this.visitor,
      log: log ?? this.log,
      isNewUser: isNewUser ?? this.isNewUser,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (visitor != null) {
      result.addAll({'visitor': visitor!.toMap()});
    }
    if (log != null) {
      result.addAll({'log': log!.toMap()});
    }
    if (isNewUser != null) {
      result.addAll({'isNewUser': isNewUser});
    }

    return result;
  }

  factory SessionData.fromMap(Map<String, dynamic> map) {
    return SessionData(
      visitor:
          map['visitor'] != null ? VisitorModel.fromMap(map['visitor']) : null,
      log: map['log'] != null ? VisitorLogModel.fromMap(map['log']) : null,
      isNewUser: map['isNewUser'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SessionData.fromJson(String source) =>
      SessionData.fromMap(json.decode(source));

  @override
  String toString() =>
      'SessionData(visitor: $visitor, log: $log, isNewUser: $isNewUser)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SessionData &&
        other.visitor == visitor &&
        other.log == log &&
        other.isNewUser == isNewUser;
  }

  @override
  int get hashCode => visitor.hashCode ^ log.hashCode ^ isNewUser.hashCode;
}
