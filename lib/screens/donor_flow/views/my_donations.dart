import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:giftpose/screens/donor_flow/widgets/donor_widgets.dart';
import 'package:giftpose/utils/router/app_routes.dart';
import 'package:giftpose/utils/theme/giftpose_text_style.dart';
import 'package:giftpose/utils/widgets/Giftpose_basescafold.dart';

class MyDonationsScreen extends StatelessWidget {
  const MyDonationsScreen({super.key});

  static const items = [
    ('Green Sofa', 'assets/images/donor/sofa.png', true),
    ('Neatly Used Shoes', 'assets/images/donor/shoes.png', true),
    ('Neatly Used Shoes', 'assets/images/donor/bottle.png', false),
    ('Neatly Used Shoes', 'assets/images/donor/jacket.png', false),
    ('Neatly Used Shoes', 'assets/images/donor/clothes.png', true),
  ];

  @override
  Widget build(BuildContext context) {
    return GiftPoseBaseScaffold(
      showAppBar: false,
      includeHorizontalPadding: false,
      includeVerticalPadding: false,
      hasGradient: false,
      builder: (_) => Padding(
        padding: EdgeInsets.fromLTRB(16.w, 29.w, 16.w, 20.w),
        child: Column(
          children: [
            const DonorHeader(title: 'My Donations'),
            SizedBox(height: 38.w),
            Row(
              children: const [
                _StatusTab('All', selected: true),
                _StatusTab('Active'),
                _StatusTab('Completed'),
              ],
            ),
            SizedBox(height: 32.w),
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.zero,
                itemCount: items.length,
                separatorBuilder: (_, _) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final item = items[index];
                  return InkWell(
                    onTap: () => Navigator.pushNamed(
                      context,
                      AppRoutes.donorItemDetails,
                    ),
                    child: SizedBox(
                      height: 110.w,
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.r),
                            child: Image.asset(
                              item.$2,
                              width: 76.w,
                              height: 80.w,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.$1,
                                  style: GiftPoseTextStyle.normal(fontSize: 14),
                                ),
                                SizedBox(height: 8.w),
                                const DonorLocationRow(),
                                SizedBox(height: 7.w),
                                Container(
                                  height: 24.w,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 11.w,
                                  ),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: item.$3
                                        ? const Color(0xFFEEFFF3)
                                        : const Color(0xFFF3F4F6),
                                    borderRadius: BorderRadius.circular(14.r),
                                  ),
                                  child: Text(
                                    item.$3 ? 'Active' : 'Completed',
                                    style: GiftPoseTextStyle.small(
                                      color: item.$3
                                          ? const Color(0xFF17A64A)
                                          : const Color(0xFF667085),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (item.$3) ...[
                            const Icon(
                              Icons.edit_outlined,
                              size: 20,
                              color: Color(0xFF475569),
                            ),
                            SizedBox(width: 18.w),
                            const Icon(
                              Icons.delete_outline,
                              size: 20,
                              color: Color(0xFF475569),
                            ),
                          ],
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusTab extends StatelessWidget {
  const _StatusTab(this.label, {this.selected = false});
  final String label;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36.w,
      margin: EdgeInsets.only(right: 8.w),
      padding: EdgeInsets.symmetric(horizontal: 22.w),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: selected ? const Color(0xFF101828) : const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(22.r),
      ),
      child: Text(
        label,
        style: GiftPoseTextStyle.normal(
          fontSize: 14,
          color: selected ? Colors.white : const Color(0xFF475467),
        ),
      ),
    );
  }
}
