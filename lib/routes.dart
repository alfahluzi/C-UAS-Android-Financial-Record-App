import 'package:flutter/material.dart';
import 'utils/utils.dart';
import 'modules/modules.dart';

///
/// Created by alfahluzi on 20/12/2022.
///

class Routes {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      /// ROOT
      case RouteNames.HOME:
        return _buildRoute(settings, (context) => HomePage.page(context));

      default:
        return null;
    }
  }

  static _buildRoute(RouteSettings settings,
          Widget Function(BuildContext context) builder) =>
      MaterialPageRoute(settings: settings, builder: builder);
}
