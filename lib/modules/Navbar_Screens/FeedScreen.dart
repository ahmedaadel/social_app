import 'package:flutter/material.dart';
import 'package:social_app/shared/styles/Color.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 180,
            width: double.infinity,
            child: Card(
              clipBehavior:Clip.antiAliasWithSaveLayer ,
              margin: const EdgeInsets.all(8.0),
              elevation: 10,
                  child: Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      const Image(image:
                      NetworkImage('https://img.freepik.com/free-photo/stylish-smiling-blond-female-student-glasses-looking'
                          '-happy_176420-22041.jpg?w=1060&t=st=1664776689~exp=1664777289~'
                          'hmac=c7f3c00ba133333fe7e3986c766287a513454f645d91ff14189f01190e5dbfbb'),width: double.infinity,fit: BoxFit.fitWidth),
                      Text('Communicate with Friends',style: Theme.of(context).textTheme.subtitle1!.copyWith(color: Colors.black,fontSize: 16),)
                    ],
                  ),
            ),
          ),
          ListView.separated(
            shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => buildPostItem(context), separatorBuilder:(context, index) => SizedBox(height: 8,) , itemCount: 6),
          SizedBox(height: 10,)
        ],
      ),
    );

  }
}

Widget buildPostItem(context) => Card(
    clipBehavior:Clip.antiAliasWithSaveLayer ,
    margin:const EdgeInsets.all(8.0),
    elevation: 5,
    child: Padding(
      padding: const EdgeInsets.all(6.0),
      child: Column(
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 20,
                backgroundImage:  NetworkImage('https://img.freepi''k.com/free-photo/close-up-portrait-candid-smiling-'
                    'attractive-woman-with-white-teeth-isolated-long-curl''y-hair-white-blouse-elegant-business-style-happy-positive-emotion-'
                    'red-lipstick-make-up_285396-760.jpg?w=1060&t=st=1664777040~exp=1664777640~hmac=9ec5'
                    '786eb23fa65b457aab08f2e32e322262125b5f83c3242bea1ee3dd490fd2'),
              ),
              const SizedBox( width: 15,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const[
                        Text('Ahmed Adel'),
                        SizedBox( width: 5,),
                        Icon(Icons.check_circle,size: 14 ,color: defaultColor,)
                      ],
                    ),
                    Text('Jun 21, 2022 at 11:10',style: Theme.of(context).textTheme.caption,)
                  ],
                ),
              ),
              IconButton(onPressed: (){}, icon:const Icon(Icons.more_horiz,size: 16,))
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
          const Text('Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s stand'
              'ard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled itto make a type'
              ' specimen book'),
          Padding(
            padding: const EdgeInsets.only(top:4,bottom: 4),
            child: Container(
              width: double.infinity,
              child: Wrap(
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.only(end: 6),
                    child: Container(
                      height: 25,
                      child: MaterialButton(
                        onPressed: (){},
                        minWidth: 1.0,
                        padding: EdgeInsets.zero,
                        child:const  Text('#software',style: TextStyle(color:defaultColor ),),
                      ),
                    ),
                  ),
                  Container(
                    height: 25,
                    child: MaterialButton(
                      onPressed: (){},
                      minWidth: 1.0,
                      padding: EdgeInsets.zero,
                      child:const  Text('#software',style: TextStyle(color:defaultColor ),),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width:double.infinity ,
            height: 150,
            decoration:  BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                image: const DecorationImage(
                  image: NetworkImage('https://img.freepi''k.com/free-photo/close-up-portrait-candid-smiling-'
                      'attractive-woman-with-white-teeth-isolated-long-curl''y-hair-white-blouse-elegant-business-style-happy-positive-emotion-'
                      'red-lipstick-make-up_285396-760.jpg?w=1060&t=st=1664777040~exp=1664777640~hmac=9ec5'
                      '786eb23fa65b457aab08f2e32e322262125b5f83c3242bea1ee3dd490fd2',),fit: BoxFit.cover,

                )
            ),
          ),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                Expanded(
                    child: InkWell(
                      child: Row(
                        children: [
                          const Icon(Icons.favorite,size: 15,),
                          const SizedBox(width: 5,),
                          Text('1200',style: Theme.of(context).textTheme.caption,)
                        ],
                      ),
                      onTap: (){},
                    )
                ),
                Expanded(
                    child: InkWell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Icon(Icons.chat,size: 15,),
                          const SizedBox(width: 5,),
                          Text('1200 comment',style: Theme.of(context).textTheme.caption,)
                        ],
                      ),
                      onTap: (){},
                    )
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom:8, top: 8),
            child: Container(
              width: double.infinity,
              height: 1,
              color: Colors.grey[400],
            ),
          ),
          Row(
            children: [
              const CircleAvatar(
                radius: 20,
                backgroundImage:  NetworkImage('https://img.freepi''k.com/free-photo/close-up-portrait-candid-smiling-'
                    'attractive-woman-with-white-teeth-isolated-long-curl''y-hair-white-blouse-elegant-business-style-happy-positive-emotion-'
                    'red-lipstick-make-up_285396-760.jpg?w=1060&t=st=1664777040~exp=1664777640~hmac=9ec5'
                    '786eb23fa65b457aab08f2e32e322262125b5f83c3242bea1ee3dd490fd2'),
              ),
              const SizedBox( width: 15,),
              Expanded(child: InkWell(child: Text('Write a comment ...',style: Theme.of(context).textTheme.caption,))),
              InkWell(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Icon(Icons.favorite,size: 15,),
                    const SizedBox(width: 5,),
                    Text('Like',style: Theme.of(context).textTheme.caption,)
                  ],
                ),
                onTap: (){},
              )
            ],
          ),
        ],
      ),
    )
);