import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pass_ats/View/Screens/my_resume_screen.dart';

class PdfPreviewScreen extends StatefulWidget {
  final Uint8List pdfData;
  const PdfPreviewScreen({required this.pdfData, Key? key}) : super(key: key);

  @override
  State<PdfPreviewScreen> createState() => _PdfPreviewScreenState();
}

class _PdfPreviewScreenState extends State<PdfPreviewScreen> {
  Future<bool> _requestStoragePermission() async {
    // Skip permission check for Android 10+ (API 29+) or iOS, as getApplicationDocumentsDirectory doesn't require it
    if (!Platform.isAndroid || await _isAndroid10OrHigher()) {
      return true;
    }

    try {
      var status = await Permission.storage.status;
      if (!status.isGranted) {
        status = await Permission.storage.request();
      }
      return status.isGranted;
    } catch (e) {
      print('Permission error: $e');
      return false;
    }
  }

  Future<bool> _isAndroid10OrHigher() async {
    // Android 10 is API 29
    // For simplicity, assume API 29+ doesn't need storage permission for app directory
    return true; // Modify based on actual Android version check if needed
  }

  Future<String?> _savePdfToLocal() async {
    if (!await _requestStoragePermission()) {
      Get.snackbar(
        'Permission Denied',
        'Storage permission is required to save the PDF.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin: EdgeInsets.all(16.w),
        duration: const Duration(seconds: 3),
        animationDuration: const Duration(milliseconds: 400),
        borderRadius: 12.r,
      );
      return null;
    }

    try {
      final directory = await getApplicationDocumentsDirectory();
      final fileName = 'Resume_${DateTime.now().millisecondsSinceEpoch}.pdf';
      final file = File('${directory.path}/$fileName');
      await file.writeAsBytes(widget.pdfData);

      Get.snackbar(
        'Success',
        'PDF saved successfully at $fileName',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        margin: EdgeInsets.all(16.w),
        duration: const Duration(seconds: 3),
        animationDuration: const Duration(milliseconds: 400),
        borderRadius: 12.r,
        mainButton: TextButton(
          onPressed: () {
            Get.to(() => const MyResumeScreen());
          },
          child: Text(
            'View',
            style: TextStyle(color: Colors.white, fontSize: 14.sp),
          ),
        ),
      );
      return file.path;
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to save PDF: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin: EdgeInsets.all(16.w),
        duration: const Duration(seconds: 3),
        borderRadius: 12.r,
      );
      return null;
    }
  }

  Future<void> _downloadPdf() async {
    final filePath = await _savePdfToLocal();
    if (filePath != null) {
      Get.snackbar(
        'Download Complete',
        'PDF downloaded successfully at $filePath',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        margin: EdgeInsets.all(16.w),
        duration: const Duration(seconds: 3),
        animationDuration: const Duration(milliseconds: 400),
        borderRadius: 12.r,
        mainButton: TextButton(
          onPressed: () {
            Get.to(() => const MyResumeScreen());
          },
          child: Text(
            'View',
            style: TextStyle(color: Colors.white, fontSize: 14.sp),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blueAccent, Colors.purpleAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 0,
        title: Text(
          'Generated Resume',
          style: TextStyle(
            fontSize: 22.sp,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 20.sp),
          onPressed: () => Get.back(),
        ),
        actions: [
          PopupMenuButton<String>(
            icon: Icon(
              Icons.more_vert,
              color: Colors.white,
              size: 28.sp,
            ),
            onSelected: (value) {
              if (value == 'save') {
                _savePdfToLocal();
              } else if (value == 'download') {
                _downloadPdf();
              } else if (value == 'view_saved') {
                Get.to(() => const MyResumeScreen());
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                value: 'save',
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/save.png',
                      width: 24.sp,
                      height: 24.sp,
                    ),
                    SizedBox(width: 10.w),
                    Text(
                      'Save',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: 'download',
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/download.png',
                      width: 24.sp,
                      height: 24.sp,
                    ),
                    SizedBox(width: 10.w),
                    Text(
                      'Download',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: 'view_saved',
                child: Row(
                  children: [
                    Icon(Icons.folder, color: Colors.amber, size: 24.sp),
                    SizedBox(width: 10.w),
                    Text(
                      'View Saved Resumes',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            color: Colors.white,
            elevation: 8,
          ),
          SizedBox(width: 10.w),
        ],
      ),
      body: SafeArea(
        child: SfPdfViewer.memory(
          widget.pdfData,
          enableDoubleTapZooming: true,
          canShowScrollHead: true,
          canShowScrollStatus: true,
        ),
      ),
    );
  }
}
