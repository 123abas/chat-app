import 'package:flutter/material.dart';

class CustomBottun extends StatelessWidget {
   CustomBottun({super.key,  this .onTap,required this.title});
String title;
VoidCallback?onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onTap,
      child: Container(
                height: 55,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
      
                  color: Colors.white,
                ),
                child: Center(child: Text(title)),
              ),
    );
  }
}