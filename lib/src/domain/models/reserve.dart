class Reserve {
  String idTrip;
  String idPassenger;

  Reserve({
    required this.idTrip,
    required this.idPassenger,
  });

  factory Reserve.fromJson(Map<String, dynamic> json) => Reserve(
    idTrip: json["idTrip"],
    idPassenger: json["idPassenger"],
  );

  Map<String, dynamic> toJson() => {
    'idTrip': idTrip,
    'idPassenger': idPassenger,
  };
}