import 'package:flutter/material.dart';


class QostSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const QostSwitch({super.key, required this.value, required this.onChanged});

  @override
  _QostSwitchState createState() => _QostSwitchState();
}

class _QostSwitchState extends State<QostSwitch> with SingleTickerProviderStateMixin {
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
            width: 58.0,
            height: 30.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24.0), color:  widget.value ?  Theme.of(context).scaffoldBackgroundColor : Colors.transparent,
              border: Border.all(color: widget.value ? Theme.of(context).primaryColor :  Theme.of(context).dividerColor, width: 1),
            ),
            child: Container(
              alignment:
              widget.value ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                width: 27.0,
                height: 27.0,
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