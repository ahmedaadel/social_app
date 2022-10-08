import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
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

}


