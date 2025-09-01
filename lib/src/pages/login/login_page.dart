import 'package:app_auth/app_auth.dart';
import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_architecture_template/src/components/layouts/layouts.dart';
import 'package:flutter_bloc_architecture_template/src/localization/app_localizations.dart';
import 'package:flutter_bloc_architecture_template/src/pages/login/cubit/login_page_cubit.dart';
import 'package:formz/formz.dart';

class LoginPage extends StatelessWidget {
  final Function onSuccess;
  final String? failedMessage;

  const LoginPage({super.key, required this.onSuccess, this.failedMessage});

  static RouterItem routeItem = RouterItem(name: "login", path: "/login");

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return BlocProvider(
      create: (context) => LoginCubit(authService: context.read<IAuthService>()),
      child: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state.status == FormzSubmissionStatus.success && state.identity != null) {
            SnackBarUtils.showSnackBar(context, locale.loginSuccess, type: MessageType.success);
            onSuccess();
          } else if (state.status == FormzSubmissionStatus.failure) {
            SnackBarUtils.showSnackBar(context, locale.loginFailed, type: MessageType.error);
          }
        },
        child: AdaptiveLayout(
          body: AdaptiveLayoutConfig(
            compactScreen: BlocBuilder<LoginCubit, LoginState>(
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.all(28.0),
                  child: Column(
                    spacing: 28,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            Expanded(child: FittedBox(fit: BoxFit.scaleDown, child: WelcomeLogo(locale: locale))),
                            Expanded(child: LoginForm(state: state)),
                          ],
                        ),
                        // child: SizedBox(),
                      ),
                    ],
                  ),
                );
              },
            ),
            mediumScreen: BlocBuilder<LoginCubit, LoginState>(
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.all(28.0),
                  child: Column(
                    spacing: 28,
                    children: [
                      Expanded(
                        child: AppListView(
                          columnConfig: const LayoutConfig(compactScreen: 2),
                          children: [WelcomeLogo(locale: locale), LoginForm(state: state)],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  final LoginState state;
  const LoginForm({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: AppListView(
        gapConfig: LayoutConfig(compactScreen: 16.0, mediumScreen: 32.0),
        children: [
          AppTextField(
            label: "Email",
            onChanged: (value) => context.read<LoginCubit>().changeUser(value),
            onEditingComplete: () {
              context.read<LoginCubit>().changeUser(state.email.value);
            },
            errorText:
                !state.email.isPure
                    ? (state.email.error == EmailValidationError.empty
                        ? "Please input email."
                        : state.email.error == EmailValidationError.invalid
                        ? "Invalid email."
                        : null)
                    : null,
          ),
          AppTextField(
            label: "Password",
            value: state.password.value,
            obscureText: true,
            onChanged: (value) => context.read<LoginCubit>().changePassword(value),
            onEditingComplete: () {
              context.read<LoginCubit>().changePassword(state.password.value);
            },
            errorText:
                !state.password.isPure
                    ? state.password.error == PasswordValidationError.empty
                        ? "Please input password."
                        : null
                    : null,
          ),
          AppButton(
            width: double.infinity,
            text: "Login",
            height: 50,
            type: "primary",
            onPressed:
                state.isValid
                    ? () {
                      context.read<LoginCubit>().login();
                    }
                    : null,
          ),
        ],
      ),
    );
  }
}

class WelcomeLogo extends StatelessWidget {
  const WelcomeLogo({super.key, required this.locale});

  final AppLocalizations locale;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          AppText(text: locale.welcomeMessage, style: context.headlineSmall),
          const SizedBox(height: 24),
          const SizedBox(height: 120, child: AppLogo()),
          const SizedBox(height: 12),
          AppText(
            text: locale.appTitle,
            isFit: false,
            style: context.headlineSmall!.copyWith(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.w900, fontSize: 48),
          ),
        ],
      ),
    );
  }
}
