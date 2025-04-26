import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PdfViewer extends StatelessWidget {
  final String pdfUrl;

  const PdfViewer({required this.pdfUrl, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Resume Template')),
      body: PDFView(
        filePath: pdfUrl, // PDF file URL from Cloudinary
        enableSwipe: true,
        swipeHorizontal: true,
        autoSpacing: true,
        pageFling: true,
        onPageChanged: (int? current, int? total) {},
      ),
    );
  }
}
