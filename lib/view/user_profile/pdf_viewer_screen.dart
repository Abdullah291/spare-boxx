import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sparebboxx/utils/assets.dart';
import 'package:sparebboxx/utils/constant.dart';
import 'package:velocity_x/velocity_x.dart';

class PDFViewerPage extends StatefulWidget {
  final File? file;

  const PDFViewerPage({
    Key? key,
    @required this.file,
  }) : super(key: key);

  @override
  _PDFViewerPageState createState() => _PDFViewerPageState();
}

class _PDFViewerPageState extends State<PDFViewerPage> {
  PDFViewController? controller;
  int pages = 0;
  int indexPage = 0;

  @override
  Widget build(BuildContext context) {
    final name = basename(widget.file?.path ?? "");
    final text = '${indexPage + 1} of $pages';

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(backIcon, width: 30, color: kPrimary,),
            ],
          ),
        ),
        title: "Privacy Policy".text.headline1(context).size(16).make(),
        actions: pages >= 2
            ? [
          Center(child: text.text.headline2(context).make()),
          IconButton(
            icon: const Icon(Icons.chevron_left, size: 32 ,color: kPrimary,),
            onPressed: () {
              final page = indexPage == 0 ? pages : indexPage - 1;
              controller?.setPage(page);
            },
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right, size: 32,color: kPrimary,),
            onPressed: () {
              final page = indexPage == pages - 1 ? 0 : indexPage + 1;
              controller?.setPage(page);
            },
          ),
        ]
            : null,
      ),
      body: PDFView(
        filePath: widget.file?.path,
        autoSpacing: false,
        // swipeHorizontal: true,
        // pageSnap: false,
        pageFling: true,
        fitEachPage: true,

        onError: (error){
          error.toString().text.make();
        },
        onRender: (pages) => setState(() => this.pages = pages ?? 0),
        onViewCreated: (controller) =>
            setState(() => this.controller = controller),
        onPageChanged: (indexPage, _) =>
            setState(() => this.indexPage = indexPage ?? 0),
      ),
    );
  }
}