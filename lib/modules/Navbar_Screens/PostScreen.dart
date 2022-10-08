import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/Home_Layout/Home_States.dart';
import 'package:social_app/modules/Home_Layout/Home_cubit.dart';

class AddPost extends StatelessWidget {
  var textController = TextEditingController();

  AddPost({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('Create Post'),
            leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.pop(context);
                }),
            actions: [
              TextButton(
                onPressed: () {
                  var now = DateTime.now();
                  if (cubit.postImage == null) {
                    cubit.createPost(
                        dateTime: now.toString(), text: textController.text);
                  } else {
                    cubit.uploadPostImage(
                        dateTime: now.toString(), text: textController.text);
                  }
                },
                child: const Text('Post'),
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if (state is CreatePostLoadingState)
                  const LinearProgressIndicator(),
                if (state is CreatePostLoadingState)
                  const SizedBox(
                    height: 10,
                  ),
                Row(
                  children: const [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage('https://img.freepi'
                          'k.com/free-photo/close-up-portrait-candid-smiling-'
                          'attractive-woman-with-white-teeth-isolated-long-curl'
                          'y-hair-white-blouse-elegant-business-style-happy-positive-emotion-'
                          'red-lipstick-make-up_285396-760.jpg?w=1060&t=st=1664777040~exp=1664777640~hmac=9ec5'
                          '786eb23fa65b457aab08f2e32e322262125b5f83c3242bea1ee3dd490fd2'),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Text('Ahmed Adel'),
                    ),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'What is on your mind ..'),
                  ),
                ),
                if(cubit.postImage !=null)
                  Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 150,
                      decoration:  BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          image: DecorationImage(
                            image:FileImage(cubit.postImage!),
                            fit: BoxFit.cover,
                          )
                      ),
                    ),
                    IconButton(onPressed: (){
                      cubit.removePostImage();
                    }, icon: const CircleAvatar(
                        radius: 20,
                        child:  Icon(Icons.close,size: 16,)
                    ), )

                  ],
                ),
                const SizedBox(height: 20,),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        cubit.getPostImage();
                      },
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.image),
                            Text('Add phote')
                          ]),
                    ),
                  ),
                  Expanded(
                      child: TextButton(
                    onPressed: () {},
                    child: const Text('# Tags'),
                  ))
                ])
              ],
            ),
          ),
        );
      },
    );
  }
}
