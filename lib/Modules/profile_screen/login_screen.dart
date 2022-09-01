import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopapp/Cubit/Shop/shop_cubit.dart';
import '../../Components/variableShared.dart';
import '../../Components/widget_shared.dart';
import '../../Cubit/SignIn/signStates.dart';
import '../../Cubit/SignIn/sign_cubit.dart';
import '../base_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  var formKey=GlobalKey<FormState>();
  var emailController=TextEditingController();
  var passwordController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignCubit,SignStates>(
      listener: (context,state){
        if(state is LoginSuccessState ) {
          if (state.loginResponse.status) {
            ShopCubit.get(context).goToHomePage();
            goToAnotherScreen2(context, const BaseScreen());
            Fluttertoast.showToast(
                msg: state.loginResponse.message,
                toastLength: Toast.LENGTH_LONG,
                //androied
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 2,
                //ios //web
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0
            );
          }
          else {
            Fluttertoast.showToast(
                msg: state.loginResponse.message,
                toastLength: Toast.LENGTH_LONG,
                //androied
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 2,
                //ios //web
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0
            );
          }
        }
        else if(state is LoginErrorState){
          Fluttertoast.showToast(
              msg: 'Login Failed',
              toastLength: Toast.LENGTH_LONG,
              //androied
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 2,
              //ios //web
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );
        }
      },
      builder: (context,state){
        SignCubit  myCubit=SignCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.white,
          body: Form(
            key: formKey,
            child: Center(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  const SizedBox(height: 100,),
                  CircleAvatar(
                      radius: 50,
                      child: Image(image: AssetImage(setImage(url: 'circle5.png'),),)
                  ),
                  const SizedBox(height: 15,),
                   Text(
                    appName,
                    style:const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.black,
                        shadows: [
                          Shadow(color: Colors.white,blurRadius: 50,offset: Offset.zero)
                        ]
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 17,),
                  myTextField(
                      text: 'Email',
                      controller:emailController,
                      textError: 'Email must not be empty',
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: Icons.email
                  ),
                  myTextField(
                      text: 'Password',
                      controller:passwordController,
                      textError: 'Password must not be empty',
                      keyboardType: TextInputType.visiblePassword,
                      prefixIcon: Icons.key,
                      obscureText: true,
                      myCubit:myCubit
                  ),
                  const SizedBox(height: 10,),
                  ConditionalBuilder(
                    condition: state is! LoginLoadingState,
                    builder: (context)=>Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 20),
                      child: myButton(
                          text: 'Login',
                          function: (){
                            if(formKey.currentState!.validate()){
                              myCubit.login(email: emailController.text,
                                  password: passwordController.text);
                            }
                          }
                      ),
                    ),
                    fallback: (context)=>const Center(child: CircularProgressIndicator(),),
                  ),
                  const SizedBox(height: 20,),
                  Image(image: AssetImage(setImage(url: 'aboutShop3.webp')),height: 160,),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
