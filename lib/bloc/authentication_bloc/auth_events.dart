abstract class AuthenticationEvents {}

class AppStarted extends AuthenticationEvents {}

class SignInWithEmailEvent extends AuthenticationEvents {}

class SignOutEvent extends AuthenticationEvents {}

class SignUpEvent extends AuthenticationEvents {}
