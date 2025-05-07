import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pass_ats/View/Widgets/gradient_scaffold.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

class MyResumeScreen extends StatefulWidget {
  const MyResumeScreen({super.key});

  @override
  State<MyResumeScreen> createState() => _MyResumeScreenState();
}

class _MyResumeScreenState extends State<MyResumeScreen> {
  List<File> savedResumes = [];

  @override
  void initState() {
    super.initState();
    _loadSavedResumes();
  }

  Future<void> _loadSavedResumes() async {
    final directory = await getApplicationDocumentsDirectory();
    final files = directory
        .listSync()
        .where((file) => file.path.endsWith('.pdf'))
        .map((file) => File(file.path))
        .toList();
    setState(() {
      savedResumes = files;
    });
  }

  Future<void> _deleteResume(File resume) async {
    try {
      await resume.delete();
      await _loadSavedResumes();
      Get.snackbar(
        'Success',
        'PDF deleted successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        margin: EdgeInsets.all(16.w),
        duration: const Duration(seconds: 3),
        animationDuration: const Duration(milliseconds: 400),
        borderRadius: 12.r,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to delete PDF: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin: EdgeInsets.all(16.w),
        duration: const Duration(seconds: 3),
        borderRadius: 12.r,
      );
    }
  }

  Future<void> _renameResume(File resume) async {
    final TextEditingController controller = TextEditingController(
      text: resume.path.split('/').last.replaceAll('.pdf', ''),
    );

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        title: Text(
          'Rename PDF',
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: 'Enter new name',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(fontSize: 14.sp, color: Colors.grey),
            ),
          ),
          TextButton(
            onPressed: () async {
              final newName = controller.text.trim();
              if (newName.isEmpty || !newName.endsWith('.pdf')) {
                Get.snackbar(
                  'Error',
                  'Please enter a valid name ending with .pdf',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.red,
                  colorText: Colors.white,
                  margin: EdgeInsets.all(16.w),
                  duration: const Duration(seconds: 3),
                  borderRadius: 12.r,
                );
                return;
              }

              try {
                final directory = await getApplicationDocumentsDirectory();
                final newPath = '${directory.path}/$newName';
                await resume.rename(newPath);
                await _loadSavedResumes();
                Navigator.pop(context);
                Get.snackbar(
                  'Success',
                  'PDF renamed to $newName',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.green,
                  colorText: Colors.white,
                  margin: EdgeInsets.all(16.w),
                  duration: const Duration(seconds: 3),
                  borderRadius: 12.r,
                );
              } catch (e) {
                Get.snackbar(
                  'Error',
                  'Failed to rename PDF: $e',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.red,
                  colorText: Colors.white,
                  margin: EdgeInsets.all(16.w),
                  duration: const Duration(seconds: 3),
                  borderRadius: 12.r,
                );
              }
            },
            child: Text(
              'Rename',
              style: TextStyle(fontSize: 14.sp, color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 28.sp),
          onPressed: () => Get.back(),
        ),
        // automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'My Resume Screen',
          style: TextStyle(
            fontSize: 22.sp,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'MY SAVED RESUMES',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontStyle: FontStyle.italic,
              ),
            ),
            SizedBox(height: 10.h),
            Expanded(
              child: savedResumes.isEmpty
                  ? _buildEmptyState()
                  : _buildResumeList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/folder.png',
            height: 80.h,
            width: 80.w,
          ),
          SizedBox(height: 16.h),
          Text(
            'No resumes saved yet...',
            style: TextStyle(
                fontSize: 16.sp,
                fontStyle: FontStyle.italic,
                color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildResumeList() {
    return ListView.builder(
      itemCount: savedResumes.length,
      itemBuilder: (context, index) {
        final resume = savedResumes[index];
        return ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          leading: Image.asset(
            'assets/images/pdf.png',
            height: 40.h,
            width: 40.w,
          ),
          trailing: PopupMenuButton<String>(
            icon: Icon(
              Icons.more_vert,
              size: 20.sp,
              color: Colors.white70,
            ),
            onSelected: (value) {
              if (value == 'delete') {
                _deleteResume(resume);
              } else if (value == 'rename') {
                _renameResume(resume);
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem<String>(
                value: 'delete',
                child: Row(
                  children: [
                    Icon(Icons.delete, color: Colors.red, size: 20.sp),
                    SizedBox(width: 8.w),
                    Text(
                      'Delete',
                      style: TextStyle(fontSize: 14.sp, color: Colors.black87),
                    ),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: 'rename',
                child: Row(
                  children: [
                    Icon(Icons.edit, color: Colors.blue, size: 20.sp),
                    SizedBox(width: 8.w),
                    Text(
                      'Rename',
                      style: TextStyle(fontSize: 14.sp, color: Colors.black87),
                    ),
                  ],
                ),
              ),
            ],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
            color: Colors.white,
            elevation: 4,
          ),
          title: Text(
            resume.path.split('/').last,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          subtitle: Text(
            'Saved on ${_formatDate(File(resume.path).lastModifiedSync())}',
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.white70,
            ),
          ),
          onTap: () async {
            final result = await OpenFile.open(resume.path);
            if (result.type != ResultType.done) {
              Get.snackbar(
                'Error',
                'Failed to open PDF: ${result.message}',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.red,
                colorText: Colors.white,
                margin: EdgeInsets.all(16.w),
                duration: const Duration(seconds: 3),
                borderRadius: 12.r,
              );
            }
          },
        );
      },
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
