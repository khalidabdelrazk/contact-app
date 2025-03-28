import 'dart:io';

import 'package:assignment4/custom%20widget/custom_contact_view.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../core/app_colors.dart';

class CustomBottomSheet extends StatefulWidget {
  final Function(CustomContactView) addContact;

  const CustomBottomSheet({super.key, required this.addContact});

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  final TextEditingController _controller3 = TextEditingController();
  XFile? returnedImage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller1.addListener(() => setState(() {}));
    _controller2.addListener(() => setState(() {}));
    _controller3.addListener(() => setState(() {}));
  }

  Widget usedTextFormField(
    TextEditingController controller,
    TextInputType textInputType,
    String hintText, {
    int? maxLength,
  }) {
    return TextFormField(
      controller: controller,
      maxLength: maxLength ?? 16,
      keyboardType: textInputType,
      style: TextStyle(color: AppColors.white),
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: AppColors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: AppColors.white),
        ),
        fillColor: AppColors.white,
        hintText: hintText,
        hintStyle: TextStyle(color: AppColors.white),
        counterText: '',
      ),
      validator: validate,
    );
  }

  String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return 'empty Field';
    }
    return null;
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      CustomContactView newContact =CustomContactView(
        name: _controller1.text,
        img: returnedImage != null
            ? FileImage(File(returnedImage!.path)) // ✅ Correct
            : const AssetImage("assets/png/del.png"),
        emailAddress: _controller2.text,
        number: _controller3.text,
      );
      widget.addContact(newContact);

      // Close the bottom sheet
      Navigator.pop(context);
    }
  }

  Future _pickImageFromTheGallery() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        returnedImage = pickedFile;
      });
    }
    print(returnedImage!.path);
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(28)),
                border: Border.all(color: AppColors.white, width: 1.4),
                image: DecorationImage(
                  image: AssetImage("assets/png/add pp.png"),
                ),
              ),
              child: InkWell(onTap: _pickImageFromTheGallery),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _controller1.text == '' ? 'UserName' : _controller1.text,
                      style: TextStyle(color: AppColors.white),
                    ),
                    Divider(),
                    Text(
                      _controller2.text == '' ? 'Email' : _controller2.text,
                      style: TextStyle(color: AppColors.white),
                    ),
                    Divider(),
                    Text(
                      _controller3.text == '' ? 'Phone' : _controller3.text,
                      style: TextStyle(color: AppColors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),

        // Divider(),
        Expanded(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Spacer(),
                usedTextFormField(
                  _controller1,
                  TextInputType.name,
                  'User Name',
                ),
                Spacer(),
                usedTextFormField(
                  _controller2,
                  TextInputType.emailAddress,
                  'Email Address',
                  maxLength: 25,
                ),
                Spacer(),
                usedTextFormField(
                  _controller3,
                  TextInputType.phone,
                  'Phone Number',
                ),
                Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      _submitForm();
                      setState(() {
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      // minimumSize: Size.infinite,
                    ),
                    child: Text("Save"),
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
