import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GiftPoseOtpField extends StatelessWidget {
  final int length;
  final String value;
  final ValueChanged<String>? onChanged;
  final Color backgroundColor;
  final Color? dotColor;
  final Color? emptyDotColor;

  const GiftPoseOtpField({
    Key? key,
    this.length = 6,
    required this.value,
    this.onChanged,
    this.backgroundColor = const Color(0xFF6E6E8E), // Example: purple/grey
    this.dotColor = const Color(0xFFD1D3DB), // Example: light grey
    this.emptyDotColor = const Color(0xFFD1D3DB),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color:     Theme.of(context).primaryColor,)
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(length, (index) {
          bool filled = index < value.length;
          return Container(
            width: 12.w,
            height: 12.w,
            decoration: BoxDecoration(
              color: filled ? dotColor : emptyDotColor?.withOpacity(0.5),
              shape: BoxShape.circle,
            ),
          );
        }),
      ),
    );
  }
}
class GiftPoseOtpInputField extends StatefulWidget {
  final int length;
  final Color backgroundColor;
  final Color? dotColor;
  final Color? emptyDotColor;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;

  const GiftPoseOtpInputField({
    Key? key,
    this.length = 6,
    this.backgroundColor = const Color(0xFF6E6E8E),
    this.dotColor = const Color(0xFFD1D3DB),
    this.emptyDotColor = const Color(0xFFD1D3DB),
    this.controller,
    this.onChanged,
  }) : super(key: key);

  @override
  State<GiftPoseOtpInputField> createState() => _GiftPoseOtpInputFieldState();
}

class _GiftPoseOtpInputFieldState extends State<GiftPoseOtpInputField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Stack(
        alignment: Alignment.center,
        children: [
          GiftPoseOtpField(
            length: widget.length,
            value: _controller.text,
            backgroundColor: widget.backgroundColor,
            dotColor: Theme.of(context).textTheme.bodyLarge?.color,
            emptyDotColor: Theme.of(context).textTheme.bodyMedium?.color,
          ),
          Opacity(
            opacity: 0.0,
            child: TextField(
              controller: _controller,
              maxLength: widget.length,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {});
                widget.onChanged?.call(value);
              },
              autofocus: false,
            ),
          ),
        ],
      ),
    );
  }
}