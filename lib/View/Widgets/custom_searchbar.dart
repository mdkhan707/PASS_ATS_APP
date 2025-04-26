import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pass_ats/Controllers/search_controller.dart' as custom;

class CustomSearchbar extends StatefulWidget {
  const CustomSearchbar({super.key});

  @override
  State<CustomSearchbar> createState() => _CustomSearchbarState();
}

class _CustomSearchbarState extends State<CustomSearchbar> {
  final searchController = Get.put(custom.SearchController());
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
      title: TextField(
        controller: searchController.controller.value,
        focusNode: searchController.focusNode.value,
        autofocus: true,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: const BorderSide(color: Colors.cyan, width: 0),
          ),
          hintText: 'Search...',
          hintStyle: TextStyle(color: Colors.grey.shade600),
          suffixIcon: GestureDetector(
            onTap: () {
              searchController.toggleSearchBar();
            },
            child: const Icon(
              Icons.cancel_outlined,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
