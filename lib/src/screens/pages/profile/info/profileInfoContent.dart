import 'package:carpool_21_app/src/domain/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class ProfileInfoContent extends StatelessWidget {

  User? user;

  ProfileInfoContent(this.user, {super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            _headerProfile(context),
            const Spacer(),
            _actionProfile('EDITAR PERFIL', Icons.edit, () { 
              Navigator.pushNamed(context, '/profile/update', arguments: user);
             }),
            _actionProfile('CERRAR SESION', Icons.settings_power, () {}),
            SizedBox(height: 35,)
          ],
        ),
        _cardUserInfo(context),
      ],
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
        'PERFIL DE USUARIO',
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
            Container(
              width: 115,
              margin: const EdgeInsets.only(top: 25, bottom: 15),
              child: AspectRatio(
                aspectRatio: 1,
                child: ClipOval(
                  child: 
                    FadeInImage.assetNetwork(
                      placeholder: 'lib/assets/img/profile-icon.png', 
                      image: 'https://www.dzoom.org.es/wp-content/uploads/2020/02/portada-foto-perfil-redes-sociales-consejos-810x540.jpg',
                      fit: BoxFit.cover,
                      fadeInDuration: const Duration(seconds: 1),
                    )
                  ),
                ),
                // child: ClipOval(   DESCOMENTAR - Cuando tengamos el back
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
              // ),
            ),
            const Text(
              // '${user?.name} ${user?.lastName}' ?? 'Nombre de Usuario',  DESCOMENTAR
              'Nombre de Usuario',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16
              ),
            ),
            Text(
              // user?.email ?? 'correo@correo.com',  DESCOMENTAR
              'correo@correo.com',
              style: TextStyle(
                color: Colors.grey[700]
              ),
            ),
            Text(
              // user?.phone ?? '3511111111',   DESCOMENTAR
              '3511111111',
              style: TextStyle(
                color: Colors.grey[700]
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _actionProfile(String option, IconData icon, Function() function) {
    return GestureDetector(
      onTap: () {
        function();
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
}