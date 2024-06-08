class ChatRoom {
  String chatId;
  String senderId;
  String receiverId;
  List<String>? messages;

  ChatRoom({
    required this.chatId,
    required this.senderId,
    required this.receiverId,
  });

  Map<String, dynamic> toMapMessage() {
    return {
      'chat id': chatId,
      'sender id': senderId,
      'receiver id': receiverId,
      'messages': messages,
    };
  }
}
