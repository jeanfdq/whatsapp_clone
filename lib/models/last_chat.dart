import 'dart:convert';

class LastChat {

  String userId;
  String messageUserId;
  String messageUserName;
  String messageUserProfile;
  String message;
  String urlPhoto;
  String typeMessage;
  LastChat({
    required this.userId,
    required this.messageUserId,
    required this.messageUserName,
    required this.messageUserProfile,
    required this.message,
    required this.urlPhoto,
    required this.typeMessage,
  });

  LastChat copyWith({
    String? userId,
    String? messageUserId,
    String? messageUserName,
    String? messageUserProfile,
    String? message,
    String? urlPhoto,
    String? typeMessage,
  }) {
    return LastChat(
      userId: userId ?? this.userId,
      messageUserId: messageUserId ?? this.messageUserId,
      messageUserName: messageUserName ?? this.messageUserName,
      messageUserProfile: messageUserProfile ?? this.messageUserProfile,
      message: message ?? this.message,
      urlPhoto: urlPhoto ?? this.urlPhoto,
      typeMessage: typeMessage ?? this.typeMessage,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'messageUserId': messageUserId,
      'messageUserName': messageUserName,
      'messageUserProfile': messageUserProfile,
      'message': message,
      'urlPhoto': urlPhoto,
      'typeMessage': typeMessage,
    };
  }

  factory LastChat.fromMap(Map<String, dynamic> map) {
    return LastChat(
      userId: map['userId'] ?? '',
      messageUserId: map['messageUserId'] ?? '',
      messageUserName: map['messageUserName'] ?? '',
      messageUserProfile: map['messageUserProfile'] ?? '',
      message: map['message'] ?? '',
      urlPhoto: map['urlPhoto'] ?? '',
      typeMessage: map['typeMessage'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory LastChat.fromJson(String source) => LastChat.fromMap(json.decode(source));

  @override
  String toString() {
    return 'LastChat(userId: $userId, messageUserId: $messageUserId, messageUserName: $messageUserName, messageUserProfile: $messageUserProfile, message: $message, urlPhoto: $urlPhoto, typeMessage: $typeMessage)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is LastChat &&
      other.userId == userId &&
      other.messageUserId == messageUserId &&
      other.messageUserName == messageUserName &&
      other.messageUserProfile == messageUserProfile &&
      other.message == message &&
      other.urlPhoto == urlPhoto &&
      other.typeMessage == typeMessage;
  }

  @override
  int get hashCode {
    return userId.hashCode ^
      messageUserId.hashCode ^
      messageUserName.hashCode ^
      messageUserProfile.hashCode ^
      message.hashCode ^
      urlPhoto.hashCode ^
      typeMessage.hashCode;
  }
}
