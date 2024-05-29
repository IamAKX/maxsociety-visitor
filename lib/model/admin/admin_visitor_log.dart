import 'dart:convert';

import 'package:ms_register/model/visitor_model.dart';

class AdminVisitorLog {
  int? id;
  int? visitorId;
  VisitorModel? visitor;
  String? visitStatus;
  String? block;
  String? flatNo;
  String? type;
  String? residentName;
  String? visitPurpose;
  String? createdOn;
  String? updatedOn;
  AdminVisitorLog({
    this.id,
    this.visitorId,
    this.visitor,
    this.visitStatus,
    this.block,
    this.flatNo,
    this.type,
    this.residentName,
    this.visitPurpose,
    this.createdOn,
    this.updatedOn,
  });

  AdminVisitorLog copyWith({
    int? id,
    int? visitorId,
    VisitorModel? visitor,
    String? visitStatus,
    String? block,
    String? flatNo,
    String? type,
    String? residentName,
    String? visitPurpose,
    String? createdOn,
    String? updatedOn,
  }) {
    return AdminVisitorLog(
      id: id ?? this.id,
      visitorId: visitorId ?? this.visitorId,
      visitor: visitor ?? this.visitor,
      visitStatus: visitStatus ?? this.visitStatus,
      block: block ?? this.block,
      flatNo: flatNo ?? this.flatNo,
      type: type ?? this.type,
      residentName: residentName ?? this.residentName,
      visitPurpose: visitPurpose ?? this.visitPurpose,
      createdOn: createdOn ?? this.createdOn,
      updatedOn: updatedOn ?? this.updatedOn,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(id != null){
      result.addAll({'id': id});
    }
    if(visitorId != null){
      result.addAll({'visitorId': visitorId});
    }
    if(visitor != null){
      result.addAll({'visitor': visitor!.toMap()});
    }
    if(visitStatus != null){
      result.addAll({'visitStatus': visitStatus});
    }
    if(block != null){
      result.addAll({'block': block});
    }
    if(flatNo != null){
      result.addAll({'flatNo': flatNo});
    }
    if(type != null){
      result.addAll({'type': type});
    }
    if(residentName != null){
      result.addAll({'residentName': residentName});
    }
    if(visitPurpose != null){
      result.addAll({'visitPurpose': visitPurpose});
    }
    if(createdOn != null){
      result.addAll({'createdOn': createdOn});
    }
    if(updatedOn != null){
      result.addAll({'updatedOn': updatedOn});
    }
  
    return result;
  }

  factory AdminVisitorLog.fromMap(Map<String, dynamic> map) {
    return AdminVisitorLog(
      id: map['id']?.toInt(),
      visitorId: map['visitorId']?.toInt(),
      visitor: map['visitor'] != null ? VisitorModel.fromMap(map['visitor']) : null,
      visitStatus: map['visitStatus'],
      block: map['block'],
      flatNo: map['flatNo'],
      type: map['type'],
      residentName: map['residentName'],
      visitPurpose: map['visitPurpose'],
      createdOn: map['createdOn'],
      updatedOn: map['updatedOn'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AdminVisitorLog.fromJson(String source) => AdminVisitorLog.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AdminVisitorLog(id: $id, visitorId: $visitorId, visitor: $visitor, visitStatus: $visitStatus, block: $block, flatNo: $flatNo, type: $type, residentName: $residentName, visitPurpose: $visitPurpose, createdOn: $createdOn, updatedOn: $updatedOn)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is AdminVisitorLog &&
      other.id == id &&
      other.visitorId == visitorId &&
      other.visitor == visitor &&
      other.visitStatus == visitStatus &&
      other.block == block &&
      other.flatNo == flatNo &&
      other.type == type &&
      other.residentName == residentName &&
      other.visitPurpose == visitPurpose &&
      other.createdOn == createdOn &&
      other.updatedOn == updatedOn;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      visitorId.hashCode ^
      visitor.hashCode ^
      visitStatus.hashCode ^
      block.hashCode ^
      flatNo.hashCode ^
      type.hashCode ^
      residentName.hashCode ^
      visitPurpose.hashCode ^
      createdOn.hashCode ^
      updatedOn.hashCode;
  }
}
