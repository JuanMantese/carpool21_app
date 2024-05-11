import 'package:equatable/equatable.dart';

class DrawerState extends Equatable {
  
  final int pageIndex;

  DrawerState({
    this.pageIndex = 0
  });

  DrawerState copyWith({
    int? pageIndex
  }) {
    return DrawerState(pageIndex: pageIndex ?? this.pageIndex);
  }

  List<Object?> get props => [pageIndex];

}