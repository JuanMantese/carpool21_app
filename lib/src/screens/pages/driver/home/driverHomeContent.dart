import 'package:flutter/material.dart';

class DriverHomeContent extends StatelessWidget {
  const DriverHomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Container(
              alignment: Alignment.topCenter,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    // Color(0xFF006D59), // Top color
                    Color.fromARGB(255, 109, 11, 0), // Top color
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
                  'lib/assets/img/Header-Logo-Big.png',
                  height: 90,
                ),
              ),
            ),
          ],
        ),
        // CustomNavigation(
        //   roles: state.roles ?? [], 
        //   currentUser: state.currentUser!, 
        //   userService: state.userService!,
        // ),

      ]
    );
  }
}