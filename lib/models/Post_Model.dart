class PostModel {
  String? name ;
  String? uId ;
  String? image;
  String? postImage;
  String? text;
  String? dateTime ;
  PostModel({ this.dateTime, this.name,
    this.text, this.uId ,this.postImage,
     this.image});

  PostModel.fromJson(Map<String,dynamic>? json)
  {

    name=json!['name'];
    text=json!['text'];
    dateTime=json!['dateTime'];
    uId=json!['uId'];
    image=json!['image'];
    postImage=json!['postImage'];

  }


  Map<String,dynamic> toMap ()
  {
    return {
      'name':name,
      'uid':uId,
      'image':image,
      'text':text,
      'dateTime':dateTime,
      'postImage':postImage,
    };
  }
}