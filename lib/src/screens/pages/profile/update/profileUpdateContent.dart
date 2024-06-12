import 'package:carpool_21_app/src/domain/models/user.dart';
import 'package:carpool_21_app/src/screens/pages/profile/update/bloc/profileUpdateBloc.dart';
import 'package:carpool_21_app/src/screens/pages/profile/update/bloc/profileUpdateEvent.dart';
import 'package:carpool_21_app/src/screens/pages/profile/update/bloc/profileUpdateState.dart';
import 'package:carpool_21_app/src/screens/utils/blocFormItem.dart';
import 'package:carpool_21_app/src/screens/utils/galleryOrPhoto.dart';
import 'package:carpool_21_app/src/screens/widgets/CustomIconBack.dart';
import 'package:carpool_21_app/src/screens/widgets/CustomTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileUpdateContent extends StatelessWidget {

  User? user;
  ProfileUpdateState state;

  ProfileUpdateContent(this.user, this.state, {super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: state.formKey,
      child: Scaffold(
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: IntrinsicHeight(
              child: Stack(
                children: [
                  Column(
                    children: [
                      _headerProfile(context),
                      const Spacer(),
                      _actionProfile(context, 'ACTUALIZAR INFORMACIÓN', Icons.settings_power),
                      SizedBox(height: 35,)
                    ],
                  ),
                  _cardUserInfo(context),
                  _formUpdateProfile(context),
                  CustomIconBack(
                    margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 15, left: 30),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _headerProfile(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 30),
      height: MediaQuery.of(context).size.height * 0.33,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 0, 64, 52), // Top color
            Color(0xFF00A48B), // Bottom color
          ],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
      ),
      child: const Text(
        'EDICIÓN DE PERFIL',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 19
        ),
      ),
    );
  }

  Widget _cardUserInfo(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 35, right: 35, top: 150),
      width: MediaQuery.of(context).size.width,
      height: 250,
      child: Card(
        color: Colors.white,
        surfaceTintColor: Colors.white,
        child: Column(
          children: [
            _imageUser(context),
            Text(
              '${user?.name} ${user?.lastName}' ?? 'Nombre de Usuario',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16
              ),
            ),
            Text(
              user?.email ?? 'correo@correo.com',
              style: TextStyle(
                color: Colors.grey[700]
              ),
            ),
            Text(
              user?.phone?.toString() ?? '3511111111',
              style: TextStyle(
                color: Colors.grey[700]
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _formUpdateProfile(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 35, 
        right: 35, 
        top: MediaQuery.of(context).padding.top * 7,
      ),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.75,
      child: Column(
        children: [
          Column(
            children: [
              ...[
                CustomTextField(
                  onChanged: (text) {
                    context.read<ProfileUpdateBloc>().add(NameChanged(nameInput: BlocFormItem(value: text)));
                  },
                  validator: (value) {
                    return state.name.error;
                  },
                  text: 'Nombre', 
                  initialValue: user?.name,
                  inputType: TextInputType.text
                ),
                CustomTextField(
                  onChanged: (text) {
                    context.read<ProfileUpdateBloc>().add(LastNameChanged(lastNameInput: BlocFormItem(value: text)));
                  },
                  validator: (value) {
                    return state.lastName.error;
                  },
                  text: 'Apellido', 
                  initialValue: user?.lastName,
                  inputType: TextInputType.text
                ),
                CustomTextField(
                  onChanged: (text) {
                    context.read<ProfileUpdateBloc>().add(StudentFileChanged(studentFileInput: BlocFormItem(value: text)));
                  },
                  validator: (value) {
                    return state.studentFile.error;
                  },
                  text: 'Legajo', 
                  initialValue: user?.studentFile,
                  inputType: TextInputType.text
                ),
                CustomTextField(
                  onChanged: (text) {
                    context.read<ProfileUpdateBloc>().add(DniChanged(dniInput: BlocFormItem(value: text)));
                  },
                  validator: (value) {
                    return state.dni.error;
                  },
                  text: 'DNI', 
                  initialValue: user?.dni.toString(),
                  inputType: TextInputType.number
                ),
                CustomTextField(
                  onChanged: (text) {
                    context.read<ProfileUpdateBloc>().add(PhoneChanged(phoneInput: BlocFormItem(value: text)));
                  },
                  validator: (value) {
                    return state.phone.error;
                  },
                  text: 'Teléfono', 
                  initialValue: user?.phone?.toString(),
                  inputType: TextInputType.number
                ),
                CustomTextField(
                  onChanged: (text) {
                    context.read<ProfileUpdateBloc>().add(AddressChanged(addressInput: BlocFormItem(value: text)));
                  },
                  validator: (value) {
                    return state.address.error;
                  },
                  text: 'Domicilio', 
                  initialValue: user?.address,
                  inputType: TextInputType.text
                ),
              ].expand((widget) => [widget, const SizedBox(height: 10,)]),
            ],
          ),
          _actionProfile(context, 'ACTUALIZAR INFORMACIÓN', Icons.settings_power),
          // SizedBox(height: 35,)
        ],
      ),
    );
  }

  Widget _actionProfile(BuildContext context, String option, IconData icon) {
    return GestureDetector(
      onTap: () {
        if (state.formKey!.currentState != null) {
          if (state.formKey!.currentState!.validate()) {
            context.read<ProfileUpdateBloc>().add(FormSubmit());
          }
        } else {
          context.read<ProfileUpdateBloc>().add(FormSubmit());
        }
      },
      child: Container(
        margin: const EdgeInsets.only(left: 20, right: 20, top: 15),
        child: ListTile(
          title: Text(
            option,
            style: const TextStyle(
              fontWeight: FontWeight.bold
            ),
          ),
          leading: Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 0, 64, 52), // Top color
                  Color(0xFF00A48B), // Bottom color
                ],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
              ),
              borderRadius: BorderRadius.all(Radius.circular(50))
            ),
            child: Icon(
              icon,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _imageUser(BuildContext context) {
    return GestureDetector(
      onTap: () {
        GalleryOrPhotoDialog(
          context, 
          () => { context.read<ProfileUpdateBloc>().add(PickImage()) }, 
          () => { context.read<ProfileUpdateBloc>().add(TakePhoto()) }
        );
      },
      child: Container(
        width: 115,
        margin: EdgeInsets.only(top: 30, bottom: 15),
        child: AspectRatio(
          aspectRatio: 1,
          child: ClipOval(  // ELIMINAR cuando tengamos el back
            child: 
              FadeInImage.assetNetwork(
                placeholder: 'lib/assets/img/profile-icon.png', 
                image: 'https://www.dzoom.org.es/wp-content/uploads/2020/02/portada-foto-perfil-redes-sociales-consejos-810x540.jpg',
                fit: BoxFit.cover,
                fadeInDuration: const Duration(seconds: 1),
              )
            ),
          ),
          // child: ClipOval(   DESCOMENTAR cuando tengamos el back
          //   child: user != null 
          //   ? user!.image != null 
          //     ? FadeInImage.assetNetwork(
          //       placeholder: 'carpool_21_app/assets/img/profile-icon.png',  
          //       image: user!.image!,
          //       fit: BoxFit.cover,
          //       fadeInDuration: Duration(seconds: 1),
          //     )
          //     : Image.asset(
          //       'carpool_21_app/assets/img/profile-icon.png',
          //     )
          //   : Image.asset(
          //     'carpool_21_app/assets/img/profile-icon.png',
          //   ),
          // ),
        // )
      ),
    );
  }
}