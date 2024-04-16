import 'package:education_app/core/extensions/context_extensions.dart';
import 'package:education_app/core/res/colors.dart';
import 'package:education_app/src/authentication/data/models/user_model.dart';
import 'package:education_app/src/dashboard/presentation/providers/dashboard_controller.dart';
import 'package:education_app/src/dashboard/utils/dashboard_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  static const routeName = '/dashboard';

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<LocalUserModel>(
      stream: DashboardUtils.userDataStream,
      builder: (_, snapshot) {
        if (snapshot.hasData && snapshot.data is LocalUserModel) {
          context.userProvider.user = snapshot.data;
        }
        return Consumer<DashboardController>(
          builder: (_, controller, __) {
            return Scaffold(
              body: IndexedStack(
                index: controller.currentIndex,
                children: controller.screens,
              ),
              bottomNavigationBar: BottomNavigationBar(
                showSelectedLabels: false,
                currentIndex: controller.currentIndex,
                elevation: 0,
                backgroundColor: Colors.white,
                selectedItemColor: Colors.grey,
                unselectedItemColor: XColors.primaryColor,
                onTap: controller.changeIndex,
                items: [
                  BottomNavigationBarItem(
                    label: 'Home',
                    backgroundColor: Colors.white,
                    icon: Icon(
                      controller.currentIndex == 0
                          ? IconlyBold.home
                          : IconlyLight.home,
                      color: controller.currentIndex == 0
                          ? XColors.primaryColor
                          : Colors.grey,
                    ),
                  ),
                  BottomNavigationBarItem(
                    label: 'Materials',
                    backgroundColor: Colors.white,
                    icon: Icon(
                      controller.currentIndex == 1
                          ? IconlyBold.document
                          : IconlyLight.document,
                      color: controller.currentIndex == 1
                          ? XColors.primaryColor
                          : Colors.grey,
                    ),
                  ),
                  BottomNavigationBarItem(
                    label: 'More',
                    backgroundColor: Colors.white,
                    icon: Icon(
                      controller.currentIndex == 2
                          ? IconlyBold.plus
                          : IconlyLight.plus,
                      color: controller.currentIndex == 2
                          ? XColors.primaryColor
                          : Colors.grey,
                    ),
                  ),
                  BottomNavigationBarItem(
                    label: 'Chat',
                    backgroundColor: Colors.white,
                    icon: Icon(
                      controller.currentIndex == 3
                          ? IconlyBold.chat
                          : IconlyLight.chat,
                      color: controller.currentIndex == 3
                          ? XColors.primaryColor
                          : Colors.grey,
                    ),
                  ),
                  BottomNavigationBarItem(
                    label: 'Profile',
                    backgroundColor: Colors.white,
                    icon: Icon(
                      controller.currentIndex == 4
                          ? IconlyBold.profile
                          : IconlyLight.profile,
                      color: controller.currentIndex == 4
                          ? XColors.primaryColor
                          : Colors.grey,
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
