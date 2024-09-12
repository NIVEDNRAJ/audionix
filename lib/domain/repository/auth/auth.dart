import 'package:dartz/dartz.dart';
import '../../../data/models/auth/create_user_req.dart';
import '../../../data/models/auth/signin_user_req.dart';

abstract class AuthRepository {
  
  Future<Either> signup(CreateUserReq createUserReq);

  Future<Either> signin(SigninUserReq signinUserReq);

  Future<Either> getUser();

  Future<void> logout();
}