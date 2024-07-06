import 'package:carpool_21_app/src/domain/models/reserve.dart';
import 'package:carpool_21_app/src/domain/models/reservesAll.dart';
import 'package:carpool_21_app/src/domain/utils/resource.dart';

abstract class ReserveRepository {

  // Creamos la reserva de un viaje
  Future<Resource<bool>> create(Reserve reserve);

  // Obtenemos todas las reservas registradas de un pasajero
  Future<Resource<ReservesAll>> getAllReserves();
}