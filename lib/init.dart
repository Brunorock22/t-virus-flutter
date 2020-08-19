import 'package:flutter/widgets.dart';
import 'package:t_virus/core/database/dao/supplie_dao.dart';
import 'package:t_virus/core/database/dao/survivor_dao.dart';
import 'package:t_virus/core/model/supplie.dart';
import 'package:t_virus/core/model/survivor.dart';
import 'package:t_virus/core/util/global_user_acess.dart';

import 'ui/views/main_screen/main_navigator_bottom_controller.dart';
import 'ui/views/splash_screen.dart';
import 'ui/views/welcome_page.dart';

class InitialController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:
          Future.delayed(Duration(seconds: 1)).then((value) => loadConfig()),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            break;
          case ConnectionState.waiting:
            return SplashScreen();
            break;
          case ConnectionState.active:
            break;
          case ConnectionState.done:
            if (snapshot.data == null) return WelcomePage();
            if (snapshot.data == true)
              return MainNavigatorBottomController();
            else
              return WelcomePage();
            break;
        }
        return null;
      },
    );
  }

  Future<bool> loadConfig() async {
    Survivor survivor = await SurvivorDao.findLast().catchError((e) {
      print(e);
    });
    List<Supplie> supplies = await SupplieDao.findAll().catchError((e) {
      print(e);
    });

    if (survivor.autologin == null || survivor.autologin == 0) {
      return false;
    } else {

      GlobalUser.survivor = survivor;

      return true;
    }
  }
}
