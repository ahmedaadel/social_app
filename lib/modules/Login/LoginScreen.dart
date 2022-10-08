import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/Home_Layout/Home_Layout.dart';
import 'package:social_app/modules/Login/LoginCubit.dart';
import 'package:social_app/modules/Login/LoginStates.dart';
import 'package:social_app/modules/Register/Register_Screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/local/Shared_prefrences.dart';


class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginErrorState) {
            showToast(
                text: state.error.toString(),
                state: ToastState.error);
          }

          if(state is LoginSuccessState)
            {
              CacheHelper.saveData(key: 'uId', value: state.uId).
              then((value) { Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context) =>const  HomeLayout(),)
                  , (route) => false);}).catchError((error){print(error.toString());});
            }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Login',
                          style:
                              Theme.of(context).textTheme.headline5!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30,
                                  ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text('Login now to browse our hot offers',
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      color: Colors.grey,
                                    )),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'email must not be empty';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            prefixIcon: const Icon(Icons.email),
                            label: const Text('Email'),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          controller: passwordController,
                          obscureText: LoginCubit.get(context).isSecure,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Password must not be empty';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            prefixIcon: const Icon(Icons.lock),
                            suffixIcon: LoginCubit.get(context).isSecure
                                ? IconButton(
                                    icon: const Icon(Icons.visibility_outlined),
                                    onPressed: () =>
                                        LoginCubit.get(context).visable())
                                : IconButton(
                                    icon: const Icon(Icons.visibility_off),
                                    onPressed: () =>
                                        LoginCubit.get(context).visable()),
                            label: const Text('Password'),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        ConditionalBuilder(
                          builder: (context) => TextButton(
                            style: TextButton.styleFrom(
                                backgroundColor: Colors.blue,
                                primary: Colors.white,
                                minimumSize: const Size(double.infinity, 50)),
                            child: const Text(
                              'LOGIN',
                              style: TextStyle(fontSize: 18),
                            ),
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                LoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text);
                              }
                            },
                          ),
                          condition: state is! LoginLoadingState,
                          fallback: (context) =>
                              const Center(child: CircularProgressIndicator()),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Do\'nt have an account ?',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RegisterScreen()));
                                },
                                child: const Text(
                                  'REGISTER',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
