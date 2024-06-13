import 'package:chatter_box/providers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod/riverpod.dart';

final authRepositoryProvider =
Provider<AuthRepository>((ref) => AuthRepository(ref));

abstract class BaseAuthRepository {
  Stream<User?> get authStateChanges;

  Future<void> createUser(String name, String email, String password);

  Future<void> signIn(String email, String password);

  User? getCurrentUser();

  Future<void> signOut();
}

class AuthRepository extends BaseAuthRepository {
  final Ref ref;

  AuthRepository(this.ref);

  @override
  Stream<User?> get authStateChanges =>
      ref.read(firebaseAuthProvider).authStateChanges();

  @override
  User? getCurrentUser() {
    print('user get');
    return ref.read(firebaseAuthProvider).currentUser;
  }

  @override
  Future<void> signIn(String email, String password) async {
    try {
      await ref
          .read(firebaseAuthProvider)
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'INVALID_LOGIN_CREDENTIALS') {

      }
    }
  }

  @override
  Future<void> signOut() async {
    await ref.read(firebaseAuthProvider).signOut();
  }

  @override
  Future<void> createUser(String name, String email, String password) async {
    try {
      final user = await ref
          .read(firebaseAuthProvider)
          .createUserWithEmailAndPassword(email: email, password: password);

      await user.user?.updateDisplayName(name);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {

      } else if (e.code == 'email-already-in-use') {

      }
    }

  }
}
