import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Components/variableShared.dart';
import '../../Cubit/SignIn/signStates.dart';
import '../../Cubit/SignIn/sign_cubit.dart';
import '../../Components/widget_shared.dart';
import 'register_screen.dart';
import 'login_screen.dart';

class RegisterLoginScreen extends StatelessWidget {
  const RegisterLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignCubit,SignStates>(
      listener: (context,state){},
      builder: (context1,state){
        return Scaffold(
            body: Stack(
              children: [
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 30,),
                      Image(image: AssetImage(setImage(url: 'background3.png')),
                        color: Colors.green,
                      )
                    ],
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Expanded(child: SizedBox()),
                      CircleAvatar(
                          radius: 70,
                          backgroundImage: AssetImage(setImage(url: 'circle5.png'))
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
                      ),
                      const SizedBox(height: 37,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: myButton(text: "Login",
                          function: (){
                            goToAnotherScreen2(context, LoginScreen());
                          },
                        ),
                      ),
                      const SizedBox(height: 15,),
                      Padding(
                        padding: const EdgeInsets.only(left: 25,right: 25,bottom: 90),
                        child: myButton(text: "Register",
                            function: (){
                              goToAnotherScreen2(context,RegisterScreen());
                            },
                            buttonColor: Colors.red
                        ),
                      ),
                      //const SizedBox(height: 85,),

                      Image(image: AssetImage(setImage(url: 'aboutShop8.jpg')),width: 200,),
                      const SizedBox(height: 30,)
                    ],
                  ),
                ),
              ],
            )
        );
      },
    );
  }
}
