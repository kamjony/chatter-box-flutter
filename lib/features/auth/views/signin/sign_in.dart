import 'package:chatter_box/common_widgets/my_textfield.dart';
import 'package:chatter_box/features/auth/providers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';

class SignIn extends HookConsumerWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailTextCtrl = useTextEditingController();
    final passTextCtrl = useTextEditingController();

    final _areFieldsEmpty = useState<bool>(true);

    bool areFieldsEmpty() {
      return emailTextCtrl.text.toString().isEmpty ||
          passTextCtrl.text.toString().isEmpty;
    }

    useEffect(() {
      emailTextCtrl.addListener(() {
        _areFieldsEmpty.value = areFieldsEmpty();
      });
      passTextCtrl.addListener(() {
        _areFieldsEmpty.value = areFieldsEmpty();
      });
      return null;
    }, [
      emailTextCtrl,
      passTextCtrl,
    ]);

    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              'Login to Chatter Box',
              style: TextStyle(fontSize: 22),
            ),
            SizedBox(height: 20),
            MyTextField(label: 'Email', textEditingController: emailTextCtrl),
            SizedBox(height: 20),
            MyTextField(label: 'Password', textEditingController: passTextCtrl),
            SizedBox(height: 20),
            ElevatedButton(
                child: const Text('Login'),
                onPressed: _areFieldsEmpty.value
                    ? null
                    : () {
                        ref.read(authControllerProvider.notifier)
                            .signIn(emailTextCtrl.text, passTextCtrl.text);
                        final user = ref.read(authControllerProvider);
                        if (user != null) {
                          context.go('/home');

                        }
                      }),
          ],
        ),
      ),
    );
  }
}
