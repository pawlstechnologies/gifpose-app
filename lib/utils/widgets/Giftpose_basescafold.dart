import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:giftpose/screens/main_view/viewmodels/base_viewmodel.dart';

//import 'package:parallex/gen/assets.gen.dart';

import 'package:provider/provider.dart';


class GiftPoseBaseScaffold extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget? appbarTrailingIcon;

  final Widget Function(
    Size size,
  ) builder;
  final Widget? bottomNavBar;
  final Widget? drawer;
  final Widget? endDrawer;
  final Key? scaffoldKey;
  final Color? backgroundColor;
  final bool resizeToAvoidBottomInset;
  final bool safeTop;
  final Widget? appBarLeadingWidget;
  final Widget? appBarAction;
  final bool safeBottom;
  final VoidCallback? onBackPressed;
  final Widget? floatingActionButton;
  final bool includeHorizontalPadding;
  final bool showAppBar;
  final Widget? appBarTitleWidget;
  final Widget? appBarIcon;
  final bool includeVerticalPadding;
  final bool showAppbarColor;
  final Color appBarColor;
  final bool? centerTitle;
  final bool? hasGradient;
  const GiftPoseBaseScaffold(
      {super.key,
      required this.builder,
      this.floatingActionButton,
      this.showAppBar = true,
      this.appBar,
      this.appbarTrailingIcon,
      this.bottomNavBar,
      this.drawer,
      this.endDrawer,
      this.scaffoldKey,
      this.backgroundColor,
      this.resizeToAvoidBottomInset = true,
      this.safeTop = true,
      this.safeBottom = false,
      this.onBackPressed,
      this.includeHorizontalPadding = true,
      this.appBarAction,
      this.includeVerticalPadding = true,
      this.appBarIcon,
      this.showAppbarColor = false,
      this.appBarColor = Colors.white,
      this.appBarLeadingWidget,
      this.appBarTitleWidget,
      this.centerTitle,
      this.hasGradient});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: LayoutBuilder(
        builder: (context, constraint) {
          Size constraints = Size(constraint.maxWidth, constraint.maxHeight);
          return GestureDetector(
            onTap: () {
              //unfocus any active TextField
              FocusScope.of(context).unfocus();
            },
            child: Consumer<BaseViewmodel>(
              builder: (context, baseModelView, child) {
                return Scaffold(
                  floatingActionButton: floatingActionButton,
                  backgroundColor:  Theme.of(context).scaffoldBackgroundColor,
                  // backgroundColor: backgroundColor ??
                  //     ((baseModelView.parellexThemeMode ==
                  //             ParallexThemeMode.light)
                  //         ? ParallexColors.backgroundColor
                  //         : (baseModelView.parellexThemeMode ==
                  //                 ParallexThemeMode.dark)
                  //             ? ParallexColors.darkModeBackgroundColor
                  //             : ParallexColors
                  //                 .nightModeBackgroundColor), //change color
                  key: scaffoldKey,
                  drawer: drawer,
                  endDrawer: endDrawer,
                  appBar: showAppBar
                      ? appBar ??
                          AppBar(
                            toolbarHeight: 25.h,
                            elevation: 0,
                            leadingWidth: 40,
                            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                            title: appBarTitleWidget,
                            leading: Padding(
                              padding: const EdgeInsets.only(left: 15.0,top: 10),
                              child: appBarLeadingWidget ??
                                  GestureDetector(
                                    onTap: () => Navigator.pop(context),
                                    child: SizedBox(
                                width: 12,
                                height: 12,
                                child: 
                            SizedBox()
                              )
                                  ),
                            ),
                            centerTitle: centerTitle ?? false,
                            
                            actions: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: appbarTrailingIcon,
                              ),
                            ],
                          )
                      : null,

                  bottomNavigationBar: bottomNavBar,
                  body: Builder(
                    builder: (_) => Container(
                      // decoration:  hasGradient == true ? BoxDecoration(
                      //   gradient: LinearGradient(
                      //     begin: Alignment.topCenter,
                      //       end: Alignment.bottomCenter,
                      //       colors:[
                      //         const Color(0xffF3F1F8),
                      //         const Color.fromRGBO(243, 241, 248, 0.82),
                      //         const Color.fromRGBO(243, 241, 248, 0.82),
                      //         ParallexColors.secondarycolor.withOpacity(0.3)
                      //       ]
                      //   )
                      // ) : null,
                      width: constraints.width,
                      height: constraints.height,
                      padding: EdgeInsets.only(
                          left: includeHorizontalPadding ? 18.w : 0.w,
                          right: includeHorizontalPadding ? 18.w : 0.w,
                          top: includeVerticalPadding ? 50.h : 0.w),
                      child: builder(
                        constraints,
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
