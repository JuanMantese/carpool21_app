
import 'package:carpool_21_app/src/domain/utils/resource.dart';
import 'package:carpool_21_app/src/screens/utils/blocFormItem.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';


class CarRegisterState extends Equatable {

  // Register Form - Use GlobalKey
  final GlobalKey<FormState>? formKey;
  final int id;
  final BlocFormItem brand; // Marca
  final BlocFormItem model; // Modelo
  final BlocFormItem patent; // Patente
  final BlocFormItem color; // Color del auto
  final BlocFormItem nroGreenCard; // Numero Cedula Verde
  final BlocFormItem nroCarInsurance; // Seguro del auto
  final Resource? response; 

  const CarRegisterState({
    this.formKey,
    this.id = 0,
    this.brand = const BlocFormItem(error: 'Ingresá la Marca'),
    this.model = const BlocFormItem(error: 'Ingresá el Modelo'),
    this.patent = const BlocFormItem(error: 'Ingresá la patente'),
    this.color = const BlocFormItem(error: 'Elegí el color'),
    this.nroGreenCard = const BlocFormItem(error: 'Ingresá el Nro de Cedula Verde'),
    this.nroCarInsurance = const BlocFormItem(error: 'Ingresá el Nro de Seguro'),
    this.response
  });

  CarRegisterState copyWith({
    GlobalKey<FormState>? formKey,
    int? id,
    BlocFormItem? brand,
    BlocFormItem? model,
    BlocFormItem? patent,
    BlocFormItem? color,
    BlocFormItem? nroGreenCard,
    BlocFormItem? nroCarInsurance,
    Resource? response,
  }) {
    return CarRegisterState(
      formKey: formKey,
      id: id ?? this.id,
      brand: brand ?? this.brand,
      model: model ?? this.model,
      patent: patent ?? this.patent,
      color: color ?? this.color,
      nroGreenCard: nroGreenCard ?? this.nroGreenCard,
      nroCarInsurance: nroCarInsurance ?? this.nroCarInsurance,
      response: response
    );
  }

  @override
  List<Object?> get props => [brand, model, patent, color, nroGreenCard, nroCarInsurance, response];
}