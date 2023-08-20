



import 'package:chefaa/modeules/User/auth/data/models/tokens.dart';
import 'package:chefaa/modeules/User/auth/data/models/user_model.dart';

import '../../domain/entities/signup_response.dart';

class SignUpResponseModel extends SignUpResponse {
  const SignUpResponseModel({
    required super.tokens,
    required super.user,
  });

  factory SignUpResponseModel.fromJson(Map<String, dynamic> json) {
    return SignUpResponseModel(
      tokens: Tokens.fromJson(json['tokens'] as Map<String, dynamic>),
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
    );
  }
  @override
  List<Object?> get props => [tokens, user];
}
