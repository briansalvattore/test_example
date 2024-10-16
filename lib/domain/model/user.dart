import 'package:brian_test/domain/domain_extensions.dart';

class User {
  User._({
    required this.id,
    required this.fullName,
    required this.email,
    required this.photoUrl,
  });

  User.empty()
      : id = '',
        fullName = '',
        email = '',
        photoUrl = '';

  final String id;
  final String fullName;
  final String email;
  final String photoUrl;

  @override
  String toString() {
    return 'User'
        '{id: $id, fullName: $fullName, email: $email}';
  }

  // ignore: prefer_constructors_over_static_methods
  static User fromJson(Map<String, dynamic> value) {
    return User._(
      id: value.getString('id'),
      fullName: value.getString('fullName'),
      email: value.getString('email'),
      photoUrl: value.getString('photoUrl'),
    );
  }

  bool get isValidPhoto => photoUrl.isNotEmpty;

  bool get isEmpty => id.isEmpty;
}
