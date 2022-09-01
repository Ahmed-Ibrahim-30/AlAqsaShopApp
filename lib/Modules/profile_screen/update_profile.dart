import 'dart:io';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import '../../Modules/SettingsScreen/settings_screen.dart';
import '../../Components/SharedPreference.dart';
import '../../Components/variableShared.dart';
import '../../Components/widget_shared.dart';
import '../../Cubit/Shop/shop_cubit.dart';
import '../../Cubit/SignIn/sign_cubit.dart';
import '../../Cubit/SignIn/signStates.dart';
import '../base_screen.dart';

class UpdateProfile extends StatefulWidget {
  UpdateProfile({Key? key}) : super(key: key);

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  String defaultImage='https://student.valuxapps.com/storage/assets/defaults/user.jpg';
  var formKey=GlobalKey<FormState>();
  var fullNameController=TextEditingController(text: ShopCache.getData(key: 'userName'));
  var emailController=TextEditingController(text: ShopCache.getData(key: 'userEmail'));
  var phoneController=TextEditingController(text: ShopCache.getData(key: 'userPhone'));
  var passwordController=TextEditingController(text: ShopCache.getData(key: 'userPassword'));
  var confirmPasswordController=TextEditingController(text: ShopCache.getData(key: 'userPassword'));
  File myImage=File(ShopCache.getData(key: 'userImage'));
  final ImagePicker _picker = ImagePicker();
  Future<void> getImage()async {
    // Pick an image
    final image = await _picker.pickImage(source: ImageSource.gallery);
    if(image==null)return;
    File?img=File(image.path);
    setState((){
      myImage=img;
    });
  }


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignCubit,SignStates>(
      listener: (context,state){
        if(state is UpdateSuccessState ){
          if(state.status){
            ShopCubit.get(context).goToHomePage();
            goToAnotherScreen2(context, const BaseScreen());
            Fluttertoast.showToast(
                msg: state.message,
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
                msg: state.message,
                toastLength: Toast.LENGTH_LONG,//androied
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 2,//ios //web
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0
            );
          }
        }
        else if(state is UpdateErrorState){
          Fluttertoast.showToast(
              msg: state.message,
              toastLength: Toast.LENGTH_LONG,//androied
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 2,//ios //web
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );
        }
      },
      builder: (context,state){

        SignCubit  signCubit=SignCubit.get(context);
        ShopCubit shopCubit=ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('Edit Profile',style: TextStyle(color: Colors.black),),
            centerTitle: true,

            leading: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: IconButton(
                onPressed: (){
                  shopCubit.goToSettingsPage();
                  goToAnotherScreen2(context, const SettingsScreen());
                },
                icon: const Icon(Icons.arrow_back),
                color: Colors.black,
                iconSize: 25,
              ),
            ),
            elevation: 2,
          ),
          body: Form(
            key: formKey,
            child: SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  const SizedBox(height: 30,),
                  Center(
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          width: 120,
                          height: 120,
                          decoration: const BoxDecoration(
                              shape:BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 10,
                                  spreadRadius: 5,
                                )
                              ]
                          ),
                          child: CircleAvatar(radius: (80),
                              backgroundColor: Colors.white,
                              child: ClipRRect(
                                  borderRadius:BorderRadius.circular(80),
                                  child: ConditionalBuilder(
                                    condition: defaultImage==myImage.path,
                                    builder: (context)=>Image(
                                      image:AssetImage(setImage(url: 'user.png')),
                                      width: 150,
                                      height: 150,
                                    ),
                                    fallback: (context)=> Image.file(
                                      myImage,
                                      width: 150,
                                      height: 150,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                              )
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: CircleAvatar(
                              radius: 17,
                              backgroundColor: Colors.yellowAccent,
                              child: FloatingActionButton(
                                mini: true,
                                backgroundColor: Colors.white,
                                onPressed: (){
                                  getImage();
                                  signCubit.changeImage();
                                  },
                                child: Image( image:AssetImage(setImage(url:'edit2.png')),height: 25,color: Colors.black,),
                              )
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40,),
                  myTextField(
                      text: 'Full Name',
                      textError: 'Your Name must not be empty',
                      controller: fullNameController,
                      prefixIcon: Icons.person,
                      textColor: Colors.black
                  ),
                  myTextField(
                      text: 'Email',
                      textError: 'Email must not be empty',
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      prefixIcon: Icons.email,
                      textColor: Colors.black
                  ),
                  myTextField(
                      text: 'Phone',
                      textError: 'Phone must not be empty',
                      keyboardType: TextInputType.number,
                      controller: phoneController,
                      prefixIcon: Icons.phone_android,
                      textColor: Colors.black
                  ),
                  myTextField(
                      text: 'Password',
                      textError: 'Password must not be empty',
                      keyboardType: TextInputType.visiblePassword,
                      controller: passwordController,
                      prefixIcon: Icons.key,
                      obscureText: true,
                      myCubit: signCubit,
                      textColor: Colors.black
                  ),
                  myTextField(
                      text: 'Confirm Password',
                      textError: 'Those passwords didn’t match. Try again.',
                      keyboardType: TextInputType.visiblePassword,
                      controller: confirmPasswordController,
                      confirmPassword: passwordController.text,
                      prefixIcon: Icons.key,
                      obscureText: true,
                      myCubit: signCubit,
                      textColor: Colors.black
                  ),
                  const SizedBox(height: 17,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: ConditionalBuilder(
                      condition: state is! UpdateLoadingState,
                      builder: (context)=>myButton(text: 'Update Profile',
                          function: ()
                          {
                            if(formKey.currentState!.validate()){
                              ShopCache.saveData(key: 'userImage', value: myImage.path);
                              signCubit.editProfile(
                                  name: fullNameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  phone: phoneController.text,
                                  context: context,
                                  image: "https://student.valuxapps.com/storage/uploads/users/rIKXaaG439_1661999550.jpeg",
                              );
                            }
                          },
                          buttonColor: Colors.blue
                      ),
                      fallback: (context)=>const Center(child: CircularProgressIndicator(),),
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
