import 'package:carpool_21_app/src/domain/useCases/auth/authUseCases.dart';
import 'package:carpool_21_app/src/screens/widgets/drawer/bloc/drawerEvent.dart';
import 'package:carpool_21_app/src/screens/widgets/drawer/bloc/drawerState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DrawerBloc extends Bloc<DrawerEvent, DrawerState> {

  AuthUseCases authUseCases;

  DrawerBloc(this.authUseCases): super(DrawerState()) {
    on<ChangeDrawerPage>((event, emit) {
      emit(
        state.copyWith(
          pageIndex: event.pageIndex
        )
      );
    });

    on<Logout>((event, emit) async {
      await authUseCases.logout.run();
    });
  }
}