import 'dart:convert';


class Mensagem {
  String idUserFrom;
  String idUserTo;
  String message;
  String urlImage;
  String tipo;

  Mensagem({
    required this.idUserFrom,
    required this.idUserTo,
    required this.message,
    required this.urlImage,
    required this.tipo,
  });

  

  Mensagem copyWith({
    String? idUserFrom,
    String? idUserTo,
    String? message,
    String? urlImage,
    String? tipo,
  }) {
    return Mensagem(
      idUserFrom: idUserFrom ?? this.idUserFrom,
      idUserTo: idUserTo ?? this.idUserTo,
      message: message ?? this.message,
      urlImage: urlImage ?? this.urlImage,
      tipo: tipo ?? this.tipo,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'idUserFrom': idUserFrom,
      'idUserTo': idUserTo,
      'message': message,
      'urlImage': urlImage,
      'tipo': tipo,
      'data':DateTime.now()
    };
  }

  factory Mensagem.fromMap(Map<String, dynamic> map) {
    return Mensagem(
      idUserFrom: map['idUserFrom'] ?? '',
      idUserTo: map['idUserTo'] ?? '',
      message: map['message'] ?? '',
      urlImage: map['urlImage'] ?? '',
      tipo: map['tipo'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Mensagem.fromJson(String source) => Mensagem.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Mensagem(idUserFrom: $idUserFrom, idUserTo: $idUserTo, message: $message, urlImage: $urlImage, tipo: $tipo)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Mensagem &&
      other.idUserFrom == idUserFrom &&
      other.idUserTo == idUserTo &&
      other.message == message &&
      other.urlImage == urlImage &&
      other.tipo == tipo;
  }

  @override
  int get hashCode {
    return idUserFrom.hashCode ^
      idUserTo.hashCode ^
      message.hashCode ^
      urlImage.hashCode ^
      tipo.hashCode;
  }
}
