import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


void showToast({required String text, required ToastState state}) {
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 5,
      backgroundColor: toastColor(state),
      textColor: Colors.white,
      fontSize: 16.0);
}

enum ToastState { success, error, warning }

Color toastColor(ToastState state) {
  Color color;
  switch (state) {
    case (ToastState.success):
      color = Colors.green;
      break;
    case (ToastState.error):
      color = Colors.red;
      break;
    case (ToastState.warning):
      color = Colors.amber;
      break;
  }
  return color;
}



// Widget Verification ()=>ConditionalBuilder(
//   condition: HomeCubit.get(context).user != null,
//   fallback: (context) =>
//   const Center(child: CircularProgressIndicator()),
//   builder: (context) {
//     return Column(
//       children: [
//
//         if(!FirebaseAuth.instance.currentUser!.emailVerified)
//           Container(
//             color: Colors.amber.withOpacity(.6),
//             child: Row(
//               children: [
//                 const Icon(Icons.info_outline),
//                 const SizedBox(
//                   width: 20,
//                 ),
//                 const Expanded(
//                     child: Text('please Verify your email')),
//                 TextButton(
//                     onPressed: () {
//                       FirebaseAuth.instance.currentUser!.sendEmailVerification()
//                           .then((value) { showToast(text: 'Check your email', state: ToastState.success);}
//                       ).catchError((error){print(error.toString());});
//                     }, child: const Text('SEND'))
//               ],
//             ),
//           ),
//       ],
//     );
//   },
// );
// void signOut({required BuildContext context}) {
//   Cache_Helper.removeData(key: 'token').then((value) {
//     if (value == true) {
//       Navigator.pushAndRemoveUntil(
//           context,
//           MaterialPageRoute(builder: (context) => LoginScreen()),
//           (route) => false);
//     }
//   });
// }
