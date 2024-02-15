
class ChatElement {
  const ChatElement({
    required this.userName,
    required this.message,
  });

  final String userName;
  final String message;

  ChatElement.fromJson(Map<String, dynamic> json)
      : userName = json['userName'] as String,
        message = json['message'] as String;

}
