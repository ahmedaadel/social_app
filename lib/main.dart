import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/firebase_options.dart';
import 'package:social_app/modules/Home_Layout/Home_Layout.dart';
import 'package:social_app/modules/Home_Layout/Home_States.dart';
import 'package:social_app/modules/Home_Layout/Home_cubit.dart';
import 'package:social_app/modules/Login/LoginScreen.dart';
import 'package:social_app/shared/bloc_observer.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:social_app/shared/local/Shared_prefrences.dart';
import 'package:social_app/shared/styles/Theme.dart';


void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await CacheHelper.init();
  Widget current =LoginScreen();
  UserID=CacheHelper.getData(key: 'uId');
  if( UserID != null)
    {
      current = const HomeLayout();

    }
  runApp(MyApp(currentScreen: current));
}

class MyApp extends StatelessWidget {
  Widget currentScreen ;
   MyApp({super.key, required  this.currentScreen});


  @override
  Widget build(BuildContext context) {
    UserID=CacheHelper.getData(key: 'uId');
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => HomeCubit()..getUser()..getPosts(),)],
      child: BlocConsumer<HomeCubit,HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return  MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            home:currentScreen ,
          );
        },
      )
    );
  }
}
