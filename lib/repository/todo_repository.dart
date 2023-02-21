import 'package:firebase_auth/firebase_auth.dart' as fa;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:todo/models/user.dart';

part 'auth_repository.dart';

class TodoRepository {
  TodoRepository._internal();

  static final TodoRepository _todoRepository = TodoRepository._internal();

  factory TodoRepository() {
    return _todoRepository;
  }

  final fa.FirebaseAuth _firebaseAuth = fa.FirebaseAuth.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
}
