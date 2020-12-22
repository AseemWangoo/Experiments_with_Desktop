import 'package:first_desktop_application/flipping/strings/strings.dart';
import 'package:first_desktop_application/inking/strings/strings.dart';
import 'package:first_desktop_application/liquid_cards/strings/strings.dart';
import 'package:first_desktop_application/routes/constants.dart';
import 'package:first_desktop_application/solarsystem/strings/strings.dart';

class BrandLinks {
  BrandLinks._();

  static const String website = 'https://flatteredwithflutter.com/';
  static const String youtube = 'https://www.youtube.com/aseemwangoo';
  static const String medium = 'https://medium.com/@aseemwangoo';
  static const String devTo = 'https://dev.to/aseemwangoo';
  static const String github = 'https://github.com/aseemwangoo';
  static const String codepen = 'https://codepen.io/aseemwangoo/pens/public';
  static const String support = 'https://support.flatteredwithflutter.com/';
}

class OptionAndRoutes {
  OptionAndRoutes._();

  /* MENU OPTIONS */
  static const String option1 = 'Theming';
  static const String option2 = 'Solar System';
  static const String option3 = 'Flipping';
  static const String option4 = 'Inking';
  static const String option5 = 'LiquidCards';

  static const Map<String, String> optionRoutes = {
    option1: AppRoutes.themingRoute,
    option2: AppRoutes.solarSystemRoute,
    option3: AppRoutes.flippingRoute,
    option4: AppRoutes.inkingRoute,
    option5: AppRoutes.liquidCardsRoute,
  };

  static const Map<String, List<String>> linksRoutes = {
    option1: <String>[
      BrandLinks.medium,
      BrandLinks.website,
      BrandLinks.youtube
    ],
    option2: <String>[
      ThreeDStrings.medium3D,
      ThreeDStrings.web3D,
      ThreeDStrings.yt3D,
    ],
    option3: <String>[
      FlippingStrings.mediumBPV,
      FlippingStrings.webBPV,
      FlippingStrings.ytBPV,
    ],
    option4: <String>[
      DarkModeStrings.mediumDMV,
      DarkModeStrings.webDMV,
      DarkModeStrings.ytDMV,
    ],
    option5: <String>[
      LCStrings.mediumLCV,
      LCStrings.webLCV,
      LCStrings.ytLCV,
    ],
  };
}
