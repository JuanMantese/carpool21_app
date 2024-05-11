import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {

  Function() onPressed;
  String text;
  Color color;
  Color textColor;
  // IconData icon;
  EdgeInsetsGeometry margin;
  EdgeInsetsGeometry padding;

  CustomButton({
    super.key, 
    required this.text,
    required this.onPressed,
    this.color = const Color(0xFF00A98F),
    this.textColor = Colors.white,
    // this.icon = Icons.visibility,
    this.margin = const EdgeInsets.only(top: 30, bottom: 30, right: 15, left: 15),
    this.padding = const EdgeInsets.only(top: 30, bottom: 30, right: 15, left: 15),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
        onPressed: () {
          onPressed();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          minimumSize: const Size(double.infinity, 60), // width and heigh
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Text(
          'Ingresar',
          style: TextStyle(
            color: textColor,
            fontSize: 18,
            fontFamily: "Montserrat",
            fontWeight: FontWeight.w600
          ),
        ),
      ),
    );
  }
}