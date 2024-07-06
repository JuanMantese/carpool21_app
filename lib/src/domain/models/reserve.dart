class Reserve {
  int idTrip;
  int idPassenger;
  String name;
  String lastName;

  Reserve({
    required this.idTrip,
    required this.idPassenger,
    required this.name,
    required this.lastName,
  });

  factory Reserve.fromJson(Map<String, dynamic> json) => Reserve(
    idTrip: json["idTrip"],
    idPassenger: json["idPassenger"],
    name: json["name"],
    lastName: json["lastName"],
  );

  Map<String, dynamic> toJson() => {
    'idTrip': idTrip,
    'idPassenger': idPassenger,
    'name': name,
    'lastName': lastName,
  };
}