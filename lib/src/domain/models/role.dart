
class Role {
  String idRole;
  String name;
  String route;

  Role({
    required this.idRole, 
    required this.name, 
    required this.route
  });

  factory Role.fromJson(Map<String, dynamic> json) => Role(
    idRole: json["idRole"],
    name: json["name"],
    route: json["route"],
  );

  Map<String, dynamic> toJson() => {
    'id': idRole,
    'name': name,
    'route': route,
  };
}