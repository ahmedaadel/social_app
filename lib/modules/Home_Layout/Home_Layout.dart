import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/Home_Layout/Home_States.dart';
import 'package:social_app/modules/Home_Layout/Home_cubit.dart';
import 'package:social_app/modules/Navbar_Screens/PostScreen.dart';
import 'package:flutter_iconly/flutter_iconly.dart';


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
                IconButton(onPressed: (){}, icon:const Icon(IconlyBroken.notification)),
                IconButton(onPressed: (){}, icon:const Icon(IconlyBroken.search)),
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
                BottomNavigationBarItem(icon: Icon(IconlyBroken.home),label:'Home'),
                BottomNavigationBarItem(icon: Icon(IconlyBroken.chat),label:'Chat'),
                BottomNavigationBarItem(icon: Icon(Icons.post_add_outlined),label:'Post'),
                BottomNavigationBarItem(icon: Icon(IconlyBroken.location),label:'Users'),
                BottomNavigationBarItem(icon: Icon(IconlyBroken.setting),label:'Settings')
              ],
            ),
        );
      },
    );
  }
}
