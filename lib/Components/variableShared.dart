import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import '../../Modules/SearchScreen/search_screen.dart';
import '../Model/login.dart';
import '../Model/onboarding_details.dart';
import '../Modules/CategoriesScreen/categories_screen.dart';
import '../Modules/FavouriteScreen/favourite_screen.dart';
import '../Modules/HomeScreen/home_screen.dart';
import '../Modules/SettingsScreen/settings_screen.dart';
import 'SharedPreference.dart';

String baseUrl='https://student.valuxapps.com/api/';
String myToken=ShopCache.getData(key: 'token')??'';
String loginUrl='login';
String registerUrl='register';
String logoutUrl='logout';
String profilerUrl='profile';
String homeUrl='home';
String categoriesUrl='categories';
String favoritesUrl='favorites';
String updateProfileUrl='update-profile';
String setFcmTokenUrl='fcm-token';
String searchUrl='products/search';
String responseLanguage='en';
String appName="Al-Aqsa Online Shop";
SignInModel ?userDetails;



String setImage({required String url}){
  return 'assets/images/$url';
}
List<PersistentBottomNavBarItem> navBarsItems =[
  PersistentBottomNavBarItem(
    icon: const Icon(CupertinoIcons.home),
    title: ("Home"),
    activeColorPrimary: CupertinoColors.systemYellow,
    inactiveColorPrimary: CupertinoColors.systemGrey,
    activeColorSecondary: Colors.black,
  ),
  PersistentBottomNavBarItem(
    icon: const Icon(Icons.apps),
    title: ("Categories"),
    activeColorPrimary: CupertinoColors.systemYellow,
    inactiveColorPrimary: CupertinoColors.systemGrey,
    activeColorSecondary: Colors.black,
  ),
  PersistentBottomNavBarItem(
    icon: const Icon(Icons.search),
    title: ("Search"),
    activeColorPrimary: CupertinoColors.systemGreen,
    inactiveColorPrimary: CupertinoColors.black,
    activeColorSecondary: Colors.black87,
  ),
  PersistentBottomNavBarItem(
    icon: const Icon(Icons.favorite),
    title: ("Favorite"),
    activeColorPrimary: CupertinoColors.systemYellow,
    inactiveColorPrimary: CupertinoColors.systemGrey,
    activeColorSecondary: Colors.black,
  ),
  PersistentBottomNavBarItem(
    icon: const Icon(Icons.settings),
    title: ("Settings"),
    activeColorPrimary: CupertinoColors.systemYellow,
    inactiveColorPrimary: CupertinoColors.systemGrey,
    activeColorSecondary: Colors.black,
  ),
];

List<Widget>navBarsScreens=[
  const HomeScreen(),
  const CategoriesScreen(),
  const SearchScreen(),
  const FavouriteScreen(),
  const SettingsScreen(),
];

List<OnBoardingDetails> pageView=[
  OnBoardingDetails(image: 'aboutShop1.webp', title: 'Wish List', body: ''
      'you can quickly find the products you are  interested in, without having to browse your entire offer and '
      'you can add favourite items to wishlist '),
  OnBoardingDetails(image: 'aboutShop19.gif',
      title: 'Detailed product descriptions',
      body: 'Customers interested in buying a product can check its details such as type, size, weight, color, material,'
          ' and warranty,and they will see a product from many different angles,in addition to also offer 3D product visualizations where users can intuitively turn the product around to see it better.'),
  OnBoardingDetails(image: 'aboutShop13.jpg',
      title: 'Shopping cart',
      body: ' A shopping cart allows customers to realize their purchase in several stages. For example, a user can add a product to the cart, and if they don’t want to proceed to checkout immediately, return to it easily. That way, adding products to the shopping cart once again isn’t necessary,'
          ' saving customers their time.'),
  OnBoardingDetails(image: 'aboutShop18.jfif',
      title: 'Shipping options',
      body: 'allowing users to choose from different shipping options and adding the shipping address easily,'
          'This feature informs the user about the available shipping options  and can display how much each of them costs '
  ),
  OnBoardingDetails(image: 'aboutShop5.webp',
      title: 'Returns and checking the return status',
      body: 'Online shopping can be tricky, and products customers receive sometimes depart from what they imagined to be, or one of their features is wrong (for example, size or color).'
          ' That’s why developing a smooth returns process is so important.  By offering a clear returns procedure and the option to check the status of returns easily, you’ll enhance the transparency of your store and become more trustworthy in the eyes of customers.'
  ),
];


