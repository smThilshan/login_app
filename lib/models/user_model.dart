class UserModel {
  final String username;
  final String password;

  UserModel({
    required this.username,
    required this.password,
  });

  // Factory constructor to create a UserModel instance from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      username: json['Company_Code'],
      password: json['Pw'],
    );
  }

  // Method to convert UserModel instance to a Map for SQLite
  Map<String, dynamic> toMap() {
    return {
      'Company_Code': username,
      'Pw': password,
    };
  }
}
