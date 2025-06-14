import 'package:flutter/material.dart';
import 'package:pass_ats/View/Screens/sections_screen.dart';
import 'package:pass_ats/View/Widgets/custom_round_button.dart';
import 'package:pass_ats/constants/colors.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:get/get.dart';

class TemplatePreviewScreen extends StatelessWidget {
  final String templateId;
  final String templateUrl;
  final String templateName;

  const TemplatePreviewScreen({
    super.key,
    required this.templateId,
    required this.templateUrl,
    required this.templateName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Text(
          templateName,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        // backgroundColor: Colors.lightBlue,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.only(top: 12, bottom: 80),
              child: SfPdfViewer.network(
                templateUrl,
                canShowScrollHead: true,
                canShowScrollStatus: true,
                enableDoubleTapZooming: true,
                onDocumentLoadFailed: (details) {
                  Get.snackbar("Error", "Failed to load the PDF template");
                },
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: RoundButton(
                title: 'Use this Template',
                onTap: () {
                  print('This is the template id:$templateId');
                  Get.to(() => SectionScreen(
                        templateId: templateId,
                      ));
                },
                color: ColorConstants().buttonColor,
                isloading: false,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
