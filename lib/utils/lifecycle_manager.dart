// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:parallex/screens/common/viemodels/base_view_model.dart';
//
//
// class LifeCycleManager extends StatefulWidget {
//   final Widget child;
//
//   const LifeCycleManager({Key? key, required this.child}) : super(key: key);
//
//   @override
//   LifeCycleManagerState createState() => LifeCycleManagerState();
// }
//
// class LifeCycleManagerState extends State<LifeCycleManager>
//     with WidgetsBindingObserver {
//   Timer? _inactiveTimer;
//
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addObserver(this);
//   }
//
//   @override
//   void dispose() {
//     _inactiveTimer?.cancel();
//     WidgetsBinding.instance.removeObserver(this);
//     super.dispose();
//   }
//
//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     if (state == AppLifecycleState.resumed) {
//       _inactiveTimer?.cancel();
//     } else if (state == AppLifecycleState.inactive) {
//       // Set a timer to navigate to the login screen after 1 minutes of inactivity
//       _inactiveTimer = Timer(const Duration(minutes: 1), () {
//         BaseViewmodel().logOut();
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: widget.child,
//     );
//   }
// }
