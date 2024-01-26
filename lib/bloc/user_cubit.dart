import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organisation_management/models/user.dart';

class UserCubit extends Cubit<User>{

  UserCubit(User state) : super(state);

  void login(User user) => emit(user);

  void register(User user) => emit(user);

  void logout(User user) =>  emit(user);

}

