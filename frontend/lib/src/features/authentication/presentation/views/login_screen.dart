import 'package:dialink/src/config/router/route_names.dart';
import 'package:dialink/src/core/core.dart';
import 'package:dialink/src/core/utils/extensions.dart';
import 'package:dialink/src/widgets/custom_textfield.dart';
import 'package:dialink/src/widgets/custom_scaffold.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    _form.currentState?.dispose();
    AppConstants.instance.closeKeyboard();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: Form(
        key: _form,
        child: Column(
          children: [
            Center(
              child: Text(
                "Login",
                style: context.textTheme.displaySmall!.copyWith(
                  fontFamily: AppConstants.instance.cooperBtFont,
                ),
              ),
            ),
            4.0.verticalSpacing,
            Text(
              "Log in to access your appointments",
              textAlign: TextAlign.center,
              style: context.textTheme.titleLarge,
            ),
            48.0.verticalSpacing,
            CustomTextfield(
              label: "Email",
              hint: "Email address",
              controller: email,
            ),
            CustomPasswordTextfield(
              label: "Password",
              hint: "Password",
              controller: password,
            ),
            16.0.verticalSpacing,
            TextButton(
              onPressed: () => context.router
                  .pushNamedAndRemoveUntil(RouteName.home, (route) => false),
              child: Text("Login"),
            ),
            Spacer(),
            Text.rich(
              TextSpan(
                text: "Don't have an account? ",
                children: [
                  TextSpan(
                    text: "Create account",
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        HapticFeedback.heavyImpact();
                        context.router.popAndPushNamed(RouteName.signup);
                      },
                    style: context.textTheme.titleMedium!
                        .copyWith(color: AppColors.primary),
                  ),
                ],
              ),
              style: context.textTheme.titleSmall,
            )
          ],
        ),
      ),
    );
  }
}
