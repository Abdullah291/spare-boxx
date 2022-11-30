import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sparebboxx/utils/theme_mode.dart';
import 'package:sparebboxx/view/add_new_listing/add_new_listing_screen.dart';
import 'bottom_nav_bar_controller.dart';

class BottomNavBarScreen extends StatelessWidget {
  const BottomNavBarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GetBuilder<BottomNavBarController>(
        init: BottomNavBarController(),
        builder: (controller) {
          return controller.li[controller.currentIndex];
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: GetBuilder<BottomNavBarController>(
          init: BottomNavBarController(),
          builder: (controller) {
            return FloatingActionButton(
              onPressed: () {
                Get.to(AddNewListingScreen());
              },
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Theme.of(context).primaryColor,
              child: Icon(
                Icons.add_circle_outline_sharp,
                color: ThemeService().theme == ThemeMode.dark
                    ? Theme.of(context).canvasColor
                    : Colors.black,
                size: 25,
              ),
            );
          }),
      bottomNavigationBar: GetBuilder<BottomNavBarController>(
          init: BottomNavBarController(),
          builder: (controller) {
            return BottomAppBar(
              notchMargin: 10,
              shape: const CircularNotchedRectangle(),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        controller.selected(0);
                      },
                      icon: Icon(
                        Icons.home_rounded,
                        color: controller.currentIndex == 0
                            ? Theme.of(context).primaryColor
                            : Theme.of(context).canvasColor,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        controller.selected(1);
                      },
                      icon: Icon(
                        Icons.search_rounded,
                        color: controller.currentIndex == 1
                            ? Theme.of(context).primaryColor
                            : Theme.of(context).canvasColor,
                      ),
                    ),
                    const IconButton(
                      onPressed: null,
                      icon: Icon(
                        Icons.more,
                        color: Colors.transparent,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        controller.selected(3);
                      },
                      icon: Icon(
                        Icons.chat,
                        color: controller.currentIndex == 3
                            ? Theme.of(context).primaryColor
                            : Theme.of(context).canvasColor,
                      ),
                      tooltip: 'Listings',
                    ),
                    IconButton(
                      onPressed: () {
                        controller.selected(4);
                      },
                      icon: Icon(
                        Icons.person_rounded,
                        color: controller.currentIndex == 4
                            ? Theme.of(context).primaryColor
                            : Theme.of(context).canvasColor,
                      ),
                      tooltip: 'Profile',
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
