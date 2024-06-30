
import 'package:carpool_21_app/src/data/dataSource/remote/services/reserveService.dart';
import 'package:carpool_21_app/src/domain/models/reserve.dart';
import 'package:carpool_21_app/src/domain/models/reservesAll.dart';
import 'package:carpool_21_app/src/domain/repository/reserveRepository.dart';
import 'package:carpool_21_app/src/domain/utils/resource.dart';

class ReserveRepositoryImpl implements ReserveRepository {

  ReserveService reserveService;

  ReserveRepositoryImpl(this.reserveService);

  @override
  Future<Resource<bool>> create(Reserve reserve) {
    return reserveService.create(reserve);
  }

  @override
  Future<Resource<ReservesAll>> getAllReserves() {
    return reserveService.getReservesAll();
  }

}