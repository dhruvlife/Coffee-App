import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ActiveContainer extends StatelessWidget {
  final VoidCallback onTap;
  final Color color;
  const ActiveContainer({
    super.key, required this.onTap, required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(500.r,),
        ),
        height: 6.h,
        width: 70.w,
                    
      ),
    );
  }
}
