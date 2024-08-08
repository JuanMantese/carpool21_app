
import 'package:carpool_21_app/src/domain/models/reserve.dart';
import 'package:carpool_21_app/src/domain/repository/reserveRepository.dart';

class CreateReserveUseCase {

  ReserveRepository reserveRepository;

  CreateReserveUseCase(this.reserveRepository);

  run(Reserve reserve) => reserveRepository.create(reserve);
}