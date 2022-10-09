import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/SocialUserModel.dart';
import 'package:social_app/modules/Home_Layout/Home_States.dart';
import 'package:social_app/modules/Home_Layout/Home_cubit.dart';
import 'package:social_app/modules/Navbar_Screens/Chat.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return ConditionalBuilder(
              condition: HomeCubit.get(context).chatUsers.isNotEmpty,
              builder: (context) {
                return ListView.separated(
                  physics:const BouncingScrollPhysics(),
                    itemBuilder:(context, index) => chatBuilder(HomeCubit.get(context).chatUsers[index],context),
                    separatorBuilder:(context, index) =>const Divider(color: Colors.black,height: 2,),
                    itemCount: HomeCubit.get(context).chatUsers.length);} ,
              fallback:(context) => const Center(child: CircularProgressIndicator(),));
        },);
  }
}

Widget chatBuilder (UserModel user,context)
{
  return InkWell(
    onTap: (){
      Navigator.push(context, MaterialPageRoute(builder: (context) => Chat(user: user,),));
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children:  [

          CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(user.image!),
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: Text(user.name!),
          ),
        ],
      ),
    ),
  );
}
