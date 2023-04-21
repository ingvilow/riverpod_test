class PostsModel {
  PostsModel({required this.title,
    required this.text,
    required this.id
  });
  final String? title;
  final String? text;
  final int? id;

  PostsModel.fromMap(Map<String, dynamic> item):
        id=item["id"], title= item["title"],  text = item["text"];

  Map<String, Object> toMap(){
    return {'id':id ?? 0,'title': title ?? 'title', 'text':text ?? ''};
}}
