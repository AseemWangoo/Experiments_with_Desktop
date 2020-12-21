import 'package:first_desktop_application/routes/constants.dart';

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
      BrandLinks.medium,
      BrandLinks.website,
      BrandLinks.youtube
    ],
    option3: <String>[
      BrandLinks.medium,
      BrandLinks.website,
      BrandLinks.youtube
    ],
    option4: <String>[
      BrandLinks.medium,
      BrandLinks.website,
      BrandLinks.youtube
    ],
    option5: <String>[
      BrandLinks.medium,
      BrandLinks.website,
      BrandLinks.youtube
    ],
  };
}
