
import 'package:carpool_21_app/src/domain/useCases/reserves/createReserveUseCase.dart';
import 'package:carpool_21_app/src/domain/useCases/reserves/getAllReservesUseCase.dart';

class ReserveUseCases {

  CreateReserveUseCase createReserve;
  GetAllReservesUseCase getAllReservesUseCase;

  ReserveUseCases({
    required this.createReserve,
    required this.getAllReservesUseCase
  });
}