import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/Edit_Screen.dart';
import 'package:social_app/modules/Home_Layout/Home_States.dart';
import 'package:social_app/modules/Home_Layout/Home_cubit.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>
      (listener: (context, state) {},
    builder: (context, state) {
      var userModer= HomeCubit.get(context).user;
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              height: 200,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      width: double.infinity,
                      height: 150,
                      decoration:  BoxDecoration(
                          borderRadius:const BorderRadius.only(
                            topLeft: Radius.circular(4),
                            topRight: Radius.circular(4),
                          ),
                          image: DecorationImage(
                            image: NetworkImage(
                        '${userModer!.cover}'
                            ),
                            fit: BoxFit.cover,
                          )
                      ),
                    ),
                  ),
                  CircleAvatar(
                    radius: 64,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    child:  CircleAvatar(
                      radius: 60,
                      backgroundImage: NetworkImage('${userModer!.image}'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(''
                '${userModer!.name}',
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              '${userModer!.bio}',
              style: Theme.of(context).textTheme.caption,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                    child: InkWell(
                      child: Column(
                        children: [
                          Text(
                            '270',
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                          Text(
                            'Friends ',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                      onTap: () {},
                    )),
                Expanded(
                    child: InkWell(
                      child: Column(
                        children: [
                          Text(
                            '100',
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                          Text(
                            'Photos ',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                      onTap: () {},
                    )),
                Expanded(
                    child: InkWell(
                      child: Column(
                        children: [
                          Text(
                            '105K',
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                          Text(
                            'Followers ',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                      onTap: () {},
                    )),
                Expanded(
                    child: InkWell(
                      child: Column(
                        children: [
                          Text(
                            '100',
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          Text(
                            'Posts ',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                      onTap: () {},
                    ))
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Expanded(child: OutlinedButton(onPressed: (){},child: const Text('Add photo') ,)),
                const SizedBox(width: 10,),
                OutlinedButton(onPressed: (){Navigator.push(context,
                    MaterialPageRoute(builder: (context) =>  EditScreen(),));},child:const Icon(Icons.edit) ,)
              ],
            )
          ],
        ),
      );
    },);
  }
}



// 30Container(
// width: double.infinity,
// height: 40,
// child: MaterialButton(
// onPressed: () {},
// child: const Text(
// 'EDIT PROFILE',
// style: TextStyle(color: Colors.white),
// ),
// ),
// decoration: BoxDecoration(
// color: Colors.blue,
// borderRadius: BorderRadius.circular(7)
// ),
// )