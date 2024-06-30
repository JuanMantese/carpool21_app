import 'package:carpool_21_app/src/screens/pages/passenger/reserves/bloc/reservesBloc.dart';
import 'package:carpool_21_app/src/screens/pages/passenger/reserves/bloc/reservesEvent.dart';
import 'package:carpool_21_app/src/screens/pages/passenger/reserves/bloc/reservesState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReservesPage extends StatefulWidget {
  const ReservesPage({super.key});

  @override
  State<ReservesPage> createState() => _ReservesPageState();
}

class _ReservesPageState extends State<ReservesPage> {
  @override
  void initState() {
    super.initState();
    
    // Dispara el evento para obtener la información del usuario
    context.read<ReservesBloc>().add(GetReservesAll());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ReservesBloc, ReservesState>(
        builder: (context, state) {
          if (state.testingReservesAll == null) {
            // Mostrar un indicador de carga mientras se obtiene la información del usuario
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Container(child: Text('Aqui'),);
            // ReservesContent(state);
          }
          // return pageList[state.pageIndex];
        },
      ),
    );
  }
}