import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pass_ats/Controllers/resume_controller1.dart';
import 'package:pass_ats/View/Screens/template_screen.dart';
import 'package:pass_ats/View/Widgets/custom_appbar.dart';
import 'package:pass_ats/View/Widgets/custom_drawer.dart';
import 'package:pass_ats/Controllers/search_controller.dart' as custom;
import 'package:pass_ats/View/Widgets/custom_searchbar.dart';
import 'package:pass_ats/View/Widgets/gradient_scaffold.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final searchController = Get.put(
    custom.SearchController(),
    permanent: true,
  );
  final resumetemplatecontroller = Get.put(ResumeController());

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: Obx(
          () => AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: searchController.isSearchBarVisible.value
                ? const CustomSearchbar()
                : const CustomAppbar(),
          ),
        ),
      ),
      drawer: Custom_Drawer(),
      body: Obx(() {
        if (resumetemplatecontroller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top left title
              Text(
                'RESUME TEMPLATES',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 16.h),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 250,
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 10.0,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: resumetemplatecontroller.resumeList.length > 6
                      ? 6
                      : resumetemplatecontroller.resumeList.length,
                  itemBuilder: (context, index) {
                    final template = resumetemplatecontroller.resumeList[index];
                    return GestureDetector(
                      onTap: () {
                        Get.to(() => TemplatePreviewScreen(
                              templateId: template.id,
                              templateUrl: resumetemplatecontroller
                                  .getFullPdfUrl(template.pdfUrl),
                              templateName: template.name,
                            ));
                      },
                      child: Column(
                        children: [
                          Expanded(
                            child: Card(
                              elevation: 5.h,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(2.0),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(2.0),
                                child: Image.network(
                                  resumetemplatecontroller
                                      .getFullImageUrl(template.pngUrl),
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Center(
                                        child: Icon(Icons.broken_image));
                                  },
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 6.h),
                          Text(
                            template.name,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
