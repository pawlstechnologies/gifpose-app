import 'package:flutter/material.dart';
import 'package:giftpose/utils/theme/giftpose_colors.dart';
import 'package:giftpose/utils/theme/giftpose_text_style.dart';
import 'package:giftpose/utils/widgets/spacing.dart';

class GiftPoseFAQWidget extends StatelessWidget {
  GiftPoseFAQWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        FAQItem(
          question: "How much does shipping cost for gifts?",
          answer: "Standard shipping is free for all gifts over \$50. For smaller items, a flat fee of \$4.99 applies. Premium gift wrapping is available for an additional \$2.00.",
        ),
        FAQItem(
          question: "Can I track a gift order?",
          answer: "Yes, once your gift is shipped, you will receive a tracking number via email and in your 'My Orders' section.",
        ),
        FAQItem(
          question: "Do digital credits expire?",
          answer: "Digital credits are valid for 12 months from the date of issue.",
        ),
        FAQItem(
          question: "International gifting options",
          answer: "We currently ship to over 20 countries. International rates vary based on destination.",
        ),
           YMargin(99),
      ],
    );
  }
}

class FAQItem extends StatelessWidget {
  final String question;
  final String answer;

  FAQItem({
    super.key,
    required this.question,
    required this.answer,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      // This removes the default border lines that ExpansionTile adds when expanded
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: Column(
        children: [
          ExpansionTile(
            tilePadding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            title: Text(
              question,
              style: GiftPoseTextStyle.normal(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Theme.of(context).textTheme.bodyLarge?.color, // Or your primary text color
              ),
            ),
            trailing: Icon(
              Icons.keyboard_arrow_down_rounded,
              color: GiftPoseColors.textColor2.withOpacity(0.5),
            ),
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: Text(
                  answer,
                  textAlign: TextAlign.justify,
                  style: GiftPoseTextStyle.small(
                    fontSize: 12,
                    color: GiftPoseColors.textColor2, // Subtle grey color
                  
                  ),
                ),
              ),
            ],
          ),
          // Subtle Divider to match your image
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Divider(height: 1, thickness: 0.5),
          ),
          
        ],
      ),
    );
  }
}