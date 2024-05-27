// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:developer';
import 'dart:html';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:ms_register/model/session_data.dart';
import 'package:ms_register/screens/user_name_screen.dart';
import 'package:ms_register/service/storage_provider.dart';

import 'package:ms_register/utils/constants.dart';
import 'package:ms_register/widget/gaps.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ms_register/widget/header.dart';

import '../main.dart';

class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen({super.key, required this.sessionData});
  static const String routePath = '/takePictureScreen';
  final SessionData sessionData;
  @override
  State<TakePictureScreen> createState() => _TakePictureScreenState();
}

class _TakePictureScreenState extends State<TakePictureScreen> {
  bool cameraAccess = false;
  String? error;
  List<CameraDescription>? cameras;

  @override
  void initState() {
    getCameras();
    super.initState();
  }

  Future<void> getCameras() async {
    try {
      await window.navigator.mediaDevices!
          .getUserMedia({'video': true, 'audio': false});
      setState(() {
        cameraAccess = true;
      });
      final cameras = await availableCameras();
      setState(() {
        this.cameras = cameras;
      });
    } on DomException catch (e) {
      setState(() {
        error = '${e.name}: ${e.message}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(context),
    );
  }

  getBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: Constants.defaultPadding,
          horizontal: Constants.defaultPadding * 2),
      child: Column(
        children: [
          const Header(),
          verticalGap(Constants.defaultPadding * 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context)!.promptCamera,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              IconButton(
                onPressed: () {
                  speak(AppLocalizations.of(context)!.promptCamera);
                },
                icon: Icon(Icons.volume_up_sharp),
              )
            ],
          ),
          verticalGap(Constants.defaultPadding),
          Expanded(
            child: buildCamera(context),
          ),
          verticalGap(Constants.defaultPadding),
        ],
      ),
    );
  }

  buildCamera(BuildContext context) {
    if (error != null) {
      return Center(child: Text('Error: $error'));
    }
    if (!cameraAccess) {
      return const Center(child: Text('Camera access not granted yet.'));
    }
    if (cameras == null) {
      return const Center(child: Text('Reading cameras'));
    }
    return CameraView(
      cameras: cameras!,
      sessionData: widget.sessionData,
    );
  }
}

class CameraView extends StatefulWidget {
  final List<CameraDescription> cameras;
  final SessionData sessionData;

  const CameraView({Key? key, required this.cameras, required this.sessionData})
      : super(key: key);

  @override
  _CameraViewState createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  String? error;
  CameraController? controller;
  late CameraDescription cameraDescription = widget.cameras[0];
  bool isUploading = false;

  Future<void> initCam(CameraDescription description) async {
    setState(() {
      controller = CameraController(description, ResolutionPreset.max);
    });

    try {
      await controller!.initialize();
    } catch (e) {
      setState(() {
        error = e.toString();
      });
    }

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    initCam(cameraDescription);
  }

  @override
  void dispose() async {
    await controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isUploading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    if (error != null) {
      return Center(
        child: Text('Initializing error: $error\nCamera list:'),
      );
    }
    if (controller == null) {
      return const Center(child: Text('Loading controller...'));
    }
    if (!controller!.value.isInitialized) {
      return const Center(child: Text('Initializing camera...'));
    }

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(
            onPressed: controller == null
                ? null
                : () async {
                    final file = await controller!.takePicture();
                    final bytes = await file.readAsBytes();

                    final link = AnchorElement(
                        href: Uri.dataFromBytes(bytes, mimeType: 'image/png')
                            .toString());
                    setState(() {
                      isUploading = true;
                    });
                    String url = await StorageProvider.instance.uploadFile(
                        'visitor',
                        '${widget.sessionData.visitor?.mobileNo ?? file.name}.png',
                        bytes);

                    widget.sessionData.visitor?.imagePath = url;
                    setState(() {
                      isUploading = false;
                    });

                    await controller!.pausePreview();

                    Navigator.of(context).pushNamed(UserNameScreen.routePath,
                        arguments: widget.sessionData);
                  },
            tooltip: AppLocalizations.of(context)!.takePicture,
            child: const Icon(Icons.camera_alt),
          ),
        ],
      ),
      // body: SingleChildScrollView(
      //   child: Column(
      //     children: [
      //       AspectRatio(aspectRatio: 9 / 16, child: CameraPreview(controller!)),
      //       verticalGap(Constants.defaultPadding),
      //     ],
      //   ),
      // ),
      body: Center(
          child: AspectRatio(
              aspectRatio: 9 / 16, child: CameraPreview(controller!))),
    );
  }
}
