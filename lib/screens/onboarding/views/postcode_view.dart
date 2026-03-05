import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:giftpose/app.dart';
import 'package:giftpose/gen/assets.gen.dart';
import 'package:giftpose/screens/main_view/viewmodels/base_viewmodel.dart';
import 'package:giftpose/screens/main_view/viewmodels/dashboard_viewmodel.dart';
import 'package:giftpose/screens/onboarding/viewmodels/onboarding_viewmodel.dart';
import 'package:giftpose/utils/router/app_routes.dart';
import 'package:giftpose/utils/theme/giftpose_colors.dart';
import 'package:giftpose/utils/theme/giftpose_text_style.dart';
import 'package:giftpose/utils/theme/theme.dart';
import 'package:giftpose/utils/widgets/Giftpose_basescafold.dart';
import 'package:giftpose/utils/widgets/duration_slider.dart';
import 'package:giftpose/utils/widgets/giftpose_button.dart';
import 'package:giftpose/utils/widgets/giftpose_textfield.dart';
import 'package:giftpose/utils/widgets/spacing.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class PostcodeScreen extends StatefulWidget {
  final bool fromDashboard;
  const PostcodeScreen({super.key,  this.fromDashboard= false});

  @override
  State<PostcodeScreen> createState() => _PostcodeScreenState();
}

class _PostcodeScreenState extends State<PostcodeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool showSecondLogo = false; // 🔁 Toggle for logo

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
    GoogleMapController? _mapController;

  LatLng _initialPosition =  LatLng(51.5074, -0.1278); // Lagos default
  Set<Marker> _markers = {};
  final postcodeCtrl = TextEditingController();
  Future<void> _searchPostcode() async {
     final viewmodel = Provider.of<DashboardViewmodel>(context, listen: false);
    try {
      List<Location> locations =
          await locationFromAddress(postcodeCtrl.text);

      if (locations.isNotEmpty) {
        final lat = locations.first.latitude;
        final lng = locations.first.longitude;

        final newPosition = LatLng(lat, lng);

        _mapController?.animateCamera(
          CameraUpdate.newLatLngZoom(newPosition, 15),
        );

        setState(() {
          _markers = {
            Marker(
              markerId: const MarkerId('searched-location'),
              position: newPosition,
            )
          };
        });
      }
    } catch (e) {
      print("Error: $e");
    }}

  @override
  Widget build(BuildContext context) {
    return Consumer<OnboardingViewModel>(builder: (context, onboardingVM, child) {
    

        return GiftPoseBaseScaffold(
          includeHorizontalPadding:true,
          includeVerticalPadding: false,
        
          showAppBar: true,
          hasGradient: false,
        
    appBarLeadingWidget:
    widget.fromDashboard?
     InkWell(
        onTap: () {
          HapticFeedback.selectionClick();
          Navigator.pop(context);
        },
        child: Assets.icons.back.svg(
          color: Theme.of(context).textTheme.bodyLarge?.color,
        ),
      ): SizedBox.shrink(),


          
          
          appBarTitleWidget: Text(
            "Set Location",
            textAlign: TextAlign.center,
        
            style: GiftPoseTextStyle.large(fontWeight: FontWeight.w500),
          ),
          centerTitle: true,
        
          builder: (size) {
            return Column(
              children: [
                YMargin(50),
                GiftPoseTextField(controller: postcodeCtrl, hintText: "Enter your postcode",prefixIcon: Assets.icons.search.svg(),onChanged: (value){
                  _searchPostcode();
                  
                },),
                         SizedBox(
                          height: 282,
                          width: 380,
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: _initialPosition,
                zoom: 10,
              ),
              onMapCreated: (controller) {
                _mapController = controller;
              },
              markers: _markers,
            ),
          ),
        
                YMargin(26),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "How far are you willing to travel?",
                    textAlign: TextAlign.center,
        
                    style: GiftPoseTextStyle.medium(fontWeight: FontWeight.w500),
                  ),
                ),
                YMargin(14),
                DurationSlider(),
                YMargin(32),
        
                GiftPoseButton(title: "Submit", onTap: () {
                  HapticFeedback.selectionClick();
                 onboardingVM.registerLocation(context: context, postcode: postcodeCtrl.text);
                }),
              ],
            );
          },
        );
      }
    );
  }
}
