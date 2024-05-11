abstract class PassengerHomeEvent {}

// Navegando entre las paginas
class ChangeDrawerPage extends PassengerHomeEvent {
  final int pageIndex;
  ChangeDrawerPage({ required this.pageIndex });
}

class Logout extends PassengerHomeEvent {}