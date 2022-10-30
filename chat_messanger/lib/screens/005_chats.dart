import 'package:chat_messanger/utility/components.dart';
import 'package:chat_messanger/utility/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // List<Map> messageData = [];
  late String _reciever;
  String typedtext = '';
  final _auth = FirebaseAuth.instance;

  late User currentUser;
  final _fireStore = FirebaseFirestore.instance;
  CollectionReference msgCollection =
      FirebaseFirestore.instance.collection("messages");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
    getMessages();
  }

  void getMessages() async {
    var data = await msgCollection.orderBy('createdAt').get();
    print(data);
  }

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        setState(() {
          currentUser = user;
        });
      }
    } catch (err) {
      debugPrint(err.toString());
    }
  }

  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    if (arg != null) {
      setState(() {
        _reciever = arg['receiver'];
      });
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(30),
        )),
        backgroundColor: AppColors.primarycolor,
        title: const Text(
          'LETS TALK',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          StreamBuilder(
            stream: _fireStore
                .collection("messages")
                .orderBy('createdAt')
                .snapshots(),
            builder: ((context, snapshot) {
              List<Map> messageData = [];

              if (snapshot.hasData) {
                // for (var data in snapshot.data!.docs) {
                //   String texter = data.data()['sender'];
                //   String rec = data.data()['receiver'];
                //   if (((texter == currentUser.email) && (rec == _reciever)) ||
                //       ((currentUser.email == _reciever) &&
                //           (rec == currentUser.email))) {
                //     messageData.add({
                //       'isMe': texter == currentUser.email,
                //       'username':
                //           texter == _reciever ? texter.split('@')[0] : 'you',
                //       'message': data.data()['message'],
                //     });
                //   }
                // }
              }

              final allMessages = snapshot.data;
              print(allMessages.size);

              return Expanded(
                child: messageData.isEmpty
                    ? const Center(
                        child: Text('No Chats Found'),
                      )
                    : ListView(
                        children: <MessageBubble>[
                          for (var msgData in messageData)
                            MessageBubble(
                              username: msgData['username'],
                              isMe: msgData['isMe'],
                              message: msgData['message'],
                            ),
                        ],
                      ),
              );
            }),
          ),
          Container(
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextEntry(
                      onChanged: (val) {
                        setState(() {
                          typedtext = val;
                        });
                      },
                      hintText: 'type your message here',
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ButtonRound(
                      onPressed: () {
                        msgCollection.add({
                          'text': typedtext,
                          'reciever': _reciever,
                          'sender': currentUser.email,
                          'createdAt': Timestamp.now(),
                        });
                        setState(() {
                          typedtext = '';
                        });
                      },
                      isicon: true,
                      title: 'hi',
                      color: AppColors.primarycolor,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// class MessageStream extends StatelessWidget {
//   const MessageStream({
//     Key? key,
//     required this.sender,
//     required this.receiver,
//   }) : super(key: key);

//   final String sender;
//   final String receiver;

//   @override
//   Widget build(BuildContext context) {
//     final _firestore = FirebaseFirestore.instance;

//     return StreamBuilder(
//       stream:
//           _firestore.collection('messages').orderBy('createdAt').snapshots(),
//       builder: ((context, snapshot) {
//         List<Map> messageData = [];
//         if (snapshot.hasData) {
//           for (var data in snapshot.data!.docs) {}
//         }
//         final allMessages = snapshot.data;
//         // for (var msg in allMessages.documents) {
//         //   print(msg);
//         // }

//         return Expanded(
//           child: messageData.isEmpty
//               ? const Center(
//                   child: Text('No chats found'),
//                 )
//               : ListView(
//                   children: [
//                     for (var msgData in messageData)
//                       MessageBubble(
//                         isMe: msgData['isMe'],
//                         username: msgData['username'],
//                         message: msgData['message'],
//                       ),
//                   ],
//                 ),
//         );
//       }),
//     );
//   }
// }

// Expanded(
//             child: ListView(
//               children: [
//                 for (var msgData in messageData)
//                   MessageBubble(
//                     isMe: msgData['isMe'],
//                     username: msgData['username'],
//                     message: msgData['message'],
//                   ),
//               ],
//             ),
//           )
