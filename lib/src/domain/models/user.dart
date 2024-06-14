import 'package:carpool_21_app/src/domain/models/role.dart';

class User {
  int? id;
  String name;
  String lastName;
  String studentFile;
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
    required this.studentFile,
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
    id: json["id"],
    name: json["name"],
    lastName: json["lastName"],
    studentFile: json["studentFile"],
    dni: json["dni"] is String ? int.parse(json["dni"]) : json["dni"],
    phone: json["phone"] is String ? int.parse(json["phone"]) : json["phone"],
    address: json["address"],
    email: json["email"],
    password: json['password'],
    passwordConfirm: json['passwordConfirm'],
    contactName: json["contactName"],
    contactLastName: json["contactLastName"],
    contactPhone: json["contactPhone"] is String ? int.parse(json["contactPhone"]) : json["contactPhone"],
    photoUser: json["photoUser"],
    notificationToken: json["notification_token"],
    createdAt: json["created_at"] != null ? DateTime.parse(json["created_at"]) : null,
    updatedAt: json["updated_at"] != null ? DateTime.parse(json["updated_at"]) : null,
    roles: json["roles"] != null ? List<Role>.from(json["roles"].map((x) => Role.fromJson(x))) : [],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'lastName': lastName,
    'studentFile': studentFile,
    'dni': dni,
    'phone': phone,
    'address': address,
    'email': email,
    'password': password,
    'passwordConfirm': passwordConfirm,
    'contactName': contactName,
    'contactLastName': contactLastName,
    'contactPhone': contactPhone,
    'photoUser': photoUser,
    'notification_token': notificationToken,
    'created_at': createdAt?.toIso8601String(),
    'updated_at': updatedAt?.toIso8601String(),
    'roles': roles != null ? List<dynamic>.from(roles!.map((x) => x.toJson())) : [],
  };
}