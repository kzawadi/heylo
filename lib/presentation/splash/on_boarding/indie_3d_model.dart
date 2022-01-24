import 'package:flutter/material.dart';
import 'package:zawadi/presentation/splash/on_boarding/indie_3d_model_controller.dart';
import 'package:zawadi/shared/on_boarding/widget_model.dart';

// import 'package:shared/ui/widget_model.dart';

// import './indie_3d_model_controller.dart';

class Indie3dModel extends StatelessWidget {
  const Indie3dModel({this.controller, this.pageIndex = 0, Key? key})
      : super(key: key);

  final Indie3dModelController? controller;
  final int pageIndex;
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: controller!.meshInstances.isNotEmpty
          ? <int>[0, 1, 2, 3, 4, 5].map((int index) {
              return CustomPaint(
                painter: MeshCustomPainter(
                  controller!.meshInstances[pageIndex * 6 + index],
                ),
              );
            }).toList()
          : [],
    );
  }
}
