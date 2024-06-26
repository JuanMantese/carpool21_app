
class Role {
  String? idRole;
  String? name;
  String? route;

  Role({
    this.idRole, 
    this.name, 
    this.route
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