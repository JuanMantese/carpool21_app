abstract class DrawerEvent {}

// Navigating between pages
class ChangeDrawerPage extends DrawerEvent {
  final int pageIndex;
  ChangeDrawerPage({ required this.pageIndex });
}

class Logout extends DrawerEvent {}