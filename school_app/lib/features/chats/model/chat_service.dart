import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:school_app/features/auth/services/student_service.dart';
import 'package:school_app/features/posts/services/posts_services.dart';
import 'package:school_app/state/app_state.dart';
import 'package:school_app/widgets/widgets.dart';

class Chats {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  ApplicationState appState = ApplicationState();
  PostService postData = PostService();
  StudentService studentService = StudentService();
  bool hasNewMessage = false;
  Message? newMessage;

  Message _createMessageFromMap(Map<String, dynamic> messageMap) {
    return Message(
      text: messageMap['message'],
      date: (messageMap['time'] as Timestamp).toDate(),
      isSentByMe: _auth.currentUser!.uid == messageMap['sender id'],
    );
  }

  Map<String, dynamic> _createMessage(
      String senderId, String receiverId, String message) {
    return {
      'sender id': senderId,
      'receiver id': receiverId,
      'time': Timestamp.now(),
      'message': message,
    };
  }

  String _generateChatId(String senderId, String receiverId) {
    return '$senderId-$receiverId';
  }

  Future<void> createOrUpdateChat(
      String senderId, String receiverId, String message) async {
    final chatId = _generateChatId(senderId, receiverId);

    final existingChat = await _firestore.collection('chats').doc(chatId).get();

    if (existingChat.exists) {
      await _firestore.collection('chats').doc(chatId).update({
        'messages': FieldValue.arrayUnion(
            [_createMessage(senderId, receiverId, message)])
      });
    } else {
      final sharedChat = await _firestore
          .collection('chats')
          .where('sender id', isEqualTo: senderId)
          .where('receiver id', isEqualTo: receiverId)
          .get();

      if (sharedChat.docs.isNotEmpty) {
        await _firestore
            .collection('chats')
            .doc(sharedChat.docs.first.id)
            .update({
          'messages': FieldValue.arrayUnion(
              [_createMessage(senderId, receiverId, message)])
        });
      } else {
        await _firestore.collection('chats').doc(chatId).set({
          'chat id': chatId,
          'sender id': senderId,
          'receiver id': receiverId,
          'messages': [_createMessage(senderId, receiverId, message)]
        });
      }
    }
  }

  Future<List<Message>> getChatMessages(
      String senderId, String receiverId) async {
    try {
      CollectionReference chatCollection = _firestore.collection('chats');
      QuerySnapshot chatSnapshot = await chatCollection
          .where('sender id', isEqualTo: senderId)
          .where('receiver id', isEqualTo: receiverId)
          .get();

      if (chatSnapshot.docs.isNotEmpty) {
        DocumentSnapshot chatDoc = chatSnapshot.docs.first;
        List<Message> messages = [];
        List<dynamic>? messageData = chatDoc['messages'];

        if (messageData != null) {
          for (var messageMap in messageData) {
            Message message = Message(
              isSentByMe: _auth.currentUser!.uid == messageMap['sender id']
                  ? true
                  : false,
              text: messageMap['message'],
              date: (messageMap['time'] as Timestamp).toDate(),
            );
            messages.add(message);
          }
        }

        return messages;
      } else {
        return [];
      }
    } catch (error) {
      print("Erreur lors de la récupération des messages : $error");
      throw error;
    }
  }

  Future<List<Message>> getLatestMessage(String chatId) async {
    try {
      DocumentSnapshot chatDoc =
          await _firestore.collection('chats').doc(chatId).get();

      if (chatDoc.exists) {
        List<dynamic>? messageData = chatDoc['messages'];

        if (messageData != null && messageData.isNotEmpty) {
          messageData.sort((a, b) =>
              (b['time'] as Timestamp).compareTo((a['time'] as Timestamp)));

          Message latestMessage = Message(
            isSentByMe: _auth.currentUser!.uid == messageData[0]['sender id'],
            text: messageData[0]['message'],
            date: (messageData[0]['time'] as Timestamp).toDate(),
          );

          return [latestMessage];
        }
      }

      return [];
    } catch (error) {
      print("Erreur lors de la récupération du dernier message : $error");
      throw error;
    }
  }

  Future<List<DocumentSnapshot>> getStudentChats() async {
    User currentUser = _auth.currentUser!;
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('chats')
          .where('sender id', isEqualTo: currentUser.uid)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs;
      } else {
        return [];
      }
    } catch (err) {
      print("Error while retrieving chats: $err");
      throw (err);
    }
  }
}
