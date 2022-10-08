// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/SocialUserModel.dart';
import 'package:social_app/modules/Register/RegisterStates.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(InitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);


  void userRegister(
      {required String email,required String password, required String name, required String phone})
  {
    emit(RegisterLoadingState());
   FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password)
       .then((value) {
         print(value.user!.uid);
         userCreate(email: email, uId: value.user!.uid, name: name, phone: phone);
         emit(RegisterSuccessState());
       })
       .catchError((error){emit(RegisterErrorState(error.toString()));});
  }
  void userCreate(
      {required String email,required String uId, required String name, required String phone})
  {
    UserModel userModel=UserModel(email: email, name: name, phone: phone, uId: uId,bio: 'Write bio ...' ,isVerified: false
        ,image:'https://img.freepik.com/free-photo/waist-up-portait-feminine-cute-happy-smiling-woman-touching-pure-clean-'
            'skin-grinning-delighted-as-got-rid-blemishes-acne-feeling-relived-beautiful-standing-white-background_176420-37007.jpg?'
            't=st=1664888670~exp=1664889270~hmac=9e50f9235dc39cefbe7502f30cc27784d252838be97edab566e024557a00f1dd',
        cover:
        'https://img.freepik.com/free-photo/waist-up-portait-feminine-cute-happy-smiling-woman-touching-pure-clean-'
            'skin-grinning-delighted-as-got-rid-blemishes-acne-feeling-relived-beautiful-standing-white-background_176420-37007.jpg?'
            't=st=1664888670~exp=1664889270~hmac=9e50f9235dc39cefbe7502f30cc27784d252838be97edab566e024557a00f1dd'
         );
        FirebaseFirestore.instance.collection('users')
            .doc(uId).set(userModel.toMap()).then((value) {
          emit(RegisterCreateUserSuccessState());  })
            .catchError((error){
              emit(RegisterCreateUserErrorState(error.toString()));
        });
   }

  bool isSecure = true;
  void visable() {
    isSecure = !isSecure;
    emit(RegisterVisabilityState());
  }
}
