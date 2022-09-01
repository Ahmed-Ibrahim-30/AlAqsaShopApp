import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Components/SharedPreference.dart';
import '../../Modules/base_screen.dart';
import '../../Modules/onboarding_view.dart';
import '../../Network/dio_helper.dart';
import 'Components/variableShared.dart';
import 'Cubit/Shop/shop_cubit.dart';
import 'Cubit/SignIn/signStates.dart';
import 'Cubit/blocObserver.dart';
import 'Cubit/SignIn/sign_cubit.dart';
import 'Modules/profile_screen/register_login_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await ShopCache.init();
  Widget widget;
  if(ShopCache.getData(key:'skipOnBoardingScreen')!=null && ShopCache.getData(key:'skipOnBoardingScreen')){
    if(myToken==''){
      widget=const RegisterLoginScreen();
    }
    else {
      widget=const BaseScreen();
    }
  }
  else {
    widget=OnBoardingScreen();
  }
  BlocOverrides.runZoned(() {runApp(MyApp(widget:widget));},
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final Widget ?widget;
  const MyApp({Key? key,this.widget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) =>SignCubit()),
        BlocProvider(create: (BuildContext context) =>ShopCubit()..getHomeData()..getCategoriesData()),
      ],
      child: BlocConsumer<SignCubit,SignStates>(
        listener: (context,state){},
        builder: (context,state){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                floatingActionButtonTheme: const FloatingActionButtonThemeData(
                  backgroundColor: Colors.orange,
                  iconSize: 25,
                ),
                appBarTheme: const AppBarTheme(
                    color: Colors.white,
                    elevation: 0.0,
                    systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarBrightness: Brightness.dark,
                        statusBarColor: Colors.white,
                        statusBarIconBrightness: Brightness.dark
                    )
                )
            ),
            home: widget,
          );
        },
      ),
    );
  }

}