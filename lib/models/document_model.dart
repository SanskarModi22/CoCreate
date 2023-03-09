import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class DocumentModel {
  final String title;
  final String uid;
  final List? content;
  final DateTime createdAt;
  final String id;
  DocumentModel({
    required this.title,
    required this.uid,
    required this.content,
    required this.createdAt,
    required this.id,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'uid': uid,
      'content': content,
      'createdAt': createdAt.millisecondsSinceEpoch,
      '_id': id,
    };
  }

  factory DocumentModel.fromMap(Map<String, dynamic> map) {
    return DocumentModel(
      title: map['title'] ?? '',
      uid: map['uid'] ?? '',
      content: List.from((map['content'] ?? List.empty())),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] ?? 0),
      id: map['_id'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory DocumentModel.fromJson(String source) =>
      DocumentModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
