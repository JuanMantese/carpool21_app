// navigation_event.dart
abstract class NavigationEvent {}

class ShowInicio extends NavigationEvent {}

class ShowReservas extends NavigationEvent {}

class ShowViaje extends NavigationEvent {}

class ShowPerfil extends NavigationEvent {}

class Logout extends NavigationEvent {}