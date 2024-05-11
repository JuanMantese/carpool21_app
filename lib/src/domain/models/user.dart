import 'package:carpool_21_app/src/domain/models/role.dart';

class User {
  int? id;
  String name;
  String lastName;
  String userId;
  String dni;
  String phone;
  String address;
  String email;
  String password;
  String passwordConfirm;
  String contactName;
  String contactPhone;
  String contactLastName;
  String? image;
  String? notificationToken;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Role>? roles;

  User({
    this.id,
    required this.name,
    required this.lastName,
    required this.userId,
    required this.dni,
    required this.phone,
    required this.address,
    required this.email,
    required this.password,
    required this.passwordConfirm,
    required this.contactName,
    required this.contactLastName,
    required this.contactPhone,
    this.image,
    this.notificationToken,
    this.createdAt,
    this.updatedAt,
    this.roles,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    lastName: json["last_name"],
    userId: json["user_id"],
    dni: json["dni"],
    phone: json["phone"],
    address: json["address"],
    email: json["email"],
    password: json['password'],
    passwordConfirm: json['password_confirm'],
    contactName: json["contact_name"],
    contactLastName: json["contact_last_name"],
    contactPhone: json["contact_phone"],
    image: json["image"],
    notificationToken: json["notification_token"],
    roles: json["roles"] != null ? List<Role>.from(json["roles"].map((x) => Role.fromJson(x))) : [],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'last_name': lastName,
    'user_id': userId,
    'dni': dni,
    'phone': phone,
    'address': address,
    'email': email,
    'password': password,
    'password_confirm': passwordConfirm,
    'contact_name': contactName,
    'contact_last_name': contactLastName,
    'contact_phone': contactPhone,
    'image': image,
    'notification_token': notificationToken,
    'roles': roles != null ? List<dynamic>.from(roles!.map((x) => x.toJson())) : [],
  };
}