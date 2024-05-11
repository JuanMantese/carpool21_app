import 'package:carpool_21_app/src/domain/models/authResponse.dart';
import 'package:carpool_21_app/src/domain/useCases/auth/authUseCases.dart';
import 'package:carpool_21_app/src/screens/pages/profile/info/bloc/profileInfoEvent.dart';
import 'package:carpool_21_app/src/screens/pages/profile/info/bloc/profileInfoState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileInfoBloc extends Bloc<ProfileInfoEvent, ProfileInfoState> {

  AuthUseCases authUseCases;

  // Constructor
  ProfileInfoBloc(this.authUseCases): super(ProfileInfoState()) {
    
    on<GetUserInfo>((event, emit) async {
      // Obtaining session information
      AuthResponse authResponse = await authUseCases.getUserSession.run();

      // Issuing the information to use it
      emit(
        state.copyWith(
          user: authResponse.user
        )
      );
    }); 
  }

}