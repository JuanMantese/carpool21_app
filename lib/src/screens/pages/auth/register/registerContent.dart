// ignore_for_file: file_names
import 'package:carpool_21_app/src/screens/pages/auth/register/bloc/registerEvent.dart';
import 'package:carpool_21_app/src/screens/pages/auth/register/bloc/registerBloc.dart';
import 'package:carpool_21_app/src/screens/pages/auth/register/bloc/registerState.dart';
import 'package:carpool_21_app/src/screens/utils/blocFormItem.dart';
import 'package:carpool_21_app/src/screens/widgets/CustomTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterContent extends StatefulWidget {
  final RegisterState state; // Recibe el bloc como parámetro opcional.

  const RegisterContent(this.state, {super.key});

  @override
  RegisterContentState createState() => RegisterContentState();
}

class RegisterContentState extends State<RegisterContent> {
  bool _isPasswordVisible = false; 

  @override
  Widget build(BuildContext context) {
    final state = widget.state;

    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF006D59), // Top color
                  Color(0xFF00A48B), // Bottom color
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30), 
                bottomRight: Radius.circular(30), 
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF00A48B).withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 10), // Shadow offset distance in x,y
                )
              ],
            ),
            child: Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 20,
                bottom: 20, 
                right: 15, 
                left: 15, 
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'lib/assets/img/s21_logo_white.png',
                    height: 50,
                  ),
                  const SizedBox(width: 20),
                  const Text(
                    'CarPool 21',
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      fontSize: 28,
                      letterSpacing: 3.5,
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.italic,
                      color: Color(0xFFFFFFFF)
                    ),
                ),
                ],
              ),
            ),
          ),
        
          Expanded(
            flex: 8,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 20, bottom: 20, right: 30, left: 30),
                    child: Form(
                      key: state.formKey,
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          const Text(
                            'Registro de Usuario',
                            style: TextStyle(
                              fontFamily: "Montserrat",
                              fontSize: 20,
                              letterSpacing: 0.5,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF006D59)
                            ),
                          ),
                                        
                          const SizedBox(height: 20),
                          Column(
                            children: [
                              ...[
                                CustomTextField(
                                  onChanged: (text) {
                                    context.read<RegisterBloc>().add(NameChanged(nameInput: BlocFormItem(value: text)));
                                  },
                                  validator: (value) {
                                    return state.name.error;
                                  },
                                  text: 'Nombre', 
                                  inputType: TextInputType.text
                                ),
                                CustomTextField(
                                  onChanged: (text) {
                                    context.read<RegisterBloc>().add(LastNameChanged(lastNameInput: BlocFormItem(value: text)));
                                  },
                                  validator: (value) {
                                    return state.lastName.error;
                                  },
                                  text: 'Apellido', 
                                  inputType: TextInputType.text
                                ),
                                CustomTextField(
                                  onChanged: (text) {
                                    context.read<RegisterBloc>().add(UserIdChanged(userIdInput: BlocFormItem(value: text)));
                                  },
                                  validator: (value) {
                                    return state.userId.error;
                                  },
                                  text: 'Legajo', 
                                  inputType: TextInputType.text
                                ),
                                CustomTextField(
                                  onChanged: (text) {
                                    context.read<RegisterBloc>().add(DniChanged(dniInput: BlocFormItem(value: text)));
                                  },
                                  validator: (value) {
                                    return state.dni.error;
                                  },
                                  text: 'DNI', 
                                  inputType: TextInputType.text
                                ),
                                CustomTextField(
                                  onChanged: (text) {
                                    context.read<RegisterBloc>().add(PhoneChanged(phoneInput: BlocFormItem(value: text)));
                                  },
                                  validator: (value) {
                                    return state.phone.error;
                                  },
                                  text: 'Teléfono', 
                                  inputType: TextInputType.text
                                ),
                                CustomTextField(
                                  onChanged: (text) {
                                    context.read<RegisterBloc>().add(AddressChanged(addressInput: BlocFormItem(value: text)));
                                  },
                                  validator: (value) {
                                    return state.address.error;
                                  },
                                  text: 'Domicilio', 
                                  inputType: TextInputType.text
                                ),
                                CustomTextField(
                                  onChanged: (text) {
                                    context.read<RegisterBloc>().add(EmailChanged(emailInput: BlocFormItem(value: text)));
                                  },
                                  validator: (value) {
                                    return state.email.error;
                                  },
                                  text: 'Correo', 
                                  inputType: TextInputType.emailAddress
                                ),
                              ].expand((widget) => [widget, const SizedBox(height: 10,)]),
                                        
                              TextFormField(
                                onChanged: (text) {
                                  context.read<RegisterBloc>().add(PasswordChanged(passwordInput: BlocFormItem(value: text)));
                                },
                                validator: (value) {
                                  return state.password.error;
                                },
                                decoration: InputDecoration(
                                  labelText: 'Contraseña',
                                  labelStyle: const TextStyle(color: Color(0xFF006D59)),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20), 
                                  ),
                                  focusedBorder: OutlineInputBorder( 
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: const BorderSide(color: Color(0xFF006D59)),
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      // Change the icon based on the state of _isPasswordVisible
                                      _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _isPasswordVisible = !_isPasswordVisible; // Change the state when you press the icon
                                      });
                                    },
                                  ),
                                ),
                                obscureText: !_isPasswordVisible,
                              ),
                            ],
                          ),
                          
                          
                          const SizedBox(height: 24.0),
                          ElevatedButton(
                            onPressed: () {
                              if (state.formKey!.currentState!.validate()) {                      
                                context.read<RegisterBloc>().add(FormSubmit());
                                context.read<RegisterBloc>().add(FormReset());
                              } else {
                                print('El formulario no es valido');
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF00A98F),
                              minimumSize: const Size(250, 60), // width and height
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: const Text(
                              'Registrarse',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.w600
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  // const Spacer(),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.09),
                  Container(
                    // margin: EdgeInsets.only(
                    //   bottom: MediaQuery.of(context).padding.bottom
                    // ),
                    child: TextButton(
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Ya tienes usuario?',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(width: 10,),
                          Text(
                            'Inicía Sesión AQUÍ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}