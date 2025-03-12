import 'dart:async';
import 'package:figmawc/utils/constants/app_colors.dart';
import 'package:figmawc/utils/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapWidget extends StatelessWidget {
  final CameraPosition _kGooglePlex;
  final List<Marker> _marker;
  final Completer<GoogleMapController> _controller;
  final VoidCallback onPressed;
  const MapWidget({
    super.key,
    required CameraPosition kGooglePlex,
    required List<Marker> marker,
    required Completer<GoogleMapController> controller,
    required this.onPressed,
  })  : _kGooglePlex = kGooglePlex,
        _marker = marker,
        _controller = controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.45.sh,
      width: double.infinity,
      decoration: BoxDecoration(
          color: AppColors.extraLight,
          borderRadius: BorderRadius.circular(AppSize.buttonRadius)),
      child: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: _kGooglePlex,
            myLocationEnabled: true,
            markers: Set.of(_marker),
            myLocationButtonEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ).paddingAll(10.sp),
          Positioned(
            right: 15.w,
            top: 15.h,
            child: Container(
              decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(AppSize.buttonRadius)),
              child: IconButton(
                onPressed: onPressed,
                icon: Icon(
                  Icons.my_location,
                  color: AppColors.button,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
