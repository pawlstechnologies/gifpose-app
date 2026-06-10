import 'package:flutter/material.dart';

class PremiumProCardGridview extends StatelessWidget {
    final VoidCallback? onTap;
  const PremiumProCardGridview({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 165,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF5CC),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFFD98C00),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Header
          Align(
            alignment: Alignment.bottomRight,
            child: const Icon(
              Icons.star,
              color: Color(0xFFF6D78C),
              size: 32,
            ),
          ),

           Text(
                "Go Pro",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF8A4300),
                ),
              ),

          const SizedBox(height: 5),

          /// Features
          _feature("Ad-Free Browsing"),
          const SizedBox(height: 5),

          _feature("Supporter Badge"),
          const SizedBox(height: 5),

          _feature("Premium Support"),

          const SizedBox(height: 20),

          /// Button
          SizedBox(
            width: double.infinity,
            height: 42,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE28600),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                "Get Premium",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _feature(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 7),
          child: CircleAvatar(
            radius: 2,
            backgroundColor: Color(0xFFE28600),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 15,
              color: Color(0xFFB56400),
              height: 1.3,
            ),
          ),
        ),
      ],
    );
  }
}