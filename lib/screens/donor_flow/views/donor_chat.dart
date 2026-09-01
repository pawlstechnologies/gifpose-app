import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:giftpose/screens/donor_flow/widgets/donor_widgets.dart';
import 'package:giftpose/utils/theme/giftpose_text_style.dart';
import 'package:giftpose/utils/widgets/Giftpose_basescafold.dart';

class DonorChatScreen extends StatelessWidget {
  const DonorChatScreen({super.key});

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
            padding: EdgeInsets.fromLTRB(16.w, 22.w, 16.w, 22.w),
            child: Row(
              children: [
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.chevron_left, size: 28),
                ),
                SizedBox(width: 12.w),
                ClipOval(
                  child: Image.asset(
                    'assets/images/donor/alex.png',
                    width: 40.w,
                    height: 40.w,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 12.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'John Donor',
                      style: GiftPoseTextStyle.normal(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF27364B),
                      ),
                    ),
                    Text(
                      'Active now',
                      style: GiftPoseTextStyle.small(
                        color: const Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const DonorItemSummary(image: 'assets/images/donor/black_jacket.png'),
          SizedBox(height: 20.w),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.w),
            decoration: BoxDecoration(
              color: const Color(0xFFE5E7EB),
              borderRadius: BorderRadius.circular(15.r),
            ),
            child: Text(
              'Today',
              style: GiftPoseTextStyle.small(color: const Color(0xFF64748B)),
            ),
          ),
          SizedBox(height: 17.w),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(right: 25.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _bubble(
                    context,
                    "Hi! I saw you're offering a winter jacket. Is it still available?",
                    true,
                  ),
                  SizedBox(height: 4.w),
                  Text(
                    '10:30 AM',
                    style: GiftPoseTextStyle.small(
                      color: const Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20.w),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 22.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _bubble(
                    context,
                    "Yes, it's still available! It's in great condition, barely worn.",
                    false,
                  ),
                  SizedBox(height: 4.w),
                  Text(
                    '10:32 AM',
                    style: GiftPoseTextStyle.small(
                      color: const Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          Container(
            height: 65.w,
            padding: EdgeInsets.fromLTRB(22.w, 12.w, 15.w, 12.w),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: Color(0xFFE2E8F0))),
            ),
            child: Row(
              children: [
                const Icon(Icons.attach_file, color: Color(0xFF64748B)),
                SizedBox(width: 16.w),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      suffixIcon: const Icon(
                        Icons.sentiment_satisfied_alt,
                        color: Color(0xFF64748B),
                      ),
                      filled: true,
                      fillColor: const Color(0xFFF3F4F6),
                      contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(22.r),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                CircleAvatar(
                  radius: 20.r,
                  backgroundColor: const Color(0xFF68DDA4),
                  child: const Icon(Icons.send_outlined, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _bubble(BuildContext context, String text, bool sent) {
    return Container(
      width: 280.w,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.w),
      decoration: BoxDecoration(
        color: sent ? const Color(0xFF00C950) : const Color(0xFFE5E7EB),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Text(
        text,
        style: GiftPoseTextStyle.normal(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: sent ? Colors.white : const Color(0xFF0F172A),
        ).copyWith(height: 1.4),
      ),
    );
  }
}
