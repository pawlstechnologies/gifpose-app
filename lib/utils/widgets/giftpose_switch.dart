import 'package:flutter/material.dart';


class GiftPoseSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const GiftPoseSwitch({super.key, required this.value, required this.onChanged});

  @override
  _GiftPoseSwitchState createState() => _GiftPoseSwitchState();
}

class _GiftPoseSwitchState extends State<GiftPoseSwitch> with SingleTickerProviderStateMixin {
  AnimationController? _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 30));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder( 
      animation: _animationController!,
      builder: (context, child) {
        return GestureDetector(
          onTap: () {
              setState(() {
                                      
                                    });
            if (_animationController!.isCompleted) {
              _animationController!.reverse();
            } else {
              _animationController!.forward();
            }
            widget.value == false ? widget.onChanged(true) : widget.onChanged(false);
          },
          child: Container(
               padding: EdgeInsets.symmetric(horizontal: 5),
            width: 44.0,
            height: 24.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24.0), color:  widget.value ?  Theme.of(context).scaffoldBackgroundColor : Colors.transparent,
              border: Border.all(color: widget.value ? Theme.of(context).primaryColor :  Theme.of(context).dividerColor, width: 1),
            ),
            child: Container(
              alignment:
              widget.value ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
             
                width: 16.0,
                height: 16.0,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: widget.value ?Theme.of(context).primaryColor:
              Theme.of(context).dividerColor, border: Border.all(color: widget.value ?  Theme.of(context).primaryColor :  Theme.of(context).dividerColor, )),
              ),
            ),
            // ),
          ),
        );
      },
    );
  }
}