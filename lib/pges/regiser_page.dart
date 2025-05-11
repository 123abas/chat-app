import 'package:chat_app/pges/chat_page.dart';
import 'package:chat_app/pges/custom_bottun.dart';
import 'package:chat_app/pges/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegiserPage extends StatefulWidget {
  RegiserPage({super.key});

  @override
  State<RegiserPage> createState() => _RegiserPageState();
}

class _RegiserPageState extends State<RegiserPage> {
  String? email;

  String? password;

  GlobalKey<FormState> formkey = GlobalKey();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: Color(0xff2B475E),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Form(
            key: formkey,

            child: ListView(
              children: [
                SizedBox(height: 100),
                Image.asset('assets/images/scholar.png', height: 120,),
                SizedBox(height: 10),
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
                const SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      'REGISTER',
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        //fontFamily: 'pacifico',
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
                  onChanged: (data) {
                    password = data;
                  },
                  hitText: 'Password',
                ),
                const SizedBox(height: 20),
                CustomBottun(
                  onTap: () async {
                    if (formkey.currentState!.validate()) {
                      
                      isLoading = true;
                      //update ui
                      setState(() {});
                      try {
                        var auth = FirebaseAuth.instance;

                        UserCredential user = await auth
                            .createUserWithEmailAndPassword(
                              email: email!,
                              password: password!,
                            );
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.white,
                            content: Text('Success...'),
                          ),
                           );
                           Navigator.pushNamed(context, ChatPage.id);
                       
                        //Navigator.pop(context);
                      } on FirebaseAuthException catch (ex) {
                        if (ex.code == 'weak-password') {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('weak password')),
                          );
                        } else if (ex.code == 'email-already-in-use') {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('email-already-in-use')),
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
                  title: 'REGISTER',
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'already have an account ?',
                      style: TextStyle(color: Colors.white),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Login ',
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
