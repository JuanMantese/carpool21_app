import 'package:equatable/equatable.dart';

class PassengerHomeState extends Equatable {
  
  final int pageIndex;

  PassengerHomeState({
    this.pageIndex = 0
  });

  PassengerHomeState copyWith({
    int? pageIndex
  }) {
    return PassengerHomeState(pageIndex: pageIndex ?? this.pageIndex);
  }

  List<Object?> get props => [pageIndex];

}