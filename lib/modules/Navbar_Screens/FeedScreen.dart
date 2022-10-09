import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:social_app/models/Post_Model.dart';
import 'package:social_app/modules/Home_Layout/Home_States.dart';
import 'package:social_app/modules/Home_Layout/Home_cubit.dart';
import 'package:social_app/shared/styles/Color.dart';

class FeedsScreen extends StatelessWidget
{
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.posts.isNotEmpty && cubit.likes.isNotEmpty,
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
          builder: (context) => SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 180,
                  width: double.infinity,
                  child: Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    margin: const EdgeInsets.all(8.0),
                    elevation: 10,
                    child: Stack(
                      alignment: Alignment.bottomLeft,
                      children: [
                        const Image(
                            image: NetworkImage(
                                'https://img.freepik.com/free-photo/stylish-smiling-blond-female-student-glasses-looking'
                                '-happy_176420-22041.jpg?w=1060&t=st=1664776689~exp=1664777289~'
                                'hmac=c7f3c00ba133333fe7e3986c766287a513454f645d91ff14189f01190e5dbfbb'),
                            width: double.infinity,
                            fit: BoxFit.fitWidth),
                        Text(
                          'Communicate with Friends',
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(color: Colors.black, fontSize: 16),
                        )
                      ],
                    ),
                  ),
                ),
                ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) =>
                        buildPostItem(cubit.posts[index], context,index),
                    separatorBuilder: (context, index) => const SizedBox(
                          height: 8,
                        ),
                    itemCount: cubit.posts.length),
                const SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget buildPostItem(PostModel posts, context,index) => Card(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    margin: const EdgeInsets.all(8.0),
    elevation: 5,
    child: Padding(
      padding: const EdgeInsets.all(6.0),
      child: Column(
        crossAxisAlignment:CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(posts.image!),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(posts.name!),
                        const SizedBox(
                          width: 5,
                        ),
                        const Icon(
                          Icons.check_circle,
                          size: 14,
                          color: defaultColor,
                        )
                      ],
                    ),
                    Text(
                      posts.dateTime!,
                      style: Theme.of(context).textTheme.caption,
                    )
                  ],
                ),
              ),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.more_horiz,
                    size: 16,
                  ))
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              height: 1,
              color: Colors.grey[400],
            ),
          ),
          Text(posts.text!,style: TextStyle(fontWeight: FontWeight.bold),),
          // Padding(
          //   padding: const EdgeInsets.only(top:4,bottom: 4),
          //   child: Container(
          //     width: double.infinity,
          //     child: Wrap(
          //       children: [
          //         Padding(
          //           padding: const EdgeInsetsDirectional.only(end: 6),
          //           child: Container(
          //             height: 25,
          //             child: MaterialButton(
          //               onPressed: (){},
          //               minWidth: 1.0,
          //               padding: EdgeInsets.zero,
          //               child:const  Text('#software',style: TextStyle(color:defaultColor ),),
          //             ),
          //           ),
          //         ),
          //         Container(
          //           height: 25,
          //           child: MaterialButton(
          //             onPressed: (){},
          //             minWidth: 1.0,
          //             padding: EdgeInsets.zero,
          //             child:const  Text('#software',style: TextStyle(color:defaultColor ),),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          if (posts.postImage != '')
            Padding(
              padding: const EdgeInsetsDirectional.only(top: 10.0),
              child: Container(
                width: double.infinity,
                height: 150,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                      image: NetworkImage(posts.postImage!),
                      fit: BoxFit.cover,
                    )),
              ),
            ),
         const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                Expanded(
                    child: InkWell(
                  child: Row(
                    children: [
                      const Icon(
                        IconlyBroken.heart,
                        color: Colors.red,
                        size: 15,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        '${HomeCubit.get(context).likes[index]}',
                        style: Theme.of(context).textTheme.caption,
                      )
                    ],
                  ),
                  onTap: () {},
                )),
                Expanded(
                    child: InkWell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Icon(
                        IconlyBroken.chat,
                        size: 15,
                        color: Colors.green,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        '0 comment',
                        style: Theme.of(context).textTheme.caption,
                      )
                    ],
                  ),
                  onTap: () {},
                )),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8, top: 8),
            child: Container(
              width: double.infinity,
              height: 1,
              color: Colors.grey[400],
            ),
          ),
          Row(
            children: [
               CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(HomeCubit.get(context).user!.image!),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                  child: InkWell(
                      child: Text(
                'Write a comment ...',
                style: Theme.of(context).textTheme.caption,
              ))),
              InkWell(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Icon(
                      IconlyBroken.heart,
                      color: Colors.red,
                      size: 15,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Like',
                      style: Theme.of(context).textTheme.caption,
                    )
                  ],
                ),
                onTap: () {
                  HomeCubit.get(context).likePost(HomeCubit.get(context).postId[index]);
                },
              )
            ],
          ),
        ],
      ),
    ));
