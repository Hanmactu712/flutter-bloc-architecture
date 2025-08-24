part of 'login_page_cubit.dart';

// sealed class LoginState extends Equatable {
//   const LoginState();

//   @override
//   List<Object> get props => [];
// }

class LoginState extends Equatable {
  final FormzSubmissionStatus status;
  final EmailInput email;
  final PasswordInput password;
  final bool isValid;
  final bool isLoading;
  final AuthIdentity? identity;
  const LoginState({
    required this.email,
    required this.password,
    this.isValid = false,
    this.isLoading = false,
    this.status = FormzSubmissionStatus.initial,
    this.identity,
  });

  //copy with
  LoginState copyWith({EmailInput? email, PasswordInput? password, bool? isValid, bool? isLoading, FormzSubmissionStatus? status, AuthIdentity? identity}) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      isValid: isValid ?? this.isValid,
      isLoading: isLoading ?? this.isLoading,
      status: status ?? this.status,
      identity: identity ?? this.identity,
    );
  }

  //defaul value
  const LoginState.initial()
    : email = const EmailInput.pure(),
      password = const PasswordInput.pure(),
      isValid = false,
      isLoading = false,
      status = FormzSubmissionStatus.initial,
      identity = null;

  @override
  List<Object?> get props => [email, password, isValid, isLoading, status, identity];
}

enum EmailValidationError { empty, invalid }

class EmailInput extends FormzInput<String, EmailValidationError> {
  const EmailInput.pure() : super.pure('');
  const EmailInput.dirty([super.value = '']) : super.dirty();

  @override
  EmailValidationError? validator(String value) {
    if (value.isEmpty) return EmailValidationError.empty;
    //check if email is valid format
    var emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) return EmailValidationError.invalid;
    return null;
  }
}

enum PasswordValidationError { empty }

class PasswordInput extends FormzInput<String, PasswordValidationError> {
  const PasswordInput.pure() : super.pure('');
  const PasswordInput.dirty([super.value = '']) : super.dirty();

  @override
  PasswordValidationError? validator(String value) {
    if (value.isEmpty) return PasswordValidationError.empty;
    return null;
  }
}
