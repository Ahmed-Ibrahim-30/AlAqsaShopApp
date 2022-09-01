import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Components/widget_shared.dart';
import '../../Cubit/Shop/shop_states.dart';
import '../../Modules/SettingsScreen/settings_screen.dart';
import '../../Components/variableShared.dart';
import '../../Cubit/Shop/shop_cubit.dart';

class AboutProgrammer extends StatelessWidget {
  const AboutProgrammer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
        listener: (context,state){},
        builder: (context,state){
          ShopCubit myCubit=ShopCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              leading: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: IconButton(
                  onPressed: (){
                    myCubit.goToSettingsPage();
                    goToAnotherScreen(context, const SettingsScreen());
                  },
                  icon: const Icon(Icons.arrow_back),
                  color: Colors.black,
                  iconSize: 25,
                ),
              ),
              elevation: 0,
            ),
            body: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                gradient: LinearGradient(
                    colors: [Colors.white,Colors.red.withOpacity(0.6)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        shape:BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white,
                            blurRadius: 10,
                            spreadRadius: 5,
                          )
                        ]
                    ),
                    child: CircleAvatar(
                        radius: (100),
                        backgroundColor: Colors.white,
                        child: ClipRRect(
                            borderRadius:BorderRadius.circular(80),
                            child: Image(
                              image:AssetImage(setImage(url: 'ahmed1.jpeg'),),
                              width: 200,
                              height: 200,
                              fit: BoxFit.fill,
                            )
                        )
                    ),
                  ),
                  const SizedBox(height: 20,),
                  myText(text: 'Ahmed Ibrahim',color: Colors.black,fontSize: 26,fontWeight: FontWeight.bold),
                  const SizedBox(height: 20,),
                  socialApp(),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Container(width: double.infinity,height: 0.7,color: Colors.grey,),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        children: [
                          Image(image: AssetImage(setImage(url: 'faculty.png')),height: 30,color: Colors.black,),
                          const SizedBox(width: 14,),
                          Expanded(
                            child: myText(
                                text: 'Faculty of Computer and Artificial intelligent Cairo University',
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.black
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        children: [
                          Image(image: AssetImage(setImage(url: 'level.png')),height: 30,color: Colors.black,),
                          const SizedBox(width: 14,),
                          Expanded(
                            child: myText(
                                text: 'Level : 4',
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.black
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 14,top: 20),
                      child: Row(
                        children: [
                          Image(image: AssetImage(setImage(url: 'grade.png')),height: 40,color: Colors.black,),
                          const SizedBox(width: 12,),
                          Expanded(
                            child: myText(
                                text: 'Grade : VeryGood',
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.black
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 17,top: 25),
                      child: Row(
                        children: [
                          Image(image: AssetImage(setImage(url: 'age.png')),height: 40,color: Colors.black,),
                          const SizedBox(width: 20,),
                          Expanded(
                            child: myText(
                                text: '21',
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: Colors.black
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30,),
                ],
              ),
            ),
          );
        },
    );
  }
}
