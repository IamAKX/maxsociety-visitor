import 'dart:convert';

class VisitorModel {
  int? id;
  String? visitorName;
  String? mobileNo;
  String? email;
  String? flatNo;
  String? imagePath;
  String? createdOn;
  String? updatedOn;
  VisitorModel({
    this.id,
    this.visitorName,
    this.mobileNo,
    this.email,
    this.flatNo,
    this.imagePath,
    this.createdOn,
    this.updatedOn,
  });

  VisitorModel copyWith({
    int? id,
    String? visitorName,
    String? mobileNo,
    String? email,
    String? flatNo,
    String? imagePath,
    String? createdOn,
    String? updatedOn,
  }) {
    return VisitorModel(
      id: id ?? this.id,
      visitorName: visitorName ?? this.visitorName,
      mobileNo: mobileNo ?? this.mobileNo,
      email: email ?? this.email,
      flatNo: flatNo ?? this.flatNo,
      imagePath: imagePath ?? this.imagePath,
      createdOn: createdOn ?? this.createdOn,
      updatedOn: updatedOn ?? this.updatedOn,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(id != null){
      result.addAll({'id': id});
    }
    if(visitorName != null){
      result.addAll({'visitorName': visitorName});
    }
    if(mobileNo != null){
      result.addAll({'mobileNo': mobileNo});
    }
    if(email != null){
      result.addAll({'email': email});
    }
    if(flatNo != null){
      result.addAll({'flatNo': flatNo});
    }
    if(imagePath != null){
      result.addAll({'imagePath': imagePath});
    }
    if(createdOn != null){
      result.addAll({'createdOn': createdOn});
    }
    if(updatedOn != null){
      result.addAll({'updatedOn': updatedOn});
    }
  
    return result;
  }

  factory VisitorModel.fromMap(Map<String, dynamic> map) {
    return VisitorModel(
      id: map['id']?.toInt(),
      visitorName: map['visitorName'],
      mobileNo: map['mobileNo'],
      email: map['email'],
      flatNo: map['flatNo'],
      imagePath: map['imagePath'],
      createdOn: map['createdOn'],
      updatedOn: map['updatedOn'],
    );
  }

  String toJson() => json.encode(toMap());

  factory VisitorModel.fromJson(String source) => VisitorModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'VisitorModel(id: $id, visitorName: $visitorName, mobileNo: $mobileNo, email: $email, flatNo: $flatNo, imagePath: $imagePath, createdOn: $createdOn, updatedOn: $updatedOn)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is VisitorModel &&
      other.id == id &&
      other.visitorName == visitorName &&
      other.mobileNo == mobileNo &&
      other.email == email &&
      other.flatNo == flatNo &&
      other.imagePath == imagePath &&
      other.createdOn == createdOn &&
      other.updatedOn == updatedOn;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      visitorName.hashCode ^
      mobileNo.hashCode ^
      email.hashCode ^
      flatNo.hashCode ^
      imagePath.hashCode ^
      createdOn.hashCode ^
      updatedOn.hashCode;
  }
}
