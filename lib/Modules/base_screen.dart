import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/Cubit/Shop/shop_cubit.dart';
import 'package:shopapp/Cubit/Shop/shop_states.dart';
import '../Components/variableShared.dart';
import '../Components/widget_shared.dart';

class BaseScreen extends StatelessWidget {
  const BaseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
        listener:(context,state){},
        builder: (context,state){
          ShopCubit myCubit=ShopCubit.get(context);
          return myBottomNavBar(
              context:context,
              navBarsItems: navBarsItems,
              controller:myCubit.persistentTabController,
              navBarsScreens: navBarsScreens,
              isShow: myCubit.showTabBar,
              shopCubit: myCubit
          );
        },

    );
  }
}
