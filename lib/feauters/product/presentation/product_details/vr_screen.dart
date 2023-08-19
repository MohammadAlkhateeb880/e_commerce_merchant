// import 'package:flutter/material.dart';
// import 'package:model_viewer_plus/model_viewer_plus.dart';
// import '../../../../core/components/my_text.dart';
// import '../../../../core/config/urls.dart';
// import '../../../../core/resources/color_manager.dart';
//
//
// class VRScreen extends StatelessWidget {
//   const VRScreen({
//     Key? key,
//     required this.name,
//     required this.modelUrl,
//   }) : super(key: key);
//
//   final String name;
//   final String modelUrl;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: MText(
//           text: name,
//         ),
//       ),
//       body: ModelViewer(
//         src: Urls.filesUrl + modelUrl,
//         alt: name,
//         ar: true,
//         autoRotate: true,
//         cameraControls: true,
//         backgroundColor: ColorManager.white,
//       ),
//     );
//   }
// }
