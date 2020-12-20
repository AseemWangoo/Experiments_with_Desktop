import 'package:first_desktop_application/app-level/assets/assets.dart';
import 'package:first_desktop_application/app-level/constants/brand.links.dart';
import 'package:first_desktop_application/app-level/constants/strings.dart';
import 'package:first_desktop_application/app-level/styles/colors.dart';
import 'package:first_desktop_application/shared/extensions/textstyle_extension.dart';
import 'package:first_desktop_application/shared/services/linker_service.dart';

import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../locator.dart';
import 'image_loader.dart';

class TopNavBar extends StatefulWidget {
  const TopNavBar({
    Key key,
    @required this.controller,
  }) : super(key: key);

  final ScrollController controller;

  @override
  _TopNavBarState createState() => _TopNavBarState();
}

class _TopNavBarState extends State<TopNavBar> {
  static final _linkService = locator<LinkerService>();

  TextStyle get _whiteStyle =>
      Theme.of(context).textTheme.headline6.c(Colors.white);

  @override
  Widget build(BuildContext context) {
    //
    return Container(
      color: AppColors.navColor,
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              widget.controller.animateTo(
                0.0,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
            child: const ImageWidgetPlaceholder(image: WebAssets.logo),
          ),
          const Spacer(),
          Column(
            children: <Widget>[
              Text(AppLevelStrings.homeTitle, style: _whiteStyle),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  IconButton(
                    color: Colors.white,
                    icon: const FaIcon(FontAwesomeIcons.youtube),
                    iconSize: 20.0,
                    padding: EdgeInsets.zero,
                    onPressed: () => _linkService.openLink(BrandLinks.youtube),
                  ),
                  IconButton(
                    color: Colors.white,
                    iconSize: 20.0,
                    icon: const FaIcon(FontAwesomeIcons.medium),
                    padding: EdgeInsets.zero,
                    onPressed: () => _linkService.openLink(BrandLinks.medium),
                  ),
                  IconButton(
                    iconSize: 20.0,
                    color: Colors.white,
                    icon: const FaIcon(FontAwesomeIcons.chrome),
                    padding: EdgeInsets.zero,
                    onPressed: () => _linkService.openLink(BrandLinks.website),
                  ),
                  IconButton(
                    iconSize: 20.0,
                    color: Colors.white,
                    icon: const FaIcon(FontAwesomeIcons.dev),
                    padding: EdgeInsets.zero,
                    onPressed: () => _linkService.openLink(BrandLinks.devTo),
                  ),
                  IconButton(
                    iconSize: 20.0,
                    color: Colors.white,
                    icon: const FaIcon(FontAwesomeIcons.github),
                    padding: EdgeInsets.zero,
                    onPressed: () => _linkService.openLink(BrandLinks.github),
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              _linkService.openLink(BrandLinks.support);
            },
            child: Text(
              AppLevelStrings.supportTitle,
              style: _whiteStyle,
            ),
          ),
        ],
      ),
    );
  }
}
