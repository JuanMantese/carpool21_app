import 'package:carpool_21_app/src/domain/models/role.dart';

class User {
  int? id;
  String name;
  String lastName;
  String? studentFile;
  int dni;
  int phone;
  String address;
  String? email;
  String? password;
  String? passwordConfirm;
  String contactName;
  String contactLastName;
  int contactPhone;
  String? photoUser;
  String? notificationToken;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Role>? roles;

  User({
    this.id,
    required this.name,
    required this.lastName,
    this.studentFile,
    required this.dni,
    required this.phone,
    required this.address,
    this.email,
    this.password,
    this.passwordConfirm,
    required this.contactName,
    required this.contactLastName,
    required this.contactPhone,
    this.photoUser,
    this.notificationToken,
    this.createdAt,
    this.updatedAt,
    this.roles,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["idUser"],
    name: json["name"],
    lastName: json["lastName"],
    studentFile: json["studentFile"],
    dni: json["dni"] is String ? int.parse(json["dni"]) : json["dni"],
    phone: json["phone"] is String ? int.parse(json["phone"]) : json["phone"],
    address: json["address"],
    email: json["email"],
    contactName: json["contactName"],
    contactLastName: json["contactLastName"],
    contactPhone: json["contactPhone"] is String ? int.parse(json["contactPhone"]) : json["contactPhone"],
    // photoUser: json["photoUser"],
    // notificationToken: json["notification_token"],
    roles: json["roles"] != null ? List<Role>.from(json["roles"].map((x) => Role.fromJson(x))) : [],
  );

  Map<String, dynamic> toJson() => {
    // 'idUser': id,
    'name': name,
    'lastName': lastName,
    'studentFile': studentFile,
    'dni': dni,
    'phone': phone,
    'address': address,
    'email': email,
    'password': password,
    'contactName': contactName,
    'contactLastName': contactLastName,
    'contactPhone': contactPhone,
    // 'photoUser': photoUser,
    // 'notification_token': notificationToken,
    // 'created_at': createdAt?.toIso8601String(),
    // 'updated_at': updatedAt?.toIso8601String(),
    'roles': roles != null ? List<dynamic>.from(roles!.map((x) => x.toJson())) : [],
  };
}