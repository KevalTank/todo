part of 'todo_repository.dart';

extension AuthRepository on TodoRepository {
  Future<User> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final fa.UserCredential userCredential =
        await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return User.fromFirebaseAuthUser(authUser: userCredential.user!);
  }

  Future<User> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final fa.UserCredential userCredential = await _firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password);
    return User.fromFirebaseAuthUser(authUser: userCredential.user!);
  }
}
