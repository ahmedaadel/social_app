import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/models/Message%20_model.dart';
import 'package:social_app/models/Post_Model.dart';
import 'package:social_app/models/SocialUserModel.dart';
import 'package:social_app/modules/Home_Layout/Home_States.dart';
import 'package:social_app/modules/Navbar_Screens/ChatsSreen.dart';
import 'package:social_app/modules/Navbar_Screens/FeedScreen.dart';
import 'package:social_app/modules/Navbar_Screens/PostScreen.dart';
import 'package:social_app/modules/Navbar_Screens/SettingsScreen.dart';
import 'package:social_app/modules/Navbar_Screens/UserScreen.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(InitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  UserModel? user;

  void getUser() {
    emit(GetUserLoadingState());

    FirebaseFirestore.instance
        .collection('users')
        .doc(UserID)
        .get()
        .then((value) {
      user = UserModel.fromJson(value.data());
      print(user!.toMap());
      emit(GetUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetUserErrorState());
    });
  }

  int currentIndex = 0;
  List<Widget> screens =
   [
     const FeedsScreen(),
     const ChatsScreen(),
     AddPost(),
     const UserScreen(),
     const SettingsScreen()
  ];

  List<String> titles = ['Feeds', 'Chats', 'Add Post', 'Users', 'Settings'];

  void changeNavBar(int index) {
    if(index==1)
      {
        currentIndex = index;
        getAllUsers();
      }
    if (index == 2) {
      emit(BottomAddPostState());
    } else {
      currentIndex = index;
      emit(BottomNavChangeState());
    }
  }

  File? profileImage;
  var picker = ImagePicker();
  Future<void> getProfileImage() async {
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(GetProfileImageSuccessState());
    } else {
      print('No Image Selected ');
      emit(GetProfileImageErrorState());
    }
  }


  File? coverImage;
  Future<void> getCoverImage() async {
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(GetProfileImageSuccessState());
    } else {
      print('No Image Selected ');
      emit(GetProfileImageErrorState());
    }
  }

  void uploadProfileImage({required String bio,
    required String name,
    required String phone})
  {
    emit(UpdateUserLoadingState());

      firebase_storage.FirebaseStorage.instance
        .ref()
        .child('file/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value.toString());
        updateUser(bio:bio ,name:name ,phone:phone ,image: value);
        //emit(GetUploadProfileImageSuccessState());
      }).catchError((error) {
        print(error);
      });
    }).catchError((error) {
      print(error.toString());
      emit(GetUploadProfileImageErrorState());
    });
  }

  void uploadCoverImage({required String bio,
  required String name,
  required String phone})
  {
    emit(UpdateUserLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((p0) {
      p0.ref.getDownloadURL().
      then((value) {
        print(value.toString());
        updateUser(bio:bio ,name:name ,phone:phone ,cover: value);
        //emit(GetCoverUploadImageSuccessState());
      }).catchError((error) {
        print(error);
      });
    }).catchError((error) {
      print(error);
      emit(GetCoverUploadImageErrorState());
    });
  }

  void updateUser(
      {required String bio,
      required String name,
      required String phone,
      String? cover,
      String? image})
  {
    UserModel userModel = UserModel(
      name: name,
      phone: phone,
      bio: bio,
      isVerified: false,
      image: image ?? user!.image,
      cover: cover ?? user!.cover,
      email: user!.email,
      uId: UserID,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(UserID)
        .update(userModel.toMap())
        .then((value) {
      getUser();
    }).catchError((error) {
      print(error);
      emit(UpdateUserErrorState());
    });
  }


  File? postImage;
  Future<void> getPostImage() async {
    final XFile? pickedFile =
    await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(GetPostImageSuccessState());
    } else {
      print('No Image Selected ');
      emit(GetPostImageErrorState());
    }
  }

  void removePostImage(){
    postImage =null ;
    emit(RemovePostImageState());
  }


  void uploadPostImage(
      {
    required String dateTime,
    required String text,}
      )
  {
    emit(CreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((p0) {
      p0.ref.getDownloadURL().
      then((value) {
        createPost(dateTime: dateTime, text: text ,postImage: value);
      }).catchError((error) {
        print(error);
      });
    }).catchError((error) {
      print(error);
      emit(CreatePostErrorState());
    });
  }


  void createPost(
      {
        required String dateTime,
        required String text,
        String? postImage
      })
  {
    emit(CreatePostLoadingState());
    PostModel userModel = PostModel(
      name: user!.name,
      uId: UserID,
      image: user!.image,
      dateTime: dateTime ,
      text: text,
      postImage: postImage ?? '',
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(userModel.toMap())
        .then((value) {
          emit(CreatePostSuccessState());
    }).catchError((error) {
      print(error);
      emit(CreatePostErrorState());
    });
  }

 List<PostModel> posts =[];
  List<String> postId =[];
  List<int> likes =[];
  void getPosts()
  {
    emit(GetPostsLoadingState());
    FirebaseFirestore.instance.collection('posts').get().
    then((value) {
      value.docs.forEach((element)
      {
        postId.add(element.id);
        posts.add(PostModel.fromJson(element.data()));
        element.reference.collection('likes').get().then((value) {
          likes.add(value.docs.length);
        }).catchError((){});
      });
      emit(GetPostsSuccessState());
    }).
    catchError((error){
      emit(GetPostsErrorState());});
  }


  void likePost(String id)
  {
    FirebaseFirestore.instance.collection('posts').doc(id).collection('likes')
        .doc(UserID).set({'like': true}).
    then((value) {
      emit(PostLikeSuccessState());
    }).catchError((error){emit(PostLikeErrorState());});
  }

  List<UserModel> chatUsers =[];
  void getAllUsers()
  {
    if(chatUsers.isEmpty)
    {
      FirebaseFirestore.instance.collection('users').get().
      then((value)
      {
        value.docs.forEach((element)
        {
          if(element.id != UserID)
          {
            chatUsers.add(UserModel.fromJson(element.data()));
          }
        });
        emit(GetAllUserSuccessState());
      }).
      catchError((error){
        emit(GetAllUserErrorState());});
    }
  }


  void sendingMessage({required String receiverId,required String text ,required String dateTime})
  {
    MessageModel model =MessageModel(text: text,dateTime: dateTime , receiverId: receiverId,senderId: UserID) ;
    FirebaseFirestore.instance.collection('users').doc(UserID).collection('chats').
    doc(receiverId).collection('message').
    add(model.toMap()).then((value) {
      emit( SendMessageSuccessState());
    }).catchError((error){
      print(error);
      emit( SendMessageErrorState());
    });

    FirebaseFirestore.instance.collection('users').doc(receiverId).collection('chats').
    doc(UserID).collection('message').
    add(model.toMap()).then((value) {
      emit( SendMessageToFriendSuccessState());
    }).catchError((error){
      print(error);
      emit( SendMessageToFriendErrorState());
    });

  }


  List<MessageModel> messages =[];

  void getMessages({required String receiverId})
  {
    FirebaseFirestore.instance.collection('users').doc(UserID).collection('chats').doc(receiverId)
        .collection('message').orderBy('dateTime').snapshots().listen((event) {
          messages=[];
          event.docs.forEach((element) {
            messages.add(MessageModel.fromJson(element.data()));
          });
          emit(GetMessageSuccessState());
    });

  }


}

