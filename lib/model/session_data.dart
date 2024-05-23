import 'dart:convert';

import 'package:ms_register/model/visitor_log_model.dart';
import 'package:ms_register/model/visitor_model.dart';

class SessionData {
  VisitorModel? visitor;
  VisitorLogModel? log;
  SessionData({
    this.visitor,
    this.log,
  });

  SessionData copyWith({
    VisitorModel? visitor,
    VisitorLogModel? log,
  }) {
    return SessionData(
      visitor: visitor ?? this.visitor,
      log: log ?? this.log,
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

    return result;
  }

  factory SessionData.fromMap(Map<String, dynamic> map) {
    return SessionData(
      visitor:
          map['visitor'] != null ? VisitorModel.fromMap(map['visitor']) : null,
      log: map['log'] != null ? VisitorLogModel.fromMap(map['log']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SessionData.fromJson(String source) =>
      SessionData.fromMap(json.decode(source));

  @override
  String toString() => 'SessionData(visitor: $visitor, log: $log)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SessionData && other.visitor == visitor && other.log == log;
  }

  @override
  int get hashCode => visitor.hashCode ^ log.hashCode;
}
