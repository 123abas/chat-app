import 'package:chat_app/models/message.dart';
import 'package:chat_app/pges/chatBuble.dart';
import 'package:chat_app/pges/constants.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatPage extends StatelessWidget {
  ChatPage({super.key});
  static String id = 'ChatPage';
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference messages = FirebaseFirestore.instance.collection(
    kMessagesColloection,
  );
  TextEditingController controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    //second user
    var email = ModalRoute.of(context)!.settings.arguments;
    //QuerySnapshot=all our document-
    return StreamBuilder<QuerySnapshot>(
      //messages=reference
      stream: messages.orderBy('createdAt', descending: true).snapshots(),

      builder: (context, snapShot) {
        if (snapShot.hasData) {
          List<Message> messagesList = [];
          for (int i = 0; i < snapShot.data!.docs.length; i++) {
            messagesList.add(Message.fromJson(snapShot.data!.docs[i]));
          }

          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: kPrimaryColor,

              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/scholar.png',
                    width: 50,
                    height: 40,
                  ),

                  Text('ScolrChat', style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
            body: Column(
              children: [
                //تاخد المساحه ال عيزاها داخل كولمن
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    controller: _scrollController,
                    itemCount: messagesList.length,
                    itemBuilder: (context, index) {
                      return messagesList[index].id == email
                          ? ChatBuble(message: messagesList[index])
                          : ChatBubleForFriend(message: messagesList[index]);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    controller: controller,
                    onSubmitted: (data) {
                      //add as a map-fire base
                      messages.add({
                        'message': data,
                        'createdAt': DateTime.now(),
                        'id': email,
                      });
                      controller.clear();
                      _scrollController.animateTo(
                        
                        // _scrollController.position.maxScrollExtent,
                        0,
                        duration: Duration(milliseconds: 300),
                        //شكل الحركه
                        curve: Curves.easeIn,
                      );
                    },
                    decoration: InputDecoration(
                      suffix: Icon(Icons.send),
                      hintText: 'Send Message',

                     
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: kPrimaryColor),
                      ),
                      
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: kPrimaryColor),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else
          return Text('..');
      },
    );
  }
}
