 import 'dart:async';
import 'package:giftpose/utils/localization_provider.dart';


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
import 'dart:convert';
import 'package:http/http.dart' as http;

class PostcodeScreen extends StatefulWidget {
  final bool fromDashboard;
  PostcodeScreen({super.key, this.fromDashboard = false});

  @override
  State<PostcodeScreen> createState() => _PostcodeScreenState();
}

class _PostcodeScreenState extends State<PostcodeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool showSecondLogo = false; // 🔁 Toggle for logo
  Set<Circle> _circles = {};
  LatLng? _selectedLocation;
  double milesToMeters(double miles) {
    return miles * 1609.34;
  }

  void _updateRadius(double miles) {
    if (_selectedLocation == null) return;

    final radiusMeters = miles * 1609.34;

    setState(() {
      _circles = {
        Circle(
          circleId: CircleId("radius"),
          center: _selectedLocation!,
          radius: radiusMeters,
          fillColor: GiftPoseColors.primaryColor.withOpacity(0.2),
          strokeColor: GiftPoseColors.primaryColor,
          strokeWidth: 2,
        ),
      };
    });

    /// adjust map zoom to fit the circle
    final bounds = LatLngBounds(
      southwest: LatLng(
        _selectedLocation!.latitude - (radiusMeters / 111320),
        _selectedLocation!.longitude - (radiusMeters / 111320),
      ),
      northeast: LatLng(
        _selectedLocation!.latitude + (radiusMeters / 111320),
        _selectedLocation!.longitude + (radiusMeters / 111320),
      ),
    );

    _mapController?.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
  }

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

  LatLng _initialPosition = LatLng(51.5074, -0.1278); // Lagos default
  Set<Marker> _markers = {};
  final postcodeCtrl = TextEditingController();

  Future<void> _searchPostcode() async {
    final input = postcodeCtrl.text.trim();
    if (input.isEmpty) return;

    try {
    var  apiKey = "AIzaSyD0adDCs8YaUAElLHDL19qc114FeDT5Pl8";

      final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?address=$input&key=$apiKey',
      );

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['status'] == 'OK' && data['results'].isNotEmpty) {
          final location = data['results'][0]['geometry']['location'];
          final lat = location['lat'];
          final lng = location['lng'];
          final newPosition = LatLng(lat, lng);

          // Update Map Camera
          _mapController?.animateCamera(
            CameraUpdate.newLatLngZoom(newPosition, 12),
          );

          setState(() {
            _selectedLocation = newPosition;
            _markers = {
              Marker(
                markerId: MarkerId('searched-location'),
                position: newPosition,
              ),
            };
          });

          // Update Circle Radius
          final vm = Provider.of<OnboardingViewModel>(context, listen: false);
          _updateRadius(vm.miles);
        } else {
          debugPrint("Google API Error: ${data['status']}");
        }
      }
    } catch (e) {
      debugPrint("Network/Geocoding Error: $e");
    }
  }

  Future<void> _initializeMapFromDashboard() async {
    final dashVM = Provider.of<DashboardViewmodel>(context, listen: false);
    final onboardingVm = Provider.of<OnboardingViewModel>(
      context,
      listen: false,
    );

    final postcode =
        dashVM.fetchItemsNearMeResponse.data?.userLocation.postcode;

    if (postcode == null || postcode.isEmpty) return;

    postcodeCtrl.text = postcode;

    try {
      List<Location> locations = await locationFromAddress(postcode);

      if (locations.isNotEmpty) {
        final lat = locations.first.latitude;
        final lng = locations.first.longitude;

        final position = LatLng(lat, lng);

        setState(() {
          _selectedLocation = position;

          _markers = {
            Marker(
              markerId: MarkerId('dashboard-location'),
              position: position,
            ),
          };
        });

        _mapController?.animateCamera(CameraUpdate.newLatLngZoom(position, 12));

        _updateRadius(onboardingVm.miles);
      }
    } catch (e) {
      debugPrint("Postcode init error: $e");
    }
  }

  Timer? _debounce;
  @override
  Widget build(BuildContext context) {
    return GiftPoseBaseScaffold(
      includeHorizontalPadding: true,
      includeVerticalPadding: false,

      showAppBar: true,
      hasGradient: false,

      appBarLeadingWidget: widget.fromDashboard
          ? InkWell(
              onTap: () {
                HapticFeedback.heavyImpact();
                Navigator.pop(context);
              },
              child: Container(
                width: 200,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    20,
                  ), // Adjust the value for more/less rounding
                ),
                child: Padding(
                  padding: EdgeInsets.all(14.0),
                  child: Assets.icons.back.svg(
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
              ),
            )
          : SizedBox.shrink(),

      appBarTitleWidget: Text("Set Location".tr(context),
        textAlign: TextAlign.center,

        style: GiftPoseTextStyle.large(fontWeight: FontWeight.w500),
      ),
      centerTitle: true,

      builder: (size) {
        return Column(
          children: [
            YMargin(50),
            GiftPoseTextField(
              controller: postcodeCtrl,

              hintText: "Enter your postcode".tr(context),
              prefixIcon: Assets.icons.search.svg(),
              onChanged: (value) {
                if (_debounce?.isActive ?? false) _debounce!.cancel();

                _debounce = Timer(Duration(milliseconds: 600), () {
                  _searchPostcode();
                });
              },
            ),
            SizedBox(
              height: 282,
              width: double.infinity,
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: _initialPosition,
                  zoom: 10,
                ),
                onMapCreated: (controller) {
                  _mapController = controller;
                  _initializeMapFromDashboard();
                },
                markers: _markers,
                circles: _circles,
              ),
            ),

            YMargin(26),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text("How far are you willing to travel?".tr(context),
                textAlign: TextAlign.center,

                style: GiftPoseTextStyle.medium(fontWeight: FontWeight.w500),
              ),
            ),
            YMargin(14),
            Consumer<OnboardingViewModel>(
              builder: (context, vm, child) {
                return DurationSlider(
                  onChanged: (value) {
                    vm.updateMiles(value); // update state
                    _updateRadius(value); // update map
                  },
                );
              },
            ),
            YMargin(32),

            Consumer<OnboardingViewModel>(
              builder: (context, vm, child) {
                return GiftPoseButton(
                  title: "Submit".tr(context),
                  onTap: () {
                    HapticFeedback.heavyImpact();
                    vm.registerLocation(
                      isFromDashboard: widget.fromDashboard,
                      context: context,
                      postcode: postcodeCtrl.text,
                    );
                  },
                );
              },
            ),
          ],
        );
      },
    );
  }
}
