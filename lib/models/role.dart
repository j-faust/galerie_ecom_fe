import 'app_role.dart';

class Role {
  final int roleId;
  final AppRole roleName;

  Role({
    required this.roleId,
    required this.roleName,
  });

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role (
      roleId: json['roleId'],
      roleName: appRoleFromString(json['roleName']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'roleId': roleId,
      'roleName': appRoleToString(roleName),
    };
  }
}