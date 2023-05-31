import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:merchant_app/feauters/profile/widgets_profile/settings_item_widget.dart';
import '../../core/components/button.dart';
import '../../core/components/default_error.dart';
import '../../core/components/default_image.dart';
import '../../core/components/defualt_loading.dart';
import '../../core/components/my_divider.dart';
import '../../core/components/my_text.dart';
import '../../core/components/text_button.dart';
import '../../core/components/toast_notifications.dart';
import '../../core/data/network/local/cache_helper.dart';
import '../../core/functions.dart';
import '../../core/languages.dart';
import '../../core/network/local/keys.dart';
import '../../core/resources/assets_manager.dart';
import '../../core/resources/color_manager.dart';
import '../../core/resources/constants_manager.dart';
import '../../core/resources/string_manager.dart';
import '../../core/resources/styles_manager.dart';
import '../../core/resources/values_manager.dart';
import '../authintication/presentation/login/login_screen.dart';
import '../layouts/domin/response/profile_response.dart';
import '../layouts/home_leyout/home_layout_cubit/home_layout_cubit.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import '../order/presentation/orders/orders_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _showError = false;
  bool _showLoading = false;

  Future<void> _fetchProfileData() async {
    setState(() {
      _showError = false;
    });
    // Dispatch an event to fetch the profile data
      await BlocProvider.of<HomeLayoutCubit>(context).getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeLayoutCubit, HomeLayoutStates>(
        listener: (context, state) {
      if (state is GetProfileErrorState) {
        setState(() {
          _showError = true;
        });
      }else if(state is GetProfileLoadingState){
        setState(() {
          _showLoading=true;
        });
      }
      // TODO: implement listener
    }, builder: (context, state) {
      HomeLayoutCubit cubit = HomeLayoutCubit.get(context);
      if (_showError) {
        return const Center(
          child: DefaultError(),
        );
      }else if(_showLoading){
        return const Center(
          child: DefaultLoading(),
        );
      }
      return RefreshIndicator(
        onRefresh: _fetchProfileData,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsetsDirectional.all(AppPadding.p8),
            child: Column(
              children: [
                getUserWidget(),
                MyDivider(margin: 8.0),
                languageSettings(),
                MyDivider(
                  margin: 8.0,
                  width: getScreenWidth(context) / 3,
                  alignment: AlignmentDirectional.centerStart,
                  color: ColorManager.lightPrimary,
                ),
                if (cubit.profileResponse.data != null)
                  getProfileInfo(cubit.profileResponse.data!),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget getUserWidget() {
    return BlocConsumer<HomeLayoutCubit, HomeLayoutStates>(
      listener: (context, state) {
        if (state is LogoutDoneState) {
          showToast(text: state.message, state: ToastStates.SUCCESS);

          // Remove Token;
          CacheHelper.removeData(key: CacheHelperKeys.token).then((value) {
            Constants.token = "";
          });

          // Remove Full Name;
          CacheHelper.removeData(key: CacheHelperKeys.fullName).then((value) {
            Constants.fullName = "";
          });

          // Remove email;
          CacheHelper.removeData(key: CacheHelperKeys.email).then((value) {
            Constants.email = "";
          });
          // Remove uId;
          CacheHelper.removeData(key: CacheHelperKeys.sId).then(
                (value) {
              Constants.sId = "";
            },
          );
          setState(() {
            login2AccountWidget();
          });
        }
      },
      builder: (context, state) {
        HomeLayoutCubit cubit = HomeLayoutCubit.get(context);
        return Stack(
          alignment: AlignmentDirectional.topEnd,
          children: [
            Container(
              width: double.infinity,
              height: 100.0,
              padding: const EdgeInsetsDirectional.all(AppPadding.p8),
              decoration: BoxDecoration(
                color: ColorManager.lightPrimary.withOpacity(.5),
                borderRadius: BorderRadius.circular(AppSize.s8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Lottie.asset(JsonAssets.login),
                  const SizedBox(
                    width: 5.0,
                  ),
                  if (Constants.token.isEmpty || state is LogoutDoneState)
                    login2AccountWidget()
                  else
                    Conditional.single(
                      context: context,
                      conditionBuilder: (BuildContext context) =>
                      state is! GetProfileLoadingState,
                      widgetBuilder: (BuildContext context) {
                        return merchantData(merchantInfo: cubit.profileResponse.data?.user );
                      },
                      fallbackBuilder: (BuildContext context) {
                        return const DefaultLoading();
                      },
                    ),
                ],
              ),
            ),
            if (Constants.token.isNotEmpty && state is! LogoutDoneState)
              logoutWidget()
            else
              const SizedBox(),
          ],
        );
      },
    );
  }


  Widget login2AccountWidget() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MText(
            text: AppStrings.loginNow2YourAccount,
          ),
          DefaultButton(
            function: () {
              navigateTo(context, const LoginScreen());
            },
            text: AppStrings.login,
            width: 90.0,
          ),
        ],
      ),
    );
  }


  Widget logoutWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ElevatedButton(
        onPressed: () {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return BlocConsumer<HomeLayoutCubit, HomeLayoutStates>(
                listener: (context, state) {
                  if (state is LogoutDoneState) {
                    Navigator.of(context).pop();
                  }
                },
                builder: (context, state) {
                  HomeLayoutCubit cubit = HomeLayoutCubit.get(context);
                  return AlertDialog(
                    title: MText(
                      text: AppStrings.confirmationLogout,
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        MText(
                          text: AppStrings.areYouSureYouWantToLogout,
                        ),
                        state is LogoutLoadingState
                            ? const DefaultLoading()
                            : Container(),
                        state is LogoutErrorState
                            ? MText(
                          text: AppStrings
                              .somethingsErrorPleaseCheckYourInternet,
                          maxLines: 2,
                        )
                            : Container()
                      ],
                    ),
                    actions: [
                      DTextButton(
                        text: AppStrings.yes,
                        function: () {
                          cubit.logout();
                          setState(() {});
                        },
                      ),
                      DTextButton(
                        text: AppStrings.no,
                        function: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
          );
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            MText(
              text: AppStrings.logout,
              style: getRegularStyle(
                  color: ColorManager.white, fontSize: AppSize.s14),
            ),
            const SizedBox(
              width: AppSize.s4,
            ),
            const Icon(
              Icons.logout,
              color: ColorManager.white,
              size: AppSize.s16,
            ),
          ],
        ),
      ),
    );
  }


  Widget merchantData({
    User? merchantInfo,
  }) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MText(
            text: merchantInfo?.fullName ??
                CacheHelper.getData(key: CacheHelperKeys.fullName),
            color: ColorManager.darkPrimary,
          ),
          MText(
            text: merchantInfo?.email ??
                CacheHelper.getData(key: CacheHelperKeys.email),
            color: ColorManager.darkPrimary,
          ),
        ],
      ),
    );
  }

  Decoration getDeco({Color? color}) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(8.0),
      color: color,
    );
  }

  Widget languageSettings() {
    return Row(
      children: [
        const SizedBox(
          width: 4.0,
        ),
        MText(text: AppStrings.appLanguage),
        const Spacer(),
        DottedBorder(
          radius: const Radius.circular(AppSize.s8),
          color: ColorManager.darkPrimary,
          borderType: BorderType.RRect,
          child: Container(
            decoration: getDeco(),
            width: 140.0,
            height: 40.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: getDeco(
                    color:
                        Langs.isEN ? ColorManager.white : ColorManager.primary,
                  ),
                  child: TextButton(
                    onPressed: () {
                      if (Langs.isEN) {
                        Langs.changeLang(context);
                        setState(() {
                          Phoenix.rebirth(context);
                        });
                      } else {
                        showToast(
                          text: 'الوضع الحالي هو العربية!',
                          state: ToastStates.WARNING,
                        );
                      }
                    },
                    child: MText(
                      text: AppStrings.arabic,
                      style: getBoldStyle(
                        color: Langs.isEN
                            ? ColorManager.primary
                            : ColorManager.white,
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: getDeco(
                    color:
                        Langs.isEN ? ColorManager.primary : ColorManager.white,
                  ),
                  child: TextButton(
                    onPressed: () {
                      if (!Langs.isEN) {
                        Langs.changeLang(context);
                        setState(() {
                          Phoenix.rebirth(context);
                        });
                      } else {
                        showToast(
                          text: 'You are already in English Mode',
                          state: ToastStates.WARNING,
                        );
                      }
                    },
                    child: MText(
                      text: AppStrings.english,
                      style: getBoldStyle(
                        color: Langs.isEN
                            ? ColorManager.white
                            : ColorManager.primary,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget getProfileInfo(Data _profile) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.35,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFF0AC00),
                Color(0xFFECD496),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10.0),
               DefaultImage(
                  imageUrl:_profile.user!.marketLogo!,
                  clickable: false,
                ),
              const SizedBox(height: 10.0),
              Text(
                _profile.user!.marketName!,
                style: const TextStyle(
                  fontSize: 22.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10.0),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  children: [
                    ProfileInfoRow(
                      icon: Icons.person,
                      label: "Name",
                      value: _profile.user!.fullName!,
                    ),
                    ProfileInfoRow(
                      icon: Icons.email,
                      label: "Email",
                      value: _profile.user!.email!,
                    ),
                    ProfileInfoRow(
                      icon: Icons.phone,
                      label: "Phone",
                      value: _profile.user!.phone!,
                    ),
                    ProfileInfoRow(
                      icon: Icons.location_on,
                      label: "Address",
                      value: _profile.user!.address!,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSize.s16),
              Container(
                margin: const EdgeInsetsDirectional.all(AppMargin.m8),
                padding: const EdgeInsetsDirectional.all(AppPadding.p12),
                decoration: BoxDecoration(
                  color: ColorManager.white,
                  borderRadius:
                  BorderRadiusDirectional.circular(AppSize.s8),
                  boxShadow: const [
                    BoxShadow(
                      color: ColorManager.grey,
                      blurRadius: 5.0,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SettingsItemWidget(
                      onTap: () {},
                      iconPath: IconsAssets.payment,
                      titleTR: AppStrings.paymentMethod,
                    ),
                    SettingsItemWidget(
                      onTap: () => handleOrderHistoryPress(),
                      iconPath: IconsAssets.order,
                      titleTR: AppStrings.orderHistory,
                    ),
                    // SettingsItemWidget(
                    //   onTap: () => handleWishlistPress(),
                    //   iconPath: IconsAssets.wishlist,
                    //   titleTR: AppStrings.wishlist,
                    // ),
                    // SettingsItemWidget(
                    //   onTap: () => handleLangPress(),
                    //   iconPath: IconsAssets.language,
                    //   titleTR: AppStrings.appLanguage,
                    //   isLang: true,
                    //   withDivider: false,
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
  // Functions:



// 2. handle Order History Press:
  handleOrderHistoryPress() {
    navigateTo(context, const OrdersScreen());
  }

  // 3. handle Wishlist Press

}

class ProfileInfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  ProfileInfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF6F35A5)),
          const SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
