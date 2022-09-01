import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../Components/variableShared.dart';
import '../../Modules/base_screen.dart';
import '../../Components/widget_shared.dart';
import '../../Cubit/Shop/shop_cubit.dart';
import '../../Cubit/SignIn/signStates.dart';
import '../../Cubit/SignIn/sign_cubit.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  var formKey=GlobalKey<FormState>();
  var fullNameController=TextEditingController();
  var emailController=TextEditingController();
  var phoneController=TextEditingController();
  var passwordController=TextEditingController();
  var confirmPasswordController=TextEditingController();


  @override
  Widget build(BuildContext context) {
    SignCubit  myCubit=SignCubit.get(context);
    return BlocConsumer<SignCubit,SignStates>(
      listener: (context,state){
        if(state is RegisterSuccessState ){
          if(state.registerResponse.status){
            ShopCubit.get(context).goToHomePage();
            goToAnotherScreen2(context, const BaseScreen());
            Fluttertoast.showToast(
                msg: state.registerResponse.message,
                toastLength: Toast.LENGTH_LONG,//androied
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 2,//ios //web
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0
            );
          }
          else{
            Fluttertoast.showToast(
                msg: state.registerResponse.message,
                toastLength: Toast.LENGTH_LONG,//androied
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 2,//ios //web
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0
            );
          }
        }
      },
      builder: (context,state){
        return Scaffold(
              backgroundColor: Colors.white,
              body: Form(
                key: formKey,
                child: Center(
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      const SizedBox(height: 20,),
                      CircleAvatar(
                          radius: 50,
                          child: Image(image: AssetImage(setImage(url: 'circle5.png'),),)
                      ),
                      const SizedBox(height: 15,),
                      Text(
                        appName,
                        style: const TextStyle(
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
                          text: 'Full Name',
                          textError: 'Your Name must not be empty',
                          controller: fullNameController,
                          prefixIcon: Icons.person
                      ),
                      myTextField(
                        text: 'Email',
                        textError: 'Email must not be empty',
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        prefixIcon: Icons.email
                      ),
                      myTextField(
                          text: 'Phone',
                          textError: 'Phone must not be empty',
                          keyboardType: TextInputType.number,
                          controller: phoneController,
                          prefixIcon: Icons.phone_android
                      ),
                      myTextField(
                          text: 'Password',
                          textError: 'Password must not be empty',
                          keyboardType: TextInputType.visiblePassword,
                          controller: passwordController,
                          prefixIcon: Icons.key,
                          obscureText: true,
                          myCubit: myCubit
                      ),
                      myTextField(
                          text: 'Confirm Password',
                          textError: 'Those passwords didn’t match. Try again.',
                          keyboardType: TextInputType.visiblePassword,
                          controller: confirmPasswordController,
                          confirmPassword: passwordController.text,
                          prefixIcon: Icons.key,
                          obscureText: true,
                        myCubit: myCubit
                      ),
                      const SizedBox(height: 17,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: ConditionalBuilder(
                          condition: state is !RegisterLoadingState,
                          builder: (context)=>myButton(text: 'Register',
                              function: ()
                              {
                                if(formKey.currentState!.validate()){
                                  myCubit.register(
                                      name: fullNameController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                      phone: phoneController.text
                                  );
                                }
                              },
                              buttonColor: Colors.red
                          ),
                          fallback: (context)=>const Center(child: CircularProgressIndicator(),),
                        ),
                      ),
                      const SizedBox(height: 2,),
                      Image(image: AssetImage(setImage(url: 'aboutShop7.jpg')),height: 120,),
                    ],
                  ),
                ),
              ),
            );
        },
    );
  }
}
