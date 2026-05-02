import 'package:flutter/material.dart';
import 'package:giftpose/utils/theme/giftpose_colors.dart';
import 'package:giftpose/utils/theme/giftpose_text_style.dart';
import 'package:giftpose/utils/widgets/spacing.dart';
import 'package:giftpose/utils/localization_provider.dart';

class GiftPoseFAQWidget extends StatelessWidget {
  GiftPoseFAQWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        FAQItem(
          question: "How can I contact the person offering a gift?",
          answer:
              "To connect with the giver, open the listing you’re interested in, scroll down past any ads at the bottom, and tap the green “Ask for Gift item” (or equivalent) button. This will take you straight to the original site where the gift was posted so you can message the person directly.",
        ),
        FAQItem(
          question: "Why am I seeing paid items or services in my feed?",
          answer:
              "Some sellers occasionally list items for sale or paid services in the free giveaway sections of the platforms we scan. That’s why they sometimes appear. If you spot anything that doesn’t belong in GiftPose, just tap the “Report listing” button at the bottom of that post.",
        ),
        FAQItem(
          question: "How do I cut down on too many notifications?",
          answer:
              'Add specific keywords on your Notifications Alert settings page so you only receive alerts that match, or are related to the terms of your keyword.Go to Settings (top-left icon) → Notifications Alert Settings Type Keyword into text field at the top of the page and select from drop-down OR simply search through the items under each Category and select a Keyword.You can also shrink the search radius in the settings under "How far are you willing to go?" to get fewer, more relevant alerts.',
        ),
        FAQItem(
          question: "Why is there hardly any content showing up?",
          answer:
              "You may be in an area with fewer shared gifts right now. Try entering a postal code for a nearby spot you’d be willing to travel to. You can also expand your range by going to Settings (top-left icon) and sliding the Max Distance up to 50 miles.",
        ),
        FAQItem(
          question: "How do I share my own gift?",
          answer:
              "[This feature is currently in development and will be available soon.]",
        ),
        FAQItem(
          question: "How do I update my email address?",
          answer: "You can change your email by tapping on [this link]",
        ),
        FAQItem(
          question: "How do I remove a word from my selected keywords?",
          answer:
              "In the Gift Notification screen, simply click on the “x” button to the right of each keyword you have selected—tap it to remove the word. Then rewrite the new keyword you'd like to be notified of",
        ),
        FAQItem(
          question:
              "If a gift was posted on a partner platform (e.g Trashnothing), do I need a Trashnothing account?",
          answer: """- Never send money to anyone before meeting them in person. 
- Skip any offers that require shipping—only deal with local people you can meet face-to-face.
- Never wire money (Western Union, etc.)—this is a classic scam red flag.
- Never share financial details such as bank account numbers, Social Security info, PayPal credentials, or similar.""",
        ),
        FAQItem(
          question:
              "The app won’t load—I only see a white screen with the GiftPose logo.",
          answer:
              "First, check that your internet connection is working. If it is, your phone may be low on storage space—try deleting some unused apps, photos, or files to free up room.",
        ),
        YMargin(99),
      ],
    );
  }
}

class FAQItem extends StatelessWidget {
  final String question;
  final String answer;

  FAQItem({super.key, required this.question, required this.answer});

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
              question.tr(context),
              style: GiftPoseTextStyle.normal(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Theme.of(
                  context,
                ).textTheme.bodyLarge?.color, // Or your primary text color
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
                  answer.tr(context),
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
