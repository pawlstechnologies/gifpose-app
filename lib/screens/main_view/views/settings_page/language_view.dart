import 'package:flutter/material.dart';
import 'package:giftpose/utils/localization_provider.dart';

import 'package:flutter/services.dart';
import 'package:giftpose/gen/assets.gen.dart';
import 'package:giftpose/utils/theme/giftpose_colors.dart';
import 'package:giftpose/utils/theme/giftpose_text_style.dart';
import 'package:giftpose/utils/widgets/Giftpose_basescafold.dart';
import 'package:giftpose/utils/widgets/spacing.dart';
import 'package:giftpose/utils/widgets/giftpose_button.dart';
import 'package:provider/provider.dart';
import 'package:giftpose/utils/localization_provider.dart';

class LanguageView extends StatefulWidget {
  LanguageView({super.key});

  @override
  State<LanguageView> createState() => _LanguageViewState();
}

class _LanguageViewState extends State<LanguageView> {
  // Mock list of languages based on your image
  final List<String> languages = [
    "English",
    "French",
    "German",
    "Italian",
    "Chinese",
    "Portuguese",
    "Spanish",
  ];

  String? selectedLanguage;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        selectedLanguage = context.read<LanguageProvider>().currentLanguage;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GiftPoseBaseScaffold(
      showAppBar: true,
      centerTitle: true,
      includeHorizontalPadding: true,
      appBarTitleWidget: Text("Choose your Preferred Language".tr(context),
     style: GiftPoseTextStyle.normal(fontWeight: FontWeight.w500),
      ),
      appBarLeadingWidget:  InkWell(
            onTap: () {
             HapticFeedback.heavyImpact();
              Navigator.pop(context);
            },
            child: Container(
      width: 200,
  height: 100,
  decoration: BoxDecoration(

    borderRadius: BorderRadius.circular(20), // Adjust the value for more/less rounding
  ),
              child: Padding(
                padding: EdgeInsets.all(14.0),
                child: Assets.icons.back.svg(
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
            ),
          ),
      builder: (size) {
        return Column(
          children: [
            YMargin(20),
            
            // The Rounded White Container
            Expanded(
              child: Container(
               
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.withOpacity(0.1)),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: ListView.separated(
                    padding: EdgeInsets.zero,
                    itemCount: languages.length,
                    separatorBuilder: (context, index) => Divider(
                      height: 1,
                      color: Colors.grey.withOpacity(0.1),
                      indent: 15,
                      endIndent: 15,
                    ),
                    itemBuilder: (context, index) {
                      final lang = languages[index];
                      final isSelected = selectedLanguage == lang;

                      return ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        title: Text(
                          lang,
                          style: GiftPoseTextStyle.normal(
                            fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
                          ),
                        ),
                        trailing: Container(
                          height: 22,
                          width: 22,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isSelected ? GiftPoseColors.primaryColor : Colors.grey,
                              width: 2,
                            ),
                          ),
                          child: isSelected
                              ? Center(
                                  child: Container(
                                    height: 12,
                                    width: 12,
                                    decoration: BoxDecoration(
                                      color: GiftPoseColors.primaryColor,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                )
                              : null,
                        ),
                        onTap: () {
                          setState(() {
                            selectedLanguage = lang;
                          });
                        },
                      );
                    },
                  ),
                ),
              ),
            ),

            YMargin(30),

            // Submit Button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: GiftPoseButton(
                title: "Submit".tr(context),
                onTap: () {
                  if (selectedLanguage != null) {
                    context.read<LanguageProvider>().setLanguage(selectedLanguage!);
                  }
                  Navigator.pop(context);
                },
              ),
            ),
            
            YMargin(20),
          ],
        );
      },
    );
  }
}