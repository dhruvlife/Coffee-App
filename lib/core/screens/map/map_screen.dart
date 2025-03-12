import 'dart:async';
import 'package:figmawc/core/screens/cart/widget/cart_divider.dart';
import 'package:figmawc/core/screens/map/widget/delivery_container.dart';
import 'package:figmawc/core/screens/map/widget/map.dart';
import 'package:figmawc/core/screens/map/widget/map_screen_divider.dart';
import 'package:figmawc/utils/constants/app_colors.dart';
import 'package:figmawc/utils/constants/app_image_strings.dart';
import 'package:figmawc/utils/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
// map
  final Completer<GoogleMapController> _controller = Completer();
  List<Marker> marker = [];
  static final CameraPosition _kGooglePlex =
      const CameraPosition(target: LatLng(23.0903, 72.5329), zoom: 12);

// call
  bool _hasCallSupport = false;
  final String _phone = '9081051076';

  @override
  void initState() {
    marker.addAll(_list);
    canLaunchUrl(Uri(scheme: 'tel', path: '123')).then((bool result) {
      setState(() {
        _hasCallSupport = result;
      });
    });
    super.initState();
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      throw 'Could not launch $launchUri';
    }
  }

  Future<Position> getCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, StackTrace) {
      print("error$error");
    });
    return await Geolocator.getCurrentPosition();
  }

  final List<Marker> _list = [
    Marker(
      draggable: true,
      markerId: const MarkerId("1"),
      infoWindow: const InfoWindow(
        title: "Web Creta",
      ),
      position: const LatLng(23.0903, 72.5329),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          MapWidget(
            kGooglePlex: _kGooglePlex,
            marker: marker,
            controller: _controller,
            onPressed: () {
              print("my current location");
              getCurrentLocation().then(
                (value) async {
                  print("${value.latitude} ${value.longitude}");
                  marker.add(
                    Marker(
                      markerId: MarkerId("2"),
                      position: LatLng(value.latitude, value.longitude),
                      infoWindow: InfoWindow(
                        title: "My Current Location",
                      ),
                    ),
                  );
                  CameraPosition cameraPosition = CameraPosition(
                      target: LatLng(value.latitude, value.longitude),
                      zoom: 14);
                  final GoogleMapController controller =
                      await _controller.future;
                  controller.animateCamera(
                      CameraUpdate.newCameraPosition(cameraPosition));
                  setState(() {});
                },
              );
            },
          ).paddingOnly(bottom: 10.h),
          CartDivider().paddingSymmetric(horizontal: 20.w, vertical: 4.h),
          Text(
            "10 minutes left",
            style: TextStyle(
                fontSize: AppSize.textLarge, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 20.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ActiveContainer(
                  onTap: () {},
                  color: AppColors.darkgreen,
                ),
                ActiveContainer(
                  onTap: () {},
                  color: AppColors.darkgreen,
                ),
                ActiveContainer(
                  onTap: () {},
                  color: AppColors.darkgreen,
                ),
                ActiveContainer(
                  onTap: () {},
                  color: AppColors.light,
                ),
              ],
            ),
          ).paddingSymmetric(horizontal: 20.w, vertical: 8.h),
          DeliveryContainer().paddingSymmetric(horizontal: 20.w, vertical: 4.h),
          SizedBox(
            height: 60.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(
                      AppImageStrings.person,
                      height: 60.h,
                      width: 60.w,
                      fit: BoxFit.fill,
                    ).paddingOnly(right: 20.w),
                    SizedBox(
                      width: 0.4.sw,
                      height: 60.h,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Dhruv Thakkar",
                            style: TextStyle(
                                fontSize: AppSize.textLarge,
                                fontWeight: FontWeight.w400),
                          ),
                          Text(
                            "Personal Contact",
                            style: TextStyle(
                                fontSize: AppSize.textMedium,
                                fontWeight: FontWeight.w300),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                    height: 50.h,
                    width: 50.w,
                    decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius:
                            BorderRadius.circular(AppSize.buttonRadius)),
                    child: IconButton(
                        onPressed: _hasCallSupport
                            ? () => _makePhoneCall(_phone)
                            : null,
                        icon: Icon(
                          Icons.call,
                          color: AppColors.button,
                        )))
              ],
            ),
          ).paddingSymmetric(horizontal: 20.h, vertical: 10.h)
        ],
      ),
    );
  }
}
