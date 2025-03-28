import 'package:assignment4/core/app_colors.dart';
import 'package:assignment4/custom%20widget/custom_contact_view.dart';
import 'package:assignment4/used%20widgets/my_contacts.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../pages/bottom_sheet.dart';

class HomeScreen extends StatefulWidget {
  final String routeName = '/HomeScreen';
  static Map<int, CustomContactView> contacts = {};

  static final GlobalKey<_HomeScreenState> homeScreenKey = GlobalKey<_HomeScreenState>();
  const HomeScreen({super.key});


  @override
  State<HomeScreen> createState() => _HomeScreenState();

  static void call(id){
    homeScreenKey.currentState?.removeContact(id);
  }
}

class _HomeScreenState extends State<HomeScreen> {

  void addContact(CustomContactView newContact) {
    setState(() {
      HomeScreen.contacts[newContact.id] = newContact;
    });
  }

  void removeContact(int id) {
    if (HomeScreen.contacts.containsKey(id)) {
      setState(() {
        HomeScreen.contacts.remove(id);
      });
    } else {
      if (kDebugMode) {
        print("invalid id");
      }
    }
  }


  void showCustomBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,

      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            padding: EdgeInsets.all(15),
            height: MediaQuery.of(context).size.height * 0.5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
              color: AppColors.darkBlue,
            ),
            child: CustomBottomSheet(addContact: addContact,),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBlue,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.only(top: 8,left: 8),
          child: Image.asset("assets/png/route icon.png"),
        ),
        leadingWidth: MediaQuery.of(context).size.width / 2.2,
      ),
      body: MyContacts(contacts: HomeScreen.contacts.values.toList()),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 30, right: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              backgroundColor: AppColors.white,
              onPressed: () {
                showCustomBottomSheet(context);
              },
              child: Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}
