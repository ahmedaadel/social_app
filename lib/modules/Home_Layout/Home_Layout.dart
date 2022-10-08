import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/Home_Layout/Home_States.dart';
import 'package:social_app/modules/Home_Layout/Home_cubit.dart';
import 'package:social_app/modules/Navbar_Screens/PostScreen.dart';
import 'package:social_app/shared/components/components.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if(state is BottomAddPostState)
          {
            Navigator.push(context, MaterialPageRoute(builder: (context) => AddPost(),));
          }
      },
      builder: (context, state) {
        var cubit =  HomeCubit.get(context);
        return Scaffold(
            appBar: AppBar(
              title: Text(cubit.titles[cubit.currentIndex]),
              actions: [
                IconButton(onPressed: (){}, icon:const Icon(Icons.snapchat)),
                IconButton(onPressed: (){}, icon:const Icon(Icons.search)),
              ],
            ),
            body: cubit.screens[cubit.currentIndex],
          
            bottomNavigationBar: BottomNavigationBar(
              onTap: (index){
                cubit.changeNavBar(index);
              },
              currentIndex: cubit.currentIndex,
              items: const
              [
                BottomNavigationBarItem(icon: Icon(Icons.home),label:'Home'),
                BottomNavigationBarItem(icon: Icon(Icons.chat_bubble),label:'Chat'),
                BottomNavigationBarItem(icon: Icon(Icons.post_add_outlined),label:'Post'),
                BottomNavigationBarItem(icon: Icon(Icons.location_on),label:'Users'),
                BottomNavigationBarItem(icon: Icon(Icons.settings),label:'Settings')
              ],
            ),
        );
      },
    );
  }
}
