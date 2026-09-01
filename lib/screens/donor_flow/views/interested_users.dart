import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:giftpose/screens/donor_flow/widgets/donor_widgets.dart';
import 'package:giftpose/utils/router/app_routes.dart';
import 'package:giftpose/utils/theme/giftpose_colors.dart';
import 'package:giftpose/utils/theme/giftpose_text_style.dart';
import 'package:giftpose/utils/widgets/Giftpose_basescafold.dart';

class InterestedUsersScreen extends StatelessWidget {
  const InterestedUsersScreen({super.key});

  static const users = [
    (
      'Alex Johnson',
      'Brooklyn, NY',
      '2H AGO',
      'Hi! Is this still available? I can pick it up tomorrow afternoon if it is. Let...',
      'assets/images/donor/alex.png',
    ),
    (
      'Sarah Miller',
      'Manhattan, NY',
      '5H AGO',
      "I'm very interested in this item! Would you be open to a slight...",
      'assets/images/donor/sarah.png',
    ),
    (
      'David Chen',
      'Queens, NY',
      'YESTERDAY',
      'Hey there, just wondering about the dimensions. Does it fit in a...',
      'assets/images/donor/david.png',
    ),
    (
      'Elena Rodriguez',
      'Jersey City, NJ',
      'JAN 24',
      "Is the condition exactly as shown in the photos? I've been looking...",
      'assets/images/donor/elena.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return GiftPoseBaseScaffold(
      showAppBar: false,
      includeHorizontalPadding: false,
      includeVerticalPadding: false,
      hasGradient: false,
      builder: (_) => Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 25.w, 16.w, 11.w),
            child: const DonorHeader(title: 'Interested Users (12)'),
          ),
          const DonorItemSummary(image: 'assets/images/donor/black_jacket.png'),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.fromLTRB(5.w, 21.w, 20.w, 20.w),
              itemCount: users.length,
              separatorBuilder: (_, _) => SizedBox(height: 16.w),
              itemBuilder: (context, index) {
                final user = users[index];
                return InkWell(
                  onTap: () =>
                      Navigator.pushNamed(context, AppRoutes.donorChat),
                  child: Container(
                    height: 146.w,
                    padding: EdgeInsets.fromLTRB(19.w, 18.w, 16.w, 15.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24.r),
                      border: Border.all(color: const Color(0xFFE7EDF4)),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            ClipOval(
                              child: Image.asset(
                                user.$5,
                                width: 64.w,
                                height: 64.w,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              right: 1.w,
                              bottom: 1.w,
                              child: Container(
                                width: 12.w,
                                height: 12.w,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: const Color(0xFF00C950),
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 17.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      user.$1,
                                      style: GiftPoseTextStyle.normal(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                        color: const Color(0xFF27364B),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    user.$3,
                                    style: GiftPoseTextStyle.small(
                                      color: const Color(0xFF8CA0BE),
                                    ).copyWith(letterSpacing: 1),
                                  ),
                                ],
                              ),
                              SizedBox(height: 3.w),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on_outlined,
                                    size: 15,
                                    color: GiftPoseColors.primaryColor,
                                  ),
                                  SizedBox(width: 3.w),
                                  Text(
                                    user.$2,
                                    style: GiftPoseTextStyle.normal(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: const Color(0xFF57708D),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 6.w),
                              Text(
                                user.$4,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: GiftPoseTextStyle.normal(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xFF4B6380),
                                ).copyWith(height: 1.4),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
