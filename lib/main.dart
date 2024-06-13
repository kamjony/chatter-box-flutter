import 'package:chatter_box/features/auth/providers/auth_controller.dart';
import 'package:chatter_box/features/auth/views/signin/sign_in.dart';
import 'package:chatter_box/features/home/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authControllerProvider);

    final GoRouter _router = GoRouter(
        initialLocation: '/',
        routes: [
          GoRoute(path: '/', builder: (context, state) => user == null ? SignIn() : Home()),
          GoRoute(path: '/signin', builder: (context, state) => SignIn()),
          GoRoute(path: '/home', builder: (context, state) => Home()),
        ]);

    return MaterialApp.router(
      title: 'Chatter Box',
      routerConfig: _router,
      theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)

      ),
    );
  }

}
