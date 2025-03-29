import 'package:assignment4/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/app_colors.dart';

class CustomContactView extends StatefulWidget {
  final String name;
  final int id;
  final ImageProvider img;
  final String emailAddress;
  final String number;
  static int _idCounter = 0;

  CustomContactView({
    super.key,
    required this.name,
    required this.img,
    required this.emailAddress,
    required this.number,
  }) : id = _idCounter++;


  @override
  State<CustomContactView> createState() => _CustomContactViewState();
}

class _CustomContactViewState extends State<CustomContactView> {
  Widget _iconView(IconData value, {Color? color}) {
    return Icon(value, color: color ?? AppColors.darkBlue);
  }

  Widget _displayText(String value,{dynamic fontSize = 8}) {
    return Text(
      value,
      style: GoogleFonts.inter(
        color: AppColors.darkBlue,
        fontWeight: FontWeight.w500,
        fontSize: fontSize.toDouble(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          alignment: Alignment.bottomLeft,
          height: 170,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: widget.img,
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: _displayText(widget.name,fontSize: 14),
          ),
        ),
        Container(
          padding: EdgeInsets.all(12),
          color: AppColors.white,
          width: double.infinity,
          child: Column(
            children: [
              Row(
                children: [
                  _iconView(Icons.email_rounded),
                  _displayText(widget.emailAddress),
                ],
              ),
              Row(
                children: [
                  _iconView(Icons.phone_in_talk),
                  _displayText(widget.number),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  HomeScreen.call(widget.id);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [_iconView(Icons.delete, color: AppColors.white)],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
