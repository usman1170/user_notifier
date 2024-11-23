import 'dart:convert';

class UserModel {
  String id;
  String email;
  String date;
  UserModel({
    required this.id,
    required this.email,
    required this.date,
  });

  UserModel copyWith({
    String? id,
    String? email,
    String? date,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'date': date,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? "",
      email: map['email'] ?? "",
      date: map['date'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
