import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import '../../Components/variableShared.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Cubit/Shop/shop_cubit.dart';
import '../Cubit/SignIn/sign_cubit.dart';

Future<Object?> goToAnotherScreen(context,anotherScreen){
  return Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context)=>anotherScreen),
          (route) => false
  );
}

Future<Object?> goToAnotherScreen2(context,anotherScreen){
  return Navigator.push(context,
      MaterialPageRoute(builder: (context)=>anotherScreen),
  );
}



Widget myText({required String text,
  double fontSize=20,
  Color color=Colors.black,
  FontWeight fontWeight=FontWeight.normal,
}){
  return Text(
    text,
    style: TextStyle(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
    ),
  );
}

Widget myButton({
  required String text,
  required dynamic function,
  Color buttonColor=Colors.blue,
  double fontSize=22,
  FontWeight fontWeight=FontWeight.bold,
  Color textColor=Colors.white,
  double borderRadius =40
}){
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
      color: buttonColor,
      borderRadius: BorderRadius.circular(borderRadius),
    ),
    child: MaterialButton(
      onPressed: function,
      height: 55,
      child: myText(text:text,color: textColor,fontWeight: fontWeight,fontSize: fontSize),
    ),
  );
}

Widget myTextField({
  required String text,
  required String textError,
  TextInputType keyboardType=TextInputType.text,
  String confirmPassword='',
  required TextEditingController controller,
  bool obscureText=false,
  required IconData prefixIcon,
  SignCubit ?myCubit,
  Color textColor=Colors.indigo
}){
  return  Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
    child: TextFormField(
      controller: controller,
      decoration: InputDecoration(
          labelText: text,
          labelStyle: const TextStyle(
              color: Colors.orange,
              fontSize: 18,
            fontWeight: FontWeight.bold
          ),
        prefixIcon: Icon(prefixIcon),
        suffixIcon: text.contains('Password')?IconButton(
          icon: Icon(myCubit!.passwordVisibility?Icons.visibility_off:Icons.visibility),
          onPressed: (){
            myCubit.changePasswordVisibility();
          },
        ):null,
        border: const OutlineInputBorder()
      ),
      onTap: (){
        controller.text='';
      },
      onChanged: (value){
        if(text=='Confirm Password')myCubit!.changeFormDetails();
      },
      validator: (value){
        if(value!=null && value.isEmpty){
          return textError;
        }
        else if(confirmPassword!=value && text=='Confirm Password'){
          return textError;
        }
        else{
          return null;
        }
      },
      obscureText: text.contains('Password')?myCubit!.passwordVisibility:obscureText,
      style: TextStyle(
        color: textColor,
        fontSize: 20
      ),
      keyboardType: keyboardType,
    ),
  );
}

Widget myBottomNavBar({
  required context,
  required List<PersistentBottomNavBarItem> navBarsItems,
  required List<Widget> navBarsScreens,
  PersistentTabController ?controller,
  Color backgroundColor=Colors.white,
  bool isShow=false,
  required ShopCubit shopCubit,
}){
  return PersistentTabView(
    context,
    controller: controller??PersistentTabController(),
    hideNavigationBar: isShow,
    screens: navBarsScreens,
    items:navBarsItems,
    onItemSelected: (index){
      if(index==4){
        shopCubit.disableTabBar();
      }
    },
    confineInSafeArea: true,
    backgroundColor: backgroundColor, // Default is Colors.white.
    handleAndroidBackButtonPress: true, // Default is true.
    resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
    stateManagement: true, // Default is true.
    hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
    decoration: NavBarDecoration(
      borderRadius: BorderRadius.circular(10.0),
      colorBehindNavBar: Colors.white,
    ),
    popAllScreensOnTapOfSelectedTab: true,
    popActionScreens: PopActionScreensType.all,
    itemAnimationProperties: const ItemAnimationProperties( // Navigation Bar's items animation properties.
      duration: Duration(milliseconds: 200),
      curve: Curves.easeInSine,
    ),
    screenTransitionAnimation: const ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
      animateTabTransition: true,
      curve: Curves.fastLinearToSlowEaseIn,
      duration: Duration(milliseconds: 200),
    ),
    navBarStyle: NavBarStyle.style15,
  );
}

Widget socialApp(){
  final Uri whatsApp = Uri.parse('whatsapp://send?phone=+20${01027709271}');
  final Uri telegram = Uri.parse("tg://resolve?domain=ahmedibrahim304");
  final Uri linkedin = Uri.parse('https://www.linkedin.com/in/ahmed-ibrahim-8a05001bb/');
  final Uri gmail = Uri.parse('mailto:ahmedibrahim55518@gmail.com?');
  final Uri github = Uri.parse('https://github.com/Ahmed-Ibrahim-30');

  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(url)) {
      throw 'Could not launch $url';
    }
  }

  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      FloatingActionButton(
        mini: true,
        onPressed: (){_launchUrl(whatsApp);},
        child: Image(image: AssetImage(setImage(url: 'whatssapp.png')),
      ),
      ),
      const SizedBox(width: 10,),
      FloatingActionButton(
        mini: true,
        onPressed: (){_launchUrl(telegram);},
        child: Image(image: AssetImage(setImage(url: 'telegram.png')),),
      ),
      const SizedBox(width: 10,),
      FloatingActionButton(
        mini: true,
        onPressed: (){_launchUrl(linkedin);},child: Image(
        image: AssetImage(setImage(url: 'linkedin.png')),
      ),
      ),
      const SizedBox(width: 10,),
      FloatingActionButton(
        mini: true,
        backgroundColor: Colors.transparent,
        onPressed: (){_launchUrl(gmail);},child: Image(
        image: AssetImage(setImage(url: 'gmail.png')),),
      ),
      const SizedBox(width: 10,),
      FloatingActionButton(
        mini: true,
        onPressed: (){_launchUrl(github);},
        backgroundColor: Colors.white,
        child: Image(image: AssetImage(setImage(url: 'github.png')),color: Colors.black,),
      ),
    ],
  );
}

Widget productDetails(dynamic productModel ,ShopCubit myCubit,int index){
  return Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Image(
              image: NetworkImage(productModel.image),
              width: double.infinity,
              height: 200.0,
            ),
            if(productModel.discount!=0)Container(
              decoration: BoxDecoration(
                  color: Colors.red[700],
                  borderRadius: BorderRadius.circular(10)

              ),
              child: const Padding(
                padding: EdgeInsets.all(5.0),
                child: Text(
                  'Discount',
                  style:  TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                productModel.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14,
                  height: 1.3,
                ),
              ),

              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 3.0),
                        child: Text(
                          'EGP ${productModel.price}',
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      if(productModel.discount!=0)Row(
                        children: [
                          Text(
                            'EGP ${(productModel.oldPrice).round()}',
                            style: const TextStyle(
                                fontSize: 14,
                                decoration: TextDecoration.lineThrough
                            ),
                          ),
                          const SizedBox(width: 5,),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.red[300],
                                borderRadius: BorderRadius.circular(10)

                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                '-${(((productModel.price /productModel.oldPrice)*100)-100).round()}%',
                                style:  TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[300],

                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(top: 7,left: 4),
                    child: CircleAvatar(
                      backgroundColor: Colors.yellow[400],
                      child: IconButton(
                        onPressed: (){
                          if(productModel.inFavorites){
                            productModel.inFavorites=false;
                            myCubit.deleteFavouriteProduct(productId: productModel.id);
                          }
                          else{
                            productModel.inFavorites=true;
                            myCubit.addFavouriteProduct(product: productModel);
                          }
                        },
                        icon: Icon(Icons.favorite,color:productModel.inFavorites?Colors.red:Colors.grey),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 5,)
      ],
    ),
  );
}
