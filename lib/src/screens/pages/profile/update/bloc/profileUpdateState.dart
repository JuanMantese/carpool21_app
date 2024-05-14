
import 'dart:io';

import 'package:carpool_21_app/src/domain/models/user.dart';
import 'package:carpool_21_app/src/domain/utils/resource.dart';
import 'package:carpool_21_app/src/screens/utils/blocFormItem.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';


class ProfileUpdateState extends Equatable {

   // Register Form - Use GlobalKey
  final GlobalKey<FormState>? formKey;
  final int id;
  final BlocFormItem name;
  final BlocFormItem lastName;
  final BlocFormItem userId;
  final BlocFormItem dni;
  final BlocFormItem phone;
  final BlocFormItem address;
  final BlocFormItem contactName;
  final BlocFormItem contactLastName;
  final BlocFormItem contactPhone;
  final File? image;
  final Resource? response; 

  const ProfileUpdateState({
    this.formKey,
    this.id = 0,
    this.name = const BlocFormItem(error: 'Ingresa tu nommbre'),
    this.lastName = const BlocFormItem(error: 'Ingresa tu apellido'),
    this.userId = const BlocFormItem(error: 'Ingresa tu legajo de Sigo 21'),
    this.dni = const BlocFormItem(error: 'Ingresa tu D.N.I.'),
    this.phone = const BlocFormItem(error: 'Ingresa tu teléfono'),
    this.address = const BlocFormItem(error: 'Ingresa tu dirección'),
    this.contactName = const BlocFormItem(error: 'Ingresa el nombre de tu contacto'),
    this.contactLastName = const BlocFormItem(error: 'Ingresa el apellido de tu contacto'),
    this.contactPhone = const BlocFormItem(error: 'Ingresa el teléfono de tu contacto'),
    this.image, 
    this.response
  });

  ProfileUpdateState copyWith({
    GlobalKey<FormState>? formKey,
    int? id,
    BlocFormItem? name,
    BlocFormItem? lastName,
    BlocFormItem? userId,
    BlocFormItem? dni,
    BlocFormItem? phone,
    BlocFormItem? address,
    BlocFormItem? contactName,
    BlocFormItem? contactLastName,
    BlocFormItem? contactPhone,
    File? image,
    Resource? response,
  }) {
    return ProfileUpdateState(
      formKey: formKey,
      id: id ?? this.id,
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      userId: userId ?? this.userId,
      dni: dni ?? this.dni,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      contactName: contactName ?? this.contactName,
      contactLastName: contactLastName ?? this.contactLastName,
      contactPhone: contactPhone ?? this.contactPhone,
      image: image ?? this.image,
      response: response
    );
  }

   // User Class with required parameters
  toUser() => User(
    name: name.value, 
    lastName: lastName.value, 
    userId: userId.value, 
    dni: dni.value, 
    phone: phone.value, 
    address: address.value,  
    contactName: contactName.value, 
    contactLastName: contactLastName.value, 
    contactPhone: contactPhone.value
  );

  @override
  List<Object?> get props => [name, lastName, userId, dni, phone, address, contactName, contactLastName, contactPhone, image, response];
}