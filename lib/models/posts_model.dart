class PostsModel {
  PostsModel(
      {required this.title,
      required this.text,
      required this.id,
      required this.creator});
  final String? title;
  final String? text;
  final int? id;
  final String? creator;

  PostsModel.fromMap(Map<String, dynamic> item):
        id=item["id"], title= item["title"],  text = item[""], creator=item["creator"];

  Map<String, Object> toMap(){
    return {'id':id ?? 0,'description': title ?? '', 'text':text ?? '', 'creator': creator ?? ''};
}}
