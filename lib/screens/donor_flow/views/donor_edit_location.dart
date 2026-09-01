import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:giftpose/screens/donor_flow/widgets/donor_widgets.dart';
import 'package:giftpose/screens/donor_flow/viewmodels/donor_viewmodel.dart';
import 'package:giftpose/utils/theme/giftpose_colors.dart';
import 'package:giftpose/utils/widgets/Giftpose_basescafold.dart';
import 'package:giftpose/utils/widgets/giftpose_button.dart';
import 'package:provider/provider.dart';

class DonorEditLocationScreen extends StatelessWidget {
  const DonorEditLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.read<DonorViewmodel>();
    return GiftPoseBaseScaffold(
      showAppBar: false,
      includeHorizontalPadding: false,
      includeVerticalPadding: false,
      hasGradient: false,
      builder: (_) => Padding(
        padding: EdgeInsets.fromLTRB(17.w, 34.w, 16.w, 20.w),
        child: Column(
          children: [
            const DonorHeader(title: 'Edit Location'),
            SizedBox(height: 22.w),
            TextField(
              controller: vm.postCodeController,
              decoration: InputDecoration(
                hintText: 'Enter your postcode',
                prefixIcon: const Icon(Icons.search, color: Color(0xFFB2B2B2)),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: GiftPoseColors.borderColor),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: GiftPoseColors.primaryColor),
                  borderRadius: BorderRadius.circular(6.r),
                ),
              ),
            ),
            SizedBox(height: 18.w),
            ClipRRect(
              borderRadius: BorderRadius.circular(2.r),
              child: Image.asset(
                'assets/images/map.png',
                width: 343.w,
                height: 283.w,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 37.w),
            GiftPoseButton(
              title: 'Submit',
              height: 49,
              scaleHeightByWidth: true,
              onTap: () {
                final postCode = vm.postCodeController.text.trim();
                if (postCode.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Enter your postcode')),
                  );
                  return;
                }
                vm.setLocation(postCode);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
