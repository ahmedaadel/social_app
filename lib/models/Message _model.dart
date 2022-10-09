class MessageModel {
  String? senderId;
  String? receiverId;
  String? text;
  String? dateTime;

  MessageModel({this.dateTime, this.senderId, this.text, this.receiverId});

  MessageModel.fromJson(Map<String, dynamic>? json) {
    text = json!['text'];
    dateTime = json!['dateTime'];
    senderId = json!['senderId'];
    receiverId = json!['receiverId'];
  }

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'text': text,
      'dateTime': dateTime,
    };
  }
}
