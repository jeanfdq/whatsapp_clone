import 'dart:convert';

class Account {

   String id;
   String name;
   String email;
   String imageProfile;
   String password;

  Account({
    required this.id,
    required this.name,
    required this.email,
    required this.imageProfile,
    required this.password,
  });


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'imageProfile': imageProfile
    };
  }

  factory Account.fromMap(Map<String, dynamic> map) {
    return Account(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      imageProfile: map['imageProfile'] ?? '',
      password: map['password'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Account.fromJson(String source) => Account.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Account(id: $id, name: $name, email: $email, imageProfile: $imageProfile, password: $password)';
  }
}
