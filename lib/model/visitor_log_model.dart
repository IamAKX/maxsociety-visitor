import 'dart:convert';

class VisitorLogModel {
  int? id;
  int? visitorId;
  String? visitStatus;
  String? block;
  String? flatNo;
  String? type;
  String? residentName;
  String? visitPurpose;
  String? createdOn;
  String? updatedOn;
  VisitorLogModel({
    this.id,
    this.visitorId,
    this.visitStatus,
    this.block,
    this.flatNo,
    this.type,
    this.residentName,
    this.visitPurpose,
    this.createdOn,
    this.updatedOn,
  });

  VisitorLogModel copyWith({
    int? id,
    int? visitorId,
    String? visitStatus,
    String? block,
    String? flatNo,
    String? type,
    String? residentName,
    String? visitPurpose,
    String? createdOn,
    String? updatedOn,
  }) {
    return VisitorLogModel(
      id: id ?? this.id,
      visitorId: visitorId ?? this.visitorId,
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

    if (id != null) {
      result.addAll({'id': id});
    }
    if (visitorId != null) {
      result.addAll({'visitorId': visitorId});
    }
    if (visitStatus != null) {
      result.addAll({'visitStatus': visitStatus});
    }
    if (block != null) {
      result.addAll({'block': block});
    }
    if (flatNo != null) {
      result.addAll({'flatNo': flatNo});
    }
    if (type != null) {
      result.addAll({'type': type});
    }
    if (residentName != null) {
      result.addAll({'residentName': residentName});
    }
    if (visitPurpose != null) {
      result.addAll({'visitPurpose': visitPurpose});
    }
    if (createdOn != null) {
      result.addAll({'createdOn': createdOn});
    }
    if (updatedOn != null) {
      result.addAll({'updatedOn': updatedOn});
    }

    return result;
  }

  factory VisitorLogModel.fromMap(Map<String, dynamic> map) {
    return VisitorLogModel(
      id: map['id']?.toInt(),
      visitorId: map['visitorId']?.toInt(),
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

  factory VisitorLogModel.fromJson(String source) =>
      VisitorLogModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'VisitorLogModel(id: $id, visitorId: $visitorId, visitStatus: $visitStatus, block: $block, flatNo: $flatNo, type: $type, residentName: $residentName, visitPurpose: $visitPurpose, createdOn: $createdOn, updatedOn: $updatedOn)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is VisitorLogModel &&
        other.id == id &&
        other.visitorId == visitorId &&
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
