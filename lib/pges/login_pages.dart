import 'package:chat_app/pges/chat_page.dart';
import 'package:chat_app/pges/custom_bottun.dart';
import 'package:chat_app/pges/custom_text_field.dart';
import 'package:chat_app/pges/regiser_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/pges/constants.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginPages extends StatefulWidget {
  LoginPages({super.key});

  @override
  State<LoginPages> createState() => _LoginPagesState();
}

class _LoginPagesState extends State<LoginPages> {
  String? email;

  String? password;

  GlobalKey<FormState> formkey = GlobalKey();

  bool isLoading = false;
  //const LoginPages({});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Form(
            key: formkey,
            child: ListView(
              children: [
                SizedBox(height: 100),
                Image.asset('assets/images/scholar.png', height: 100),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Scholar Chat',
                      style: TextStyle(
                        fontSize: 33,
                        color: Colors.white,
                        fontFamily: 'pacifico',
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'LOGIN',
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        
                      ),
                    ),
                  ],
                ),

                CustomTextFormField(
                  onChanged: (data) {
                    email = data;
                  },
                  hitText: 'Email',
                ),
                SizedBox(height: 20),
                CustomTextFormField(
                  obscure: true,
                  onChanged: (data) {
                    password = data;
                  },
                  hitText: 'Password',
                ),
                SizedBox(height: 20),
                CustomBottun(
                  onTap: () async {
                    if (formkey.currentState!.validate()) {
                      isLoading = true;
                      //update ui
                      setState(() {});
                      try {
                        var auth = FirebaseAuth.instance;

                        UserCredential user = await auth
                            .signInWithEmailAndPassword(
                              email: email!,
                              password: password!,
                            );

                        Navigator.pushNamed(
                          context,
                          ChatPage.id,
                          arguments: email,
                        );
                        
                      } on FirebaseAuthException catch (ex) {
                        if (ex.code == 'user-not-found') {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('No user found for that email.'),
                            ),
                          );
                        } else if (ex.code == 'wrong-password') {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Wrong password provided for that user.',
                              ),
                            ),
                          );
                        }
                      } catch (ex) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.white,
                            content: Text('There was an error!'),
                          ),
                        );
                      }
                     
                      isLoading = false;
                      //update ui
                      setState(() {});
                    }
                  },
                  title: 'Login',
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Dont have an account ?',
                      style: TextStyle(color: Colors.white),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, 'RegiserPage');
                      },
                      child: Text(
                        'Register ',
                        style: TextStyle(color: Color(0xffC7EDE6)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
