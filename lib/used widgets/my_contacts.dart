import 'package:assignment4/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../custom widget/custom_contact_view.dart';

class MyContacts extends StatelessWidget {
  final List<CustomContactView> contacts;

  const MyContacts({super.key, required this.contacts});

  Widget check(){
    return contacts.isEmpty ? Column(
      children: [
        Center(child: Image.asset('assets/png/list-purple.png')),
        Text("There is No Contacts",style: GoogleFonts.inter(
          color: AppColors.white,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),),
      ]
    ): contactBody();
  }

  Widget contactBody(){
    return Expanded(
      child: GridView.builder(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 30),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 0.575,
        ),
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          return contacts[index];
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          check(),
        ],
      ),
    );
  }
}
