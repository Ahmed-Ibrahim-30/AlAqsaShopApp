abstract class ShopStates{}
class ShopInitState extends ShopStates{}

class HomeLoadingState extends ShopStates{}
class HomeSuccessState extends ShopStates{}
class HomeErrorState extends ShopStates{}

class CategoriesLoadingState extends ShopStates{}
class CategoriesSuccessState extends ShopStates{}
class CategoriesErrorState extends ShopStates{}


class AddFavouriteLoadingState extends ShopStates{}
class AddFavouriteSuccessState extends ShopStates{}
class AddFavouriteErrorState extends ShopStates{}

class DeleteFavouriteLoadingState extends ShopStates{}
class DeleteFavouriteSuccessState extends ShopStates{}
class DeleteFavouriteErrorState extends ShopStates{}


class GoToHomeState extends ShopStates{}
class GoToSettingsState extends ShopStates{}
class DisableTabBarState extends ShopStates{}
class EnableTabBarState extends ShopStates{}
class LogoutSuccessState extends ShopStates{
  final bool status;
  final String message;
  LogoutSuccessState(this.status,this.message);
}
class LogoutLoadingState extends ShopStates{}
class LogoutErrorState extends ShopStates{}

class SearchLoadingState extends ShopStates{}
class SearchSuccessState extends ShopStates{}
class SearchErrorState extends ShopStates{}

