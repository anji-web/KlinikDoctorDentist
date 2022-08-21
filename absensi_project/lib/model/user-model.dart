class User {
  final int? statusCode;
  final String token;
  final int? id;
  final String username;
  final String fullname;
  final String nik;
  final List<dynamic> roles;

  const User ({
    required this.statusCode,
    required this.token,
    required this.id,
    required this.username,
    required this.fullname,
    required this.nik,
    required this.roles
});

  factory User.fromJson(Map<String, dynamic> json){
    return User(
        statusCode: json['statusCode'],
        token: json['token'],
        id: json['id'],
        username: json['username'],
        fullname: json['fullname'],
        nik: json['nik'],
        roles: json['roles']);
  }
}