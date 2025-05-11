import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({super.key, this.hitText,this.onChanged,this .obscure=false});
  String? hitText;
  Function(String)?onChanged;
  bool? obscure;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText:obscure! ,
      validator: (data) {
        if(data!.isEmpty){
          return'field is required';
        }
      },
      onChanged: onChanged,
      decoration: InputDecoration(
        //general
        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        hintText: hitText,
        hintStyle: TextStyle(color: Colors.white),
      ),
    );
  }
}
