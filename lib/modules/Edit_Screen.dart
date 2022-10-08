import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/Home_Layout/Home_States.dart';
import 'package:social_app/modules/Home_Layout/Home_cubit.dart';

class EditScreen extends StatelessWidget {
  const EditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var nameController = TextEditingController();
        var bioController = TextEditingController();
        var phoneController = TextEditingController();
        var userModer = HomeCubit.get(context).user;
        var profileImage = HomeCubit.get(context).profileImage;
        var coverImage = HomeCubit.get(context).coverImage;

        bioController.text = userModer!.bio!;
        nameController.text = userModer!.name!;
        phoneController.text = userModer!.phone!;

        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios)),
            title: const Text('Edit Profile'),
            actions: [
              TextButton(
                  onPressed: () {
                    HomeCubit.get(context).updateUser(
                        bio: bioController.text,
                        name: nameController.text,
                        phone: phoneController.text);
                  },
                  child: const Text('UPDATE'))
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if (state is UpdateUserLoadingState)
                    const LinearProgressIndicator(),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 200,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                width: double.infinity,
                                height: 150,
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(4),
                                      topRight: Radius.circular(4),
                                    ),
                                    image: DecorationImage(
                                      image: coverImage == null
                                          ? NetworkImage('${userModer!.cover}')
                                          : FileImage(coverImage)
                                              as ImageProvider,
                                      fit: BoxFit.cover,
                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: CircleAvatar(
                                  radius: 16,
                                  child: IconButton(
                                      onPressed: () {
                                        HomeCubit.get(context).getCoverImage();
                                      },
                                      icon: const Icon(
                                        Icons.camera_alt,
                                        size: 16,
                                      )),
                                ),
                              )
                            ],
                          ),
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 64,
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                radius: 60,
                                backgroundImage: profileImage == null
                                    ? NetworkImage('${userModer!.image}')
                                    : FileImage(profileImage) as ImageProvider,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                radius: 16,
                                child: IconButton(
                                    onPressed: () {
                                      HomeCubit.get(context).getProfileImage();
                                    },
                                    icon: const Icon(
                                      Icons.camera_alt,
                                      size: 16,
                                    )),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  if(HomeCubit.get(context).profileImage !=null || HomeCubit.get(context).coverImage !=null)
                  Row(
                    children: [
                      if(HomeCubit.get(context).profileImage !=null)
                      Expanded(
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              height: 40,
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(7)),
                              child: MaterialButton(
                                onPressed: () {
                                  HomeCubit.get(context)
                                      .uploadProfileImage(bio: bioController.text, name: nameController.text, phone: phoneController.text );
                                },
                                child: const Text(
                                  'Upload Profile',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                           // if (state is UpdateUserLoadingState)
                           // const SizedBox(height:5,),
                           //  if (state is UpdateUserLoadingState)
                           //    LinearProgressIndicator(),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      if(HomeCubit.get(context).coverImage !=null)
                      Expanded(
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              height: 40,
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(7)),
                              child: MaterialButton(
                                onPressed: () {
                                  HomeCubit.get(context)
                                      .uploadCoverImage(bio: bioController.text, name: nameController.text, phone: phoneController.text );
                                },
                                child: const Text(
                                  'Upload Cover',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            // if (state is UpdateUserLoadingState)
                            //   const SizedBox(height:5,),
                            // if (state is UpdateUserLoadingState)
                            //   const LinearProgressIndicator(),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),

                  TextFormField(
                    controller: nameController,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Name Must not be empty';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      prefixIcon: const Icon(Icons.supervised_user_circle),
                      label: const Text('Name'),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: bioController,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Bio Must not be empty';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      prefixIcon: const Icon(Icons.info_outline),
                      label: const Text('Bio'),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: phoneController,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Phone Must not be empty';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      prefixIcon: const Icon(Icons.phone),
                      label: const Text('Phone'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
