import 'package:firebase_auth/firebase_auth.dart' as fa;

class User {
  const User({
    this.id = '',
    this.name = '',
    this.email = '',
    this.phoneNumber = '',
    this.address = '',
    this.aboutMe = '',
  });

  final String id;
  final String name;
  final String email;
  final String phoneNumber;
  final String address;
  final String aboutMe;

  static const empty = User(
    name: '',
    email: '',
    phoneNumber: '',
    address: '',
    aboutMe: '',
  );

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? phoneNumber,
    String? address,
    String? aboutMe,
  }) {
    return User(
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      aboutMe: aboutMe ?? this.aboutMe,
    );
  }

  factory User.fromFirebaseAuthUser({required fa.User authUser}) {
    return empty.copyWith(
      id: authUser.uid,
      name: authUser.displayName ?? '',
      email: authUser.email ?? '',
      phoneNumber: authUser.phoneNumber ?? '',
      address: '',
      aboutMe: '',
    );
  }
}
