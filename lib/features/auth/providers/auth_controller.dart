import 'dart:async';
import 'package:chatter_box/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod/riverpod.dart';

final authControllerProvider = StateNotifierProvider<AuthController, dynamic>(
        (ref) => AuthController(ref));

class AuthController extends StateNotifier<User?> {
  final Ref ref;
  StreamSubscription<User?>? _authSubscriptionStream;

  AuthController(this.ref) : super(null) {
    _authSubscriptionStream?.cancel();
    _authSubscriptionStream = ref
        .read(authRepositoryProvider)
        .authStateChanges
        .listen((user) => state = user);
  }

  @override
  void dispose() {
    _authSubscriptionStream?.cancel();
    super.dispose();
  }

  void createUser(String name, email, password) async {
    await ref.read(authRepositoryProvider).createUser(name, email, password);
  }

  void signIn(String email, String password) async {
    await ref.read(authRepositoryProvider).signIn(email, password);
  }

  void appStarted() async {
    ref.read(authRepositoryProvider).getCurrentUser();
  }


  void signOut() async {
    await ref.read(authRepositoryProvider).signOut();
  }
}
