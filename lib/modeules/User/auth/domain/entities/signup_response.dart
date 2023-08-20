import 'package:equatable/equatable.dart';

import '../../data/models/tokens.dart';
import '../../data/models/user_model.dart';

class SignUpResponse extends Equatable {
  const SignUpResponse({
    required this.tokens,
    required this.user,
  });

  final Tokens tokens;
  final UserModel user;

  SignUpResponse copyWith({
    Tokens? token,
    UserModel? user,
  }) =>
      SignUpResponse(
        tokens: token ?? tokens,
        user: user ?? this.user,
      );

  @override
  List<Object?> get props => [tokens, user];
}
