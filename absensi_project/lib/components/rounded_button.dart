import 'package:absensi_project/constans.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final VoidCallback? press;
  final Color? color, textColor;
  const RoundedButton({
    Key? key,
    required this.text,
    this.press,
    this.color = primaryColor,
    this.textColor = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: color,
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30)
          ),
          onPressed: press,
          child: Text(
            text,
            style: TextStyle(
                color: textColor,
                fontSize: 20
            ),
          ),
        ),
      ),
    );
  }
}