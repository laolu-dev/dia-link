import 'package:dialink/src/config/router/route_names.dart';
import 'package:dialink/src/core/utils/constants.dart';
import 'package:dialink/src/core/utils/enums.dart';
import 'package:dialink/src/core/utils/extensions.dart';
import 'package:dialink/src/widgets/custom_textfield.dart';
import 'package:dialink/src/widgets/custom_dropdown.dart';
import 'package:dialink/src/widgets/custom_scaffold.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController firstname = TextEditingController();
  final TextEditingController lastname = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController gender = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();

  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  @override
  void dispose() {
    firstname.dispose();
    lastname.dispose();
    email.dispose();
    gender.dispose();
    password.dispose();
    confirmPassword.dispose();
    _form.currentState?.dispose();
    AppConstants.instance.closeKeyboard();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      makeScrollable: true,
      child: Form(
        key: _form,
        child: Column(
          children: [
            Center(
              child: Text(
                "Sign up",
                style: context.textTheme.displaySmall!.copyWith(
                  fontFamily: AppConstants.instance.cooperBtFont,
                ),
              ),
            ),
            4.0.verticalSpacing,
            Text(
              "Create an account with us.",
              style: context.textTheme.titleLarge,
            ),
            48.0.verticalSpacing,
            Row(
              spacing: 12,
              children: [
                Flexible(
                  child: CustomTextfield(
                    label: "First Name",
                    hint: "Enter first name",
                    controller: firstname,
                  ),
                ),
                Flexible(
                  child: CustomTextfield(
                    label: "Last Name",
                    hint: "Enter last name",
                    controller: lastname,
                  ),
                ),
              ],
            ),
            Row(
              spacing: 12,
              children: [
                Flexible(
                  flex: 2,
                  child: CustomTextfield(
                    label: "Phone number",
                    hint: "Enter phone number",
                    controller: lastname,
                  ),
                ),
                Flexible(
                  child: CustomDropdown(
                    label: "Gender",
                    hint: "Select Gender",
                    controller: gender,
                    options:
                        Gender.values.map((value) => value.gender).toList(),
                  ),
                ),
              ],
            ),
            CustomTextfield(
              label: "Email",
              hint: "Enter your email address",
              controller: email,
            ),
            CustomPasswordTextfield(
              label: "Password",
              hint: "Enter password",
              controller: password,
            ),
            CustomPasswordTextfield(
              label: "Confirm password",
              hint: "Re-enter password",
              controller: confirmPassword,
            ),
            16.0.verticalSpacing,
            TextButton(
              onPressed: () => context.router
                  .pushNamed(RouteName.verify, arguments: email.text),
              child: Text("Create Account"),
            ),
            74.0.verticalSpacing,
            Text.rich(
              TextSpan(
                text: "Already have an account? ",
                children: [
                  TextSpan(
                    text: "Login",
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        HapticFeedback.heavyImpact();
                        context.router.popAndPushNamed(RouteName.login);
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
