import 'package:carpool_21_app/src/screens/pages/auth/login/bloc/loginBloc.dart';
import 'package:carpool_21_app/src/screens/pages/auth/login/bloc/loginEvent.dart';
import 'package:carpool_21_app/src/screens/pages/auth/login/bloc/loginState.dart';
import 'package:carpool_21_app/src/screens/utils/blocFormItem.dart';
import 'package:carpool_21_app/src/screens/widgets/CustomButton.dart';
import 'package:carpool_21_app/src/screens/widgets/CustomTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginContent extends StatefulWidget {
  final LoginState state;

  const LoginContent(this.state, {super.key});

  @override
  LoginContentState createState() => LoginContentState();
}

class LoginContentState extends State<LoginContent> {

  bool _isPasswordVisible = false;
 
  @override
  Widget build(BuildContext context) {
    final state = widget.state;

    return Form(
      key: state.formKey,
      child: Scaffold(
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
                  top: MediaQuery.of(context).padding.top + 30,
                  bottom: 30, 
                  right: 15, 
                  left: 15, 
                ),
                child: Image.asset(
                  'lib/assets/img/universidad-siglo-21.png',
                  height: 90,
                ),
              ),
            ),
          
            Container(
              padding: const EdgeInsets.only(top: 20, bottom: 20, right: 30, left: 30),
              child: Column(
                children: [
                  const SizedBox(height: 100.0),
                  const Text(
                    'Car Pool 21',
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      fontSize: 28,
                      letterSpacing: 3.5,
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.italic,
                      color: Color(0xFF006D59)
                    ),
                  ),
      
                  const SizedBox(height: 26.0),
                  CustomTextField(
                    onChanged: (text) {
                      context.read<LoginBloc>().add(EmailChanged(emailInput: BlocFormItem(value: text)));
                    },
                    validator: (value) {
                      return state.email.error;
                    },
                    text: 'Correo', 
                    inputType: TextInputType.emailAddress
                  ),
                  
                  const SizedBox(height: 16.0),
                  TextFormField(
                    onChanged: (text) {
                      context.read<LoginBloc>().add(PasswordChanged(passwordInput: BlocFormItem(value: text)));
                    },
                    validator: (value) {
                      return state.password.error;
                    },
                    decoration: InputDecoration(
                      labelText: 'Contraseña',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20), 
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          // Change the icon based on the state of _isPasswordVisible
                          _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;  // Change the state by pressing the icon
                          });
                        },
                      ),
                    ),
                    obscureText: !_isPasswordVisible,
                  ),
                  
                  const SizedBox(height: 24.0),
                  CustomButton(
                    text: 'Ingresar', 
                    onPressed: () {
                      if (state.formKey!.currentState!.validate()) {                      
                        context.read<LoginBloc>().add(FormSubmit());
                      } else {
                        print('El formulario no es valido');
                      }
                    }
                  ),
      
                  // const Spacer(), REVISAR ESTE ELEMENTO
                  Column(
                    children: [
                      TextButton(
                        child: const Text('No tienes usuario? Registrate AQUÍ'),
                        onPressed: () {
                          // Implement registration logic
                        },
                      ),
                      const SizedBox(height: 24.0),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/register');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          minimumSize: const Size(180, 50), // width and height
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text(
                          'Registrarse',
                          style: TextStyle(
                            color: Color(0xFF00A98F),
                            fontWeight: FontWeight.w700
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),  
          ],
        ),
      ),
    );
  }
}

