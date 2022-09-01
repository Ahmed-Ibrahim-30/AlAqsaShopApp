import 'dart:io';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../Modules/SettingsScreen/about_programmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Components/widget_shared.dart';
import '../../Components/SharedPreference.dart';
import '../../Components/variableShared.dart';
import '../../Cubit/Shop/shop_cubit.dart';
import '../../Cubit/Shop/shop_states.dart';

import '../onboarding_view.dart';
import '../profile_screen/update_profile.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {


  //'whatsapp://send?phone=${01027709271}'
  //whatsapp://send?phone=+20${01125372118}

  final Uri faceBook = Uri.parse('https://www.facebook.com/');
  final Uri watsApp = Uri.parse('whatsapp://send?phone=+20${01027709271}');
  String defaultImage='https://student.valuxapps.com/storage/assets/defaults/user.jpg';



  @override
  Widget build(BuildContext context) {
    //ShopCubit myCubit=ShopCubit.get(context);
    // myCubit.getBusinessNews();
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){
        if(state is LogoutSuccessState ){
          if(state.status){
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
        else if(state is LogoutErrorState){
          Fluttertoast.showToast(
              msg: 'Logout Failed',
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
        ShopCubit myCubit=ShopCubit.get(context);
        return Scaffold(
            appBar: AppBar(
              leading: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: IconButton(
                  onPressed: (){
                    myCubit.goToHomePage();
                  },
                  icon: const Icon(Icons.arrow_back),
                  color: Colors.black,
                  iconSize: 25,
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    onPressed: (){
                      goToAnotherScreen2(context, UpdateProfile());
                    },
                    icon: Image( image:AssetImage(setImage(url:'edit1.png')),height: 25),
                    color: Colors.black,
                  ),
                ),
              ],
              elevation: 0,
            ),
            backgroundColor: Colors.white,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 25,left: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(width: 12,),
                      Container(
                        width: 100,
                        height: 100,
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
                                  condition: defaultImage==ShopCache.getData(key: 'userImage'),
                                  builder: (context)=>Image(
                                    image:AssetImage(setImage(url: 'user.png')),
                                    width: 150,
                                    height: 150,
                                  ),
                                  fallback: (context)=> Image.file(
                                    File(ShopCache.getData(key: 'userImage')),
                                    width: 150,
                                    height: 150,
                                    fit: BoxFit.cover,
                                  ),
                                )
                            )
                        ),
                      ),
                      const SizedBox(width: 20,),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             Text(
                              '${ShopCache.getData(key: 'userName')}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10,),
                            Row(
                              children: const [
                                Icon(Icons.location_on,color: Colors.black54,),
                                SizedBox(width: 3,),
                                Text(
                                  'Egypt',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 17
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 19,),
                Padding(
                  padding: const EdgeInsets.only(left: 30,top: 25),
                  child: Row(
                    children:  [
                      const Icon(Icons.phone,color: Colors.grey,),
                      const SizedBox(width: 20,),
                      Text(
                        '${ShopCache.getData(key: 'userPhone')}',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30,top: 17,bottom: 30),
                  child: Row(
                    children:  [
                      const Icon(Icons.email_outlined,color: Colors.grey,),
                      const SizedBox(width: 20,),
                      Text(
                        '${ShopCache.getData(key: 'userEmail')}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 17
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Container(width: double.infinity,height: 0.5,color: Colors.grey,),
                ),
                const Expanded(
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Padding(
                      padding: EdgeInsets.only(top: 26,left: 25,right: 5),
                      child: Text(
                        ' أَمْ يَقُولُونَ نَحْنُ جَمِيعٌ مُنْتَصِرٌ (44) سَيُهْزَمُ الْجَمْعُ وَيُوَلُّونَ الدُّبُرَ ُّ',
                        style: TextStyle(
                          color: Colors.teal,
                          fontFamily: 'second',
                          fontWeight: FontWeight.bold,
                          fontSize: 19
                        ),
                      ),
                    ),
                  ),
                ),
                Container(width: double.infinity,height: 0.5,color: Colors.grey,),
                settingWidget(imageName: 'about1.png',text: 'About Programmer',function: (){goToAnotherScreen2(context, const AboutProgrammer());}),
                settingWidget(imageName: 'about2.png',paddingLeft:9,imageHeight:37,imageColor: null,text: 'About App',function: (){goToAnotherScreen(context, OnBoardingScreen(widget: 0,));}),
                settingWidget(imageName: 'rate.png',text: 'Rate App',function: (){}),
                Padding(
                  padding: const EdgeInsets.only(top: 3),
                  child: Container(width: double.infinity,height: 0.5,color: Colors.grey,),
                ),
                Expanded(
                  child: ConditionalBuilder(
                    condition: state is! LogoutLoadingState,
                    builder: (BuildContext context){
                      return MaterialButton(
                      onPressed: (){
                        myCubit.logout(context: context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 17),
                        child: Row(
                          children: [
                            Image(image: AssetImage(setImage(url: 'logout.png')),height: 320,width: 25,color: Colors.red,),
                            const SizedBox(width:30),
                            myText(text: 'Log out',color: Colors.red,fontSize: 23,fontWeight: FontWeight.bold)
                          ],
                        ),
                      ),
                    );},
                    fallback: (BuildContext context){
                      return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        CircularProgressIndicator(),
                      ],
                    );},
                ),

                ),
              ],
            )
        );
      },
    );
  }
  Widget settingWidget({
    required dynamic function,
    required String imageName,
    double imageHeight=30.0,
    Color ?imageColor=Colors.blue,
    required String text,
    double paddingLeft=17
}){
    return Expanded(
      child: MaterialButton(
        onPressed: function,
        child: Padding(
          padding:  EdgeInsets.only(left: paddingLeft,top: 6),
          child: Row(
            children: [
              Image(image: AssetImage(setImage(url: imageName)),height: imageHeight,color: imageColor,),
              const SizedBox(width:27),
              myText(text: text,color: Colors.black87,fontSize: 20,fontWeight: FontWeight.w600)
            ],
          ),
        ),
      ),
    );
  }

}
