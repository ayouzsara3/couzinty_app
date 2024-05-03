import 'package:couzinty/core/utils/constants.dart';
import 'package:couzinty/features/navigation/presentation/views/widgets/animated_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';

class NavbarItem extends StatefulWidget {
  final int index;
  final String iconPath;
  final int currentTab;
  final Function(int) onTap;

  const NavbarItem({
    super.key,
    required this.index,
    required this.iconPath,
    required this.currentTab,
    required this.onTap,
  });

  @override
  State<NavbarItem> createState() => _NavbarItemState();
}

class _NavbarItemState extends State<NavbarItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        widget.index != 2
            ? AnimatedBar(isActive: widget.currentTab == widget.index)
            : const SizedBox(),
        widget.index == 2
            ? Container(
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: kMainGreen),
                child: MaterialButton(
                  minWidth: 40,
                  onPressed: () {
                    widget.onTap(widget.index);
                  },
                  // to remove the splash and the highlight color when we press the button
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SvgPicture.asset(
                        widget.iconPath,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              )
            : MaterialButton(
                minWidth: 40,
                onPressed: () {
                  widget.onTap(widget.index);
                },
                // to remove the splash and the highlight color when we press the button
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SvgPicture.asset(
                      widget.iconPath,
                      color: widget.currentTab == widget.index
                          ? kMainGreen
                          : kLightBlue,
                    )
                  ],
                ),
              ),
      ],
    );
  }
}
