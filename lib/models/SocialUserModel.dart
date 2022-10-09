class UserModel {
   String? name ;
   String? email ;
   String? uId ;
   String? phone ;
   bool? isVerified ;
   String? image;
   String? cover;
   String? bio;

  UserModel({ this.email, this.name,
     this.phone, this.uId ,
     this.isVerified, this.image, this.cover, this.bio});

  UserModel.fromJson(Map<String,dynamic>? json)
  {

    name=json!['name'];
    email=json!['email'];
    phone=json!['phone'];
    isVerified=json!['isVerified'];
    uId=json!['uid'];
    image=json!['image'];
    cover=json!['cover'];
    bio=json!['bio'];
  }


  Map<String,dynamic> toMap ()
  {
    return {
      'name':name,
    'email':email,
    'phone':phone,
      'uid':uId,
      'isVerified':isVerified,
      'image':image,
      'cover':cover,
      'bio':bio,
    };
  }
}