import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:social_app/models/SocialUserModel.dart';
import 'package:social_app/modules/Home_Layout/Home_States.dart';
import 'package:social_app/modules/Home_Layout/Home_cubit.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:social_app/shared/styles/Color.dart';

class Chat extends StatelessWidget {
  UserModel user;
  var messageController = TextEditingController();
  Chat({super.key, required this.user});
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        HomeCubit.get(context).getMessages(receiverId: user.uId!);
        return BlocConsumer<HomeCubit, HomeStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = HomeCubit.get(context);

            return Scaffold(
              appBar: AppBar(
                title: Row(
                  children: [
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
              body: ConditionalBuilder(
                condition: cubit.messages.isNotEmpty,
                fallback: (context) => const Center(child: CircularProgressIndicator()),
                builder: (context) => Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(itemCount:cubit.messages.length ,separatorBuilder: (context, index) => const SizedBox(height: 15,),
                          itemBuilder: (context, index) {
                            if(cubit.messages[index].receiverId ==UserID) {
                              return Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadiusDirectional.only(
                                        topStart: Radius.circular(10),
                                        bottomEnd: Radius.circular(10),
                                        topEnd: Radius.circular(10)),
                                    color: Colors.grey[300],
                                  ),
                                  padding:
                                  const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                  child:  Text(cubit.messages[index].text!),
                                ),
                              );
                            }
                            return  Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadiusDirectional.only(
                                      topStart: Radius.circular(10),
                                      bottomStart: Radius.circular(10),
                                      topEnd: Radius.circular(10)),
                                  color: defaultColor.withOpacity(.2),
                                ),
                                padding:
                                const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                child: Text(cubit.messages[index].text!),
                              ),
                            );
                          },
                        ),
                      ),

                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[300]!, width: 1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 7,
                            ),
                            Expanded(
                              child: TextFormField(
                                controller: messageController,
                                decoration: const InputDecoration(
                                    hintText: 'Type Here', border: InputBorder.none),
                              ),
                            ),
                            Container(
                                height: 50,
                                width: 60,
                                color: defaultColor,
                                child: MaterialButton(
                                    onPressed: () {
                                      cubit.sendingMessage(
                                          receiverId: user.uId!,
                                          text: messageController.text,
                                          dateTime: DateTime.now().toString());
                                    },
                                    child: const Icon(
                                      IconlyBroken.send,
                                      color: Colors.white,
                                      size: 18,
                                    )))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        );
      } ,

    );
  }
}
