import 'package:carpool_21_app/src/domain/useCases/auth/authUseCases.dart';
import 'package:carpool_21_app/src/domain/utils/resource.dart';
import 'package:carpool_21_app/src/screens/pages/auth/register/bloc/registerEvent.dart';
import 'package:carpool_21_app/src/screens/pages/auth/register/bloc/registerState.dart';
import 'package:carpool_21_app/src/screens/utils/blocFormItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  
  AuthUseCases authUseCases;
  final formKey = GlobalKey<FormState>();

  // constructor
  RegisterBloc(
    this.authUseCases
  ): 
  super(const RegisterState()) {
    
    on<RegisterInitEvent>((event, emit) {
      emit(state.copyWith(formKey: formKey));
    });

    on<NameChanged>((event, emit) {
      emit(
        state.copyWith(
          name: BlocFormItem(
            value: event.nameInput.value,
            error: event.nameInput.value.isEmpty ? 'Ingresa tu nombre' : null
          ),
          formKey: formKey
        )
      );
    });

    on<LastNameChanged>((event, emit) {
      emit(
        state.copyWith(
          lastName: BlocFormItem(
            value: event.lastNameInput.value,
            error: event.lastNameInput.value.isEmpty ? 'Ingresa tu apellido' : null
          ),
          formKey: formKey
        )
      );
    });

    on<UserIdChanged>((event, emit) {
      emit(
        state.copyWith(
          userId: BlocFormItem(
            value: event.userIdInput.value,
            error: event.userIdInput.value.isEmpty ? 'Ingresa tu legajo de Siglo 21' : null
          ),
          formKey: formKey
        )
      );
    });

    on<DniChanged>((event, emit) {
      emit(
        state.copyWith(
          dni: BlocFormItem(
            value: event.dniInput.value,
            error: event.dniInput.value.isEmpty ? 'Ingresa tu D.N.I.' : null
          ),
          formKey: formKey
        )
      );
    });

    on<PhoneChanged>((event, emit) {
      emit(
        state.copyWith(
          phone: BlocFormItem(
            value: event.phoneInput.value,
            error: event.phoneInput.value.isEmpty ? 'Ingresa tu telefono' : null
          ),
          formKey: formKey
        )
      );
    });

    on<AddressChanged>((event, emit) {
      emit(
        state.copyWith(
          address: BlocFormItem(
            value: event.addressInput.value,
            error: event.addressInput.value.isEmpty ? 'Ingresa tu direccion' : null
          ),
          formKey: formKey
        )
      );
    });

    on<EmailChanged>((event, emit) {
      emit(
        state.copyWith(
          email: BlocFormItem(
            value: event.emailInput.value,
            error: event.emailInput.value.isEmpty ? 'Ingresa tu email' : null
          ),
          formKey: formKey
        )
      );
    });

    on<PasswordChanged>((event, emit) {
      emit(
        state.copyWith(
          password: BlocFormItem(
            value: event.passwordInput.value,
            error: event.passwordInput.value.isEmpty 
              ? 'Ingresa una contrasena'
              : event.passwordInput.value.length < 6
                ? 'Minimo 6 caracteres' : null 
          ),
          formKey: formKey
        )
      );
    });

    on<PasswordConfirmChanged>((event, emit) {
      emit(
        state.copyWith(
          passwordConfirm: BlocFormItem(
            value: event.passwordConfirmInput.value,
            error: event.passwordConfirmInput.value.isEmpty 
              ? 'Confirma la contrasena'
              : event.passwordConfirmInput.value.length < 6
                ? 'Minimo 6 caracteres' 
                : event.passwordConfirmInput.value != state.password.value 
                  ? 'La contrasena no coincide'
                  : null 
          ),
          formKey: formKey
        )
      );
    });

    on<ContactNameChanged>((event, emit) {
      emit(
        state.copyWith(
          contactName: BlocFormItem(
            value: event.contactNameInput.value,
            error: event.contactNameInput.value.isEmpty ? 'Ingresa el nombre de tu contacto' : null
          ),
          formKey: formKey
        )
      );
    });

    on<ContactLastNameChanged>((event, emit) {
      emit(
        state.copyWith(
          contactLastName: BlocFormItem(
            value: event.contactLastNameInput.value,
            error: event.contactLastNameInput.value.isEmpty ? 'Ingresa el apellido de tu contacto' : null
          ),
          formKey: formKey
        )
      );
    });

    on<ContactPhoneChanged>((event, emit) {
      emit(
        state.copyWith(
          contactPhone: BlocFormItem(
            value: event.contactPhoneInput.value,
            error: event.contactPhoneInput.value.isEmpty ? 'Ingresa el telefono de tu contacto' : null
          ),
          formKey: formKey
        )
      );
    });

    on<FormSubmit>((event, emit) async {
      print('Nombe: ${ state.name.value }');
      print('Apellido: ${ state.lastName.value }');
      print('Legajo: ${ state.userId.value }');
      print('DNI: ${ state.dni.value }');      
      print('Telefono: ${ state.phone.value }');
      print('Direccion: ${ state.address.value }');
      print('Email: ${ state.email.value }');
      print('Password: ${ state.password.value }');
      print('Password Confirm: ${ state.passwordConfirm.value }');
      print('Contact name: ${ state.contactName.value }');
      print('Contact last name: ${ state.contactLastName.value }');
      print('Contact phone: ${ state.contactPhone.value }');

      // Issuance of status change - Loading
      emit(
        state.copyWith(
          response: Loading(),
          formKey: formKey
        )
      );

      // PARA QUE APAREZCA El estado de Loading (circle) - Tirar el Back y que quede cargando
      Resource response = await authUseCases.register.run(state.toUser());

      // Issuance of status change - Success/Error
      emit(
        state.copyWith(
          response: response,
          formKey: formKey
        )
      );
    });

    on<FormReset>((event, emit) {
      state.formKey?.currentState?.reset();
    });

    on<SaveUserSession>((event, emit) async {
      await authUseCases.saveUserSession.run(event.authResponse);
    });
  }
}