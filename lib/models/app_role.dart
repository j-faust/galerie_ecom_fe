
enum AppRole {
  ROLE_USER,
  ROLE_SELLER,
  ROLE_ADMIN,
}

AppRole appRoleFromString(String role) {
  return AppRole.values.firstWhere(
    (e) => e.toString().split('.').last == role,
    orElse: () => AppRole.ROLE_USER
  );
}

String appRoleToString(AppRole role) {
  return role.toString().split('.').last;
}