import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_util/flutter_util.dart';

class SignInBox extends StatefulWidget {
  final void Function(String) onError;
  final void Function() onConfirm;
  const SignInBox({super.key, required this.onError, required this.onConfirm});
  @override
  State<SignInBox> createState() => SignInBoxState();
}

class SignInBoxState extends State<SignInBox> {
  final TextEditingController txtCtrlEmail = TextEditingController();
  final TextEditingController txtCtrlPass = TextEditingController();
  Map errors = {
    'email': {'code': null},
    'password': {'code': null}
  };

  @override
  initState() {
    super.initState();
    initData();
  }

  Future<void> initData() async {
    await JsonValidator().loadSchemas(['assets/schema/json_schema.json']);
  }

  bool _isPasswordVisible = false;

  void submit() {
    Map inputData = {'email': txtCtrlEmail.text, 'password': txtCtrlPass.text};
    Map validateRes = JsonValidator().validate('emailPassWord', inputData);
    debugPrint('validateRes:\n$validateRes');
    setState(() {
      errors = validateRes['errors'];
    });
    if (validateRes['allValid']) {
      //process sign in logic
    }
  }

  @override
  Widget build(BuildContext context) {
    const h20 = SizedBox(height: 20);
    return Column(
      children: [
        TextField(
          key: const Key('txt_email'),
          controller: txtCtrlEmail,
          decoration: InputDecoration(labelText: 'Email', errorText: errors['email']['code']),
        ),
        h20,
        TextField(
          key: const Key('txt_password'),
          controller: txtCtrlPass,
          decoration: InputDecoration(
            labelText: 'Password',
            suffixIcon: IconButton(
              icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off),
              onPressed: () {
                setState(() => _isPasswordVisible = !_isPasswordVisible);
              },
            ),
            errorText: errors['password']['code'],
          ),
          obscureText: !_isPasswordVisible,
        ),
        h20,
        ElevatedButton(
          key: const Key('btn_confirm'),
          onPressed: submit,
          style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 36)),
          child: const Text('Sign In'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    txtCtrlEmail.dispose();
    txtCtrlPass.dispose();
    super.dispose();
  }
}
