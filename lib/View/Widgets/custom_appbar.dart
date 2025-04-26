import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pass_ats/Controllers/search_controller.dart' as custom;

class CustomAppbar extends StatefulWidget {
  const CustomAppbar({super.key});

  @override
  State<CustomAppbar> createState() => _CustomAppbarState();
}

class _CustomAppbarState extends State<CustomAppbar> {
  final searchController = Get.put(custom.SearchController());
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      // backgroundColor: Colors.white.withOpacity(0.7),
      centerTitle: true,
      automaticallyImplyLeading: false,
      title: Image.asset(
        'assets/images/app_logo.png',
        height: 120.h,
      ),
      leading: Builder(
        builder: (context) {
          return GestureDetector(
            onTap: () {
              Scaffold.of(context).openDrawer();
            },
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Image.asset(
                'assets/images/drawer.png', // Replace with your custom image
                height: 10.h,
                width: 10.w,
              ),
            ),
          );
        },
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: GestureDetector(
            onTap: () {
              searchController.toggleSearchBar();
            },
            child: Image.asset(
              'assets/images/search.png', // Replace with your custom image
            ),
          ),
        ),
      ],
    );
  }
}
