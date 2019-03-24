import 'package:flutter_chat/models/chat_room.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRoomsModel extends Model {
  List<ChatRoom> _chatrooms = [];
  List<ChatRoom> get chatrooms => _chatrooms;

  Future<void> fetchChatrooms() async {
    final docs = await Firestore.instance.collection('rooms').getDocuments();

    _chatrooms = docs.documents.map((doc) => ChatRoom(doc)).toList(
        growable: false)
      ..sort(
          (a, b) => a.lastMessage.timestamp.compareTo(b.lastMessage.timestamp));

    notifyListeners();
  }
}
