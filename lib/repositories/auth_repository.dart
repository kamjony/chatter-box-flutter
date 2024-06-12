import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

abstract class BaseAuthRepository {
  Stream<User?> get authStateChanges;
  Future<void> signIn();
  User? getCurrentUser();
  Future<void> signOut();
}

class AuthRepository extends BaseAuthRepository {
  final Ref ref;

  AuthRepository(this.ref);

  @override
  Stream<User?> get authStateChanges => throw UnimplementedError();

  @override
  User? getCurrentUser() {
    throw UnimplementedError();
  }

  @override
  Future<void> signIn() {
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() {
    throw UnimplementedError();
  }

}