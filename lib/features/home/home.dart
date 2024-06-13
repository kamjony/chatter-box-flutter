import 'package:chatter_box/features/auth/providers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Home extends HookConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chatter Box'),
      ),
      body: Container(
          color: Colors.red,
          child: Center(
              child: ElevatedButton(
                  child: const Text('sign out'), onPressed: () {
                    ref.read(authControllerProvider.notifier).signOut();
                    context.go('/signin');

              }))),
    );
  }
}
