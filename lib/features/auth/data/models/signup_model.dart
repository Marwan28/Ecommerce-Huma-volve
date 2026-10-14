import 'package:ecommerce_app_huma_volve/features/auth/domain/entities/signup_entity.dart';

class SignupModel extends SignupEntity {
  SignupModel({
    super.id,
    super.email,
    super.password,
    super.name,
    super.role,
    super.avatar,
    super.creationAt,
    super.updatedAt,
  });

  factory SignupModel.fromJson(Map<String, dynamic> json) {
    return SignupModel(
      id: json['id'] as num?,
      email: json['email'] as String?,
      name: json['name'] as String?,
      role: json['role'] as String?,
      avatar: json['avatar'] as String?,
      creationAt: json['creationAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['email'] = email;
    map['password'] = password;
    map['name'] = name;
    map['role'] = role;
    map['avatar'] = avatar;
    map['creationAt'] = creationAt;
    map['updatedAt'] = updatedAt;
    return map;
  }
  SignupEntity toEntity() {
    return SignupEntity(
      id: id,
      email: email,
      name: name,
      role: role,
      avatar: avatar,
      creationAt: creationAt,
      updatedAt: updatedAt,
    );
  }
}
