import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Cubit/Shop/shop_cubit.dart';
import '../../Modules/base_screen.dart';
import '../../Modules/profile_screen/register_login_screen.dart';
import '../../Components/SharedPreference.dart';
import '../../Components/variableShared.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../Components/widget_shared.dart';
import '../Cubit/Shop/shop_states.dart';
import '../Model/onboarding_details.dart';

class OnBoardingScreen extends StatelessWidget {
  int ?widget;
  OnBoardingScreen({Key? key,this.widget=-1}) : super(key: key);
  var pageController=PageController();
  int index=0;
  bool goToLoginScreen=false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        ShopCubit myCubit=ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            actions: [
              TextButton(onPressed: (){
                ShopCache.saveData(key: 'skipOnBoardingScreen', value: true);
                if(widget==-1) {
                  goToAnotherScreen(context,const RegisterLoginScreen());
                } else {
                  myCubit.goToHomePage();
                  goToAnotherScreen(context,const BaseScreen());
                }
              },
                child: const Text("Skip",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),

              ),
              const SizedBox(width: 8,)
            ],
          ),
          body: Column(
            children: [
              Expanded(
                  child: PageView.builder(
                    controller: pageController,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context,index){
                      this.index=index;
                      return buildPageView(pageView[index]);
                    },
                    itemCount: pageView.length,
                    onPageChanged: (int index){
                      if(index==(pageView.length-1)){
                        goToLoginScreen=true;
                      }
                    },
                  )
              ),
              const SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    SmoothPageIndicator(
                        controller: pageController,  // PageController
                        count:  pageView.length,
                        axisDirection: Axis.horizontal,
                        effect:  const ExpandingDotsEffect(
                        ),  // your preferred effect
                        onDotClicked: (index){
                          pageController.jumpToPage(index);
                        }
                    ),
                    const Spacer(),
                    FloatingActionButton(
                      onPressed: (){
                        if(goToLoginScreen){
                          ShopCache.saveData(key: 'skipOnBoardingScreen', value: true);
                          if(widget==-1) {
                            goToAnotherScreen(context,const RegisterLoginScreen());
                          } else {
                            myCubit.goToHomePage();
                            goToAnotherScreen(context,const BaseScreen());
                          }
                        }
                        else{
                          pageController.nextPage(duration: const Duration(
                              milliseconds: 750
                          ), curve:Curves.fastLinearToSlowEaseIn);
                        }
                      },
                      child: const Icon(Icons.arrow_forward_ios),
                    ),
                    const SizedBox(width: 10,)
                  ],
                ),
              ),
              const SizedBox(height: 10,)
            ],
          ),
        );
      },
    );
  }


  Widget buildPageView(OnBoardingDetails onBoardingDetails){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Image(
            image:AssetImage(setImage(url: onBoardingDetails.image),),
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            onBoardingDetails.title,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold
            )
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
              onBoardingDetails.body,
              style: const TextStyle(
                  fontSize: 20,
              )
          ),
        ),
      ],
    );
  }
}
