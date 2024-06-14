
import 'package:carpool_21_app/src/domain/models/carInfo.dart';
import 'package:carpool_21_app/src/domain/utils/resource.dart';
import 'package:carpool_21_app/src/screens/utils/blocFormItem.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';


class CarUpdateState extends Equatable {

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

  const CarUpdateState({
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

  CarUpdateState copyWith({
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
    return CarUpdateState(
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

  // Carinfo Class with required parameters
  toCarInfo() => CarInfo(
    brand: brand.value,
    model: model.value,
    patent: patent.value,
    color: color.value,
    nroGreenCard: int.tryParse(nroGreenCard.value) ?? 0,
    nroCarInsurance: int.tryParse(nroCarInsurance.value) ?? 0,
  );

  @override
  List<Object?> get props => [brand, model, patent, color, nroGreenCard, nroCarInsurance, response];
}