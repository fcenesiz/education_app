import 'package:education_app/core/usecases/usecases.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/auth/domain/repos/auth_repo.dart';
import 'package:equatable/equatable.dart';

class SignUp extends UsecaseWithParams<void, SignUpParams> {
  const SignUp(this._repo);

  final AuthRepo _repo;

  @override
  ResultFuture<void> call(SignUpParams params) => _repo.signUp(
        email: params.email,
        fullName: params.fullName,
        password: params.password,
      );
}

class SignUpParams extends Equatable {
  const SignUpParams({
    required this.fullName,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  const SignUpParams.empty()
      : this(
          email: '',
          password: '',
          fullName: '',
          confirmPassword: '',
        );

  final String email;
  final String password;
  final String fullName;
  final String confirmPassword;

  @override
  List<String> get props => [email, password, fullName, confirmPassword];
}
